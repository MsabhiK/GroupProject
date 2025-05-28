package com.taxi.controllers;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.taxi.models.Car;
import com.taxi.models.LoginUser;
import com.taxi.models.Ride;
import com.taxi.models.User;
import com.taxi.models.UserRole;
import com.taxi.repository.CarRepository;
import com.taxi.services.CarService;
import com.taxi.services.RideService;
import com.taxi.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class TaxiController {

    @Autowired
    private UserService userService;
    @Autowired
    private CarRepository carRepository;
    
    @Autowired
    private RideService rideService;
    
    @Autowired
    private CarService carService;

    @PostMapping("/register")
    public String register(@Valid @ModelAttribute("newUser") User newUser, 
                           BindingResult result, Model model, HttpSession session) {
        
        // Check basic validation errors first (empty fields, etc.)
        if(result.hasErrors()) {
            model.addAttribute("loginUser", new LoginUser());
            return "index.jsp";
        }
        
        // Call service method for business logic validation
        User user = userService.register(newUser, result);
        
        // Check if service found additional errors (email exists, passwords don't match)
        if(result.hasErrors()) {
            model.addAttribute("loginUser", new LoginUser());
            return "index.jsp";
        }
        
        // Success - user was created
        session.setAttribute("userId", user.getId());
        return "redirect:/select-role";
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("loginUser", new LoginUser());
        return "index.jsp";
    }

    @PostMapping("/login")
    public String login(@Valid @ModelAttribute("loginUser") LoginUser loginUser,
                        BindingResult result,
                        Model model, 
                        HttpSession session) {
        if(result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        }

        User user = userService.login(loginUser, result);
        if(user == null) {
            model.addAttribute("newUser", new User());
            return "index.jsp";
        } else {
            session.setAttribute("userId", user.getId());
            if(!user.isRoleSelected()) {
                return "redirect:/select-role";
            }
            return "redirect:/home";
        }
    }

    @GetMapping("/select-role")
    public String selectRole(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        model.addAttribute("user", user);
        return "select-role.jsp";
    }

    @PostMapping("/update-role")
    public String updateRole(@RequestParam("role") String roleString, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        UserRole role = UserRole.valueOf(roleString);
        userService.updateUserRole(userId, role);
        return "redirect:/home";
    }

    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        model.addAttribute("user", user);
        return "home.jsp";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        model.addAttribute("user", user);
        return "profile.jsp";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@Valid @ModelAttribute("user") User updatedUser,
                                BindingResult result, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        if(result.hasErrors()) {
        	System.out.println(result.getAllErrors());
            return "profile.jsp";
        }
        updatedUser.setId(userId);
        userService.updateProfile(updatedUser);
        return "redirect:/profile";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
       
    // Display create car form
    @GetMapping("/create-car")
    public String showCreateCarForm(HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get user and verify role
        User user = userService.findById(userId);
        if(user == null || (!user.isDriver() && user.getRole() != com.taxi.models.UserRole.BOTH)) {
            return "redirect:/home";
        }
        
        // Add empty car model for form binding
        if(!model.containsAttribute("car")) {
            model.addAttribute("car", new Car());
        }
        model.addAttribute("user", user);
        
        return "create-car.jsp";
    }
    
    // Process car creation
    @PostMapping("/create-car")
    public String createCar(@Valid @ModelAttribute("car") Car car,
                            BindingResult result,
                            HttpSession session,
                            RedirectAttributes redirectAttributes,
                            Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Validate form
        if(result.hasErrors()) {
            model.addAttribute("user", userService.findById(userId));
            return "create-car.jsp";
        }
        
        // Create car
        Car savedCar = carService.createCar(car, userId, result);
        
        // If there were validation errors in the service
        if(result.hasErrors()) {
            model.addAttribute("user", userService.findById(userId));
            return "create-car.jsp";
        }
        
        redirectAttributes.addFlashAttribute("successMessage", "Your car has been successfully added!");
        return "redirect:/my-cars";
    }
    
    // Show all cars for current user
    @GetMapping("/my-cars")
    public String showMyCars(HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get user and verify role
        User user = userService.findById(userId);
        if(user == null || (!user.isDriver() && user.getRole() != com.taxi.models.UserRole.BOTH)) {
            return "redirect:/home";
        }
        
        // Get all cars for user
        model.addAttribute("cars", carService.getCarsForDriver(userId));
        model.addAttribute("user", user);
        
        return "my-cars.jsp";
    }
    
    // Show edit car form
    @GetMapping("/edit-car/{id}")
    public String showEditCarForm(@PathVariable("id") Long carId,
                                  HttpSession session,
                                  Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get car and check ownership
        Car car = carService.findById(carId);
        if(car == null || !car.getDriver().getId().equals(userId)) {
            return "redirect:/my-cars";
        }
        
        model.addAttribute("car", car);
        model.addAttribute("user", userService.findById(userId));
        
        return "edit-car.jsp";
    }
    
    // Process car update
    @PostMapping("/update-car/{id}")
    public String updateCar(@PathVariable("id") Long carId,
                            @Valid @ModelAttribute("car") Car car,
                            BindingResult result,
                            HttpSession session,
                            Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get original car and check ownership
        Car originalCar = carService.findById(carId);
        if(originalCar == null || !originalCar.getDriver().getId().equals(userId)) {
            return "redirect:/my-cars";
        }
        
        // Validate form
        if(result.hasErrors()) {
            model.addAttribute("user", userService.findById(userId));
            return "edit-car.jsp";
        }
        
        // Set ID and driver to ensure they're not changed
        car.setId(carId);
        car.setDriver(originalCar.getDriver());
        
        // Update car
        carService.updateCar(car);
        
        return "redirect:/my-cars";
    }
    
    // Delete car
    @GetMapping("/delete-car/{id}")
    public String deleteCar(@PathVariable("id") Long carId,
                            HttpSession session) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get car and check ownership
        Car car = carService.findById(carId);
        if(car == null || !car.getDriver().getId().equals(userId)) {
            return "redirect:/my-cars";
        }
        
        // Delete car
        carService.deleteCar(carId);
        
        return "redirect:/my-cars";
    }
    
    // Find Rides page
    @GetMapping("/find-rides")
    public String findRides(HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        
        // Get all available rides
        List<Ride> availableRides = rideService.getAvailableRides();
        model.addAttribute("availableRides", availableRides);
        model.addAttribute("user", user);
        
        return "find-rides.jsp";
    }
    
 // Search rides - FIXED VERSION
    @GetMapping("/search-rides")
    public String searchRides(
            @RequestParam(value = "origin", required = false) String origin,
            @RequestParam(value = "destination", required = false) String destination,
            @RequestParam(value = "date", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date, // Changed to LocalDate
            HttpSession session, Model model) {
        
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        
        // Filter available rides based on search criteria
        List<Ride> availableRides = rideService.getAvailableRides();
        
        // Filter by origin if provided
        if(origin != null && !origin.isEmpty()) {
            availableRides = availableRides.stream()
                .filter(ride -> ride.getOrigin().toLowerCase().contains(origin.toLowerCase()))
                .toList();
        }
        
        // Filter by destination if provided
        if(destination != null && !destination.isEmpty()) {
            availableRides = availableRides.stream()
                .filter(ride -> ride.getDestination().toLowerCase().contains(destination.toLowerCase()))
                .toList();
        }
        
        // Filter by date if provided - FIXED
        if(date != null) {
            final LocalDateTime startOfDay = date.atStartOfDay(); // Convert LocalDate to LocalDateTime
            final LocalDateTime endOfDay = date.plusDays(1).atStartOfDay();
            
            availableRides = availableRides.stream()
                .filter(ride -> ride.getDepartureTime().isAfter(startOfDay) && 
                                ride.getDepartureTime().isBefore(endOfDay))
                .toList();
        }
        
        model.addAttribute("availableRides", availableRides);
        model.addAttribute("user", user);
        model.addAttribute("origin", origin);
        model.addAttribute("destination", destination);
        model.addAttribute("date", date);
        
        return "find-rides.jsp";
    }
    
    // View ride details
    @GetMapping("/rides/{id}")
    public String viewRide(@PathVariable("id") Long rideId, HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        
        Ride ride = rideService.findById(rideId);
        if(ride == null) {
            return "redirect:/find-rides";
        }
        
        model.addAttribute("ride", ride);
        model.addAttribute("user", user);
        
        // Check if user is already in the passenger list
        boolean isPassenger = ride.getPassengers().stream()
                .anyMatch(passenger -> passenger.getId().equals(userId));
        model.addAttribute("isPassenger", isPassenger);
        
        // Check if user is the driver
        boolean isDriver = ride.getCar().getDriver().getId().equals(userId);
        model.addAttribute("isDriver", isDriver);
        
        return "ride-details.jsp";
    }
    
    // Join a ride
    @PostMapping("/rides/{id}/join")
    public String joinRide(@PathVariable("id") Long rideId, HttpSession session) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        boolean joined = rideService.joinRide(rideId, userId);
        
        return "redirect:/rides/" + rideId;
    }
    
    // Leave a ride
    @PostMapping("/rides/{id}/leave")
    public String leaveRide(@PathVariable("id") Long rideId, HttpSession session) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        boolean left = rideService.leaveRide(rideId, userId);
        
        return "redirect:/rides/" + rideId;
    }
    
    // My rides page
    @GetMapping("/my-rides")
    public String myRides(HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        
        List<Ride> driverRides = null;
        List<Ride> passengerRides = null;
        
        if(user.getRole().equals(UserRole.DRIVER) || user.getRole().equals(UserRole.BOTH)) {
            driverRides = rideService.getRidesForDriver(userId);
        }
        
        if(user.getRole().equals(UserRole.PASSENGER) || user.getRole().equals(UserRole.BOTH)) {
            passengerRides = rideService.getRidesForPassenger(userId);
        }
        model.addAttribute("rides", rideService.getAllRides());
        model.addAttribute("user", user);
        model.addAttribute("driverRides", driverRides);
        model.addAttribute("passengerRides", passengerRides);
        
        return "my-rides.jsp";
    }
    
    // Cancel a ride
    @PostMapping("/rides/{id}/cancel")
    public String cancelRide(@PathVariable("id") Long rideId, HttpSession session) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        Ride canceledRide = rideService.cancelRide(rideId, userId);
        
        return "redirect:/my-rides";
    }
    
    // View ride history
    @GetMapping("/ride-history")
    public String rideHistory(HttpSession session, Model model) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        User user = userService.findById(userId);
        if(user == null) {
            return "redirect:/";
        }
        
        List<Ride> completedRides = null;
        
        if(user.getRole().equals(UserRole.DRIVER) || user.getRole().equals(UserRole.BOTH)) {
            List<Ride> driverRides = rideService.getRidesForDriver(userId);
            completedRides = driverRides.stream()
                    .filter(ride -> ride.getStatus().equals("COMPLETED"))
                    .toList();
        } else {
            List<Ride> passengerRides = rideService.getRidesForPassenger(userId);
            completedRides = passengerRides.stream()
                    .filter(ride -> ride.getStatus().equals("COMPLETED"))
                    .toList();
        }
        
        model.addAttribute("user", user);
        model.addAttribute("completedRides", completedRides);
        
        return "ride-history.jsp";
    }
    
    @GetMapping("/rides/createRide")
    public String newRide(Model model) {
        model.addAttribute("ride", new Ride());
        
        // Récupérer toutes les voitures pour le dropdown
        List<Car> cars = (List<Car>) carRepository.findAll();
        model.addAttribute("cars", cars);
        
        return "createRide.jsp";
    }

    // Traiter le formulaire de création de course
    @PostMapping("/rides/create")
    public String createRide(
            @Valid @ModelAttribute("ride") Ride ride,           
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {
        
        // Si des erreurs de validation existent, réafficher le formulaire
        if (result.hasErrors()) {
            // Récupérer toutes les voitures pour le dropdown
            List<Car> cars = (List<Car>) carRepository.findAll();
            model.addAttribute("cars", cars);
            return "createRide.jsp";
        }
        
        // Créer la course via le service
        Ride createdRide = rideService.createRide(ride, result);
  
        // Vérifier si la création a échoué en raison d'une voiture introuvable
        if (createdRide == null) {
            model.addAttribute("carError", "Veuillez sélectionner une voiture valide");
            // Récupérer toutes les voitures pour le dropdown
            List<Car> cars = (List<Car>) carRepository.findAll();
            model.addAttribute("cars", cars);
            return "createRide.jsp";
        }
      
        redirectAttributes.addFlashAttribute("success", "Course créée avec succès!");
        return "redirect:/home";
    }
    
 // Delete ride
    @GetMapping("/delete-ride/{id}")
    public String deleteRide(@PathVariable("id") Long rideId,
                            HttpSession session) {
        // Check if user is logged in
        Long userId = (Long) session.getAttribute("userId");
        if(userId == null) {
            return "redirect:/";
        }
        
        // Get car and check ownership
        Ride ride = rideService.findById(rideId);
        if(ride == null) {
            return "redirect:/my-rides";
        }
        
        // Delete car
        rideService.deleteRide(rideId);
        
        return "redirect:/my-rides";
    }
}
