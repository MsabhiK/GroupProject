package com.taxi.services;




import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.taxi.models.Car;
import com.taxi.models.Ride;
import com.taxi.models.User;
import com.taxi.repository.CarRepository;
import com.taxi.repository.RideRepository;
import com.taxi.repository.UserRepository;

@Service
public class RideService {
    
    @Autowired
    private RideRepository rideRepository;
    
    @Autowired
    private CarRepository carRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    // Create a new ride
    public Ride createRide(Ride ride, Long carId, BindingResult result) {
        Optional<Car> optionalCar = carRepository.findById(carId);
        
        if(!optionalCar.isPresent()) {
            result.rejectValue("car", "Invalid", "Car not found");
            return null;
        }
        
        Car car = optionalCar.get();
        ride.setCar(car);
        ride.setStatus("SCHEDULED");
        
        return rideRepository.save(ride);
    }
    
    // Get ride by ID
    public Ride findById(Long id) {
        Optional<Ride> optionalRide = rideRepository.findById(id);
        return optionalRide.orElse(null);
    }
    
    // Join a ride as passenger
    public boolean joinRide(Long rideId, Long passengerId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        Optional<User> optionalPassenger = userRepository.findById(passengerId);
        
        if(!optionalRide.isPresent() || !optionalPassenger.isPresent()) {
            return false;
        }
        
        Ride ride = optionalRide.get();
        User passenger = optionalPassenger.get();
        
        // Check if ride has available space
        if(ride.getPassengers().size() >= ride.getCar().getMaxRiders()) {
            return false;
        }
        
        // Check if user is already a passenger
        if(ride.getPassengers().contains(passenger)) {
            return false;
        }
        
        // Add passenger to ride
        ride.getPassengers().add(passenger);
        rideRepository.save(ride);
        
        return true;
    }
    
    // Leave a ride
    public boolean leaveRide(Long rideId, Long passengerId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        Optional<User> optionalPassenger = userRepository.findById(passengerId);
        
        if(!optionalRide.isPresent() || !optionalPassenger.isPresent()) {
            return false;
        }
        
        Ride ride = optionalRide.get();
        User passenger = optionalPassenger.get();
        
        // Remove passenger from ride
        ride.getPassengers().remove(passenger);
        rideRepository.save(ride);
        
        return true;
    }
    
    // Update ride status
    public Ride updateRideStatus(Long rideId, String status) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        
        if(optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            ride.setStatus(status);
            return rideRepository.save(ride);
        }
        
        return null;
    }
    
    // Get rides for driver
    public List<Ride> getRidesForDriver(Long driverId) {
        Optional<User> optionalDriver = userRepository.findById(driverId);
        
        if(optionalDriver.isPresent()) {
            return rideRepository.findByDriver(optionalDriver.get());
        }
        
        return null;
    }
    
    // Get rides for passenger
    public List<Ride> getRidesForPassenger(Long passengerId) {
        Optional<User> optionalPassenger = userRepository.findById(passengerId);
        
        if(optionalPassenger.isPresent()) {
            return rideRepository.findByPassenger(optionalPassenger.get());
        }
        
        return null;
    }
    
    // Search rides by city
    public List<Ride> searchRidesByCity(String city) {
        return rideRepository.findByOriginOrDestinationContaining(city);
    }
    
    // Get available rides (future, scheduled rides)
    public List<Ride> getAvailableRides() {
        return rideRepository.findByStatusAndDepartureTimeAfter("SCHEDULED", LocalDateTime.now());
    }
    
    // Get all rides
    public List<Ride> getAllRides() {
        return (List<Ride>) rideRepository.findAll();
    }
    
    // Cancel ride
    public Ride cancelRide(Long rideId, Long driverId) {
        Optional<Ride> optionalRide = rideRepository.findById(rideId);
        
        if(optionalRide.isPresent()) {
            Ride ride = optionalRide.get();
            
            // Check if the user is the driver of this ride
            if(ride.getCar().getDriver().getId().equals(driverId)) {
                ride.setStatus("CANCELED");
                return rideRepository.save(ride);
            }
        }
        
        return null;
    }
    
    // Delete ride
    public void deleteRide(Long rideId) {
        rideRepository.deleteById(rideId);
    }
}