package com.taxi.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.taxi.models.User;
import com.taxi.models.UserRole;
import com.taxi.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

public class TaxiController {

	  @Autowired
	    private UserService userService;
	    
	    // Display registration and login page
	    @GetMapping("/")
	    public String index(Model model) {
	        model.addAttribute("newUser", new User());
	        return "index";
	    }
	    
	    // Register a new user
	    @PostMapping("/register")
	    public String register(@Valid @ModelAttribute("newUser") User newUser, 
	                          BindingResult result, Model model, HttpSession session) {
	        
	        User user = userService.register(newUser, result);
	        
	        if(result.hasErrors()) {
	            model.addAttribute("newUser", newUser);
	            return "index";
	        } else {
	            session.setAttribute("userId", user.getId());
	            return "redirect:/select-role";
	        }
	    }
	    
	    // Login user
	    @PostMapping("/login")
	    public String login(@RequestParam("email") String email, 
	                       @RequestParam("password") String password,
	                       Model model, HttpSession session) {
	        
	        User user = userService.login(email, password);
	        
	        if(user == null) {
	            model.addAttribute("loginError", "Invalid email or password");
	            model.addAttribute("newUser", new User());
	            return "index";
	        } else {
	            session.setAttribute("userId", user.getId());
	            
	            // Check if user has selected a role
	            if(!user.isRoleSelected()) {
	                return "redirect:/select-role";
	            }
	            
	            return "redirect:/home";
	        }
	    }
	    
	    // Display role selection page
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
	        return "select-role";
	    }
	    
	    // Update user role
	    @PostMapping("/update-role")
	    public String updateRole(@RequestParam("role") String roleString, 
	                            HttpSession session) {
	        
	        Long userId = (Long) session.getAttribute("userId");
	        
	        if(userId == null) {
	            return "redirect:/";
	        }
	        
	        UserRole role = UserRole.valueOf(roleString);
	        userService.updateUserRole(userId, role);
	        
	        return "redirect:/home";
	    }
	    
	    // Display home page
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
	        return "home";
	    }
	    
	    // Display profile page
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
	        return "profile";
	    }
	    
	    // Update profile
	    @PostMapping("/update-profile")
	    public String updateProfile(@Valid @ModelAttribute("user") User updatedUser,
	                               BindingResult result, HttpSession session) {
	        
	        Long userId = (Long) session.getAttribute("userId");
	        
	        if(userId == null) {
	            return "redirect:/";
	        }
	        
	        if(result.hasErrors()) {
	            return "profile";
	        }
	        
	        updatedUser.setId(userId);
	        userService.updateProfile(updatedUser);
	        
	        return "redirect:/profile";
	    }
	    
	    // Logout
	    @GetMapping("/logout")
	    public String logout(HttpSession session) {
	        session.invalidate();
	        return "redirect:/";
	    }
}
