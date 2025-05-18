package com.taxi.services;


import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.taxi.models.User;
import com.taxi.models.UserRole;
import com.taxi.repository.UserRepository;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    
    // Register a new user
    public User register(User newUser, BindingResult result) {
        // Check if email already exists
        if(userRepository.existsByEmail(newUser.getEmail())) {
            result.rejectValue("email", "Unique", "Email already in use!");
            return null;
        }
        
        // Check if password and confirm match
        if(!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "Passwords must match!");
            return null;
        }
        
        // Hash password and save user
        String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashed);
        newUser.setRoleSelected(false);
        
        return userRepository.save(newUser);
    }
    
    // Login user
    public User login(String email, String password, BindingResult result) {
        Optional<User> potentialUser = userRepository.findByEmail(email);
        
        // Check if user exists
        if(!potentialUser.isPresent()) {
            result.rejectValue("email", "Invalid", "Invalid email/password!");
            return null;
        }
        
        User user = potentialUser.get();
        
        // Check if password matches
        if(!BCrypt.checkpw(password, user.getPassword())) {
            result.rejectValue("password", "Invalid", "Invalid email/password!");
            return null;
        }
        
        return user;
    }
    
    // Update user role
    public User updateUserRole(Long userId, UserRole role) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setRole(role);
            user.setRoleSelected(true);
            
            // If role is DRIVER or BOTH, set isDriver to true
            if(role == UserRole.DRIVER || role == UserRole.BOTH) {
                user.setDriver(true);
            } else {
                user.setDriver(false);
            }
            
            return userRepository.save(user);
        }
        
        return null;
    }
    
    // Get user by ID
    public User findById(Long id) {
        Optional<User> optionalUser = userRepository.findById(id);
        return optionalUser.orElse(null);
    }
    
    // Update user profile
    public User updateProfile(User updatedUser) {
        Optional<User> optionalUser = userRepository.findById(updatedUser.getId());
        
        if(optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setFirstName(updatedUser.getFirstName());
            user.setLastName(updatedUser.getLastName());
            user.setPhoneNumber(updatedUser.getPhoneNumber());
            
            // Don't update email or password here
            
            return userRepository.save(user);
        }
        
        return null;
    }
    
    // Update user password
    public User updatePassword(Long userId, String oldPassword, String newPassword, String confirm, BindingResult result) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(!optionalUser.isPresent()) {
            return null;
        }
        
        User user = optionalUser.get();
        
        // Check if old password is correct
        if(!BCrypt.checkpw(oldPassword, user.getPassword())) {
            result.rejectValue("password", "Invalid", "Current password is incorrect!");
            return null;
        }
        
        // Check if new password and confirm match
        if(!newPassword.equals(confirm)) {
            result.rejectValue("confirm", "Matches", "New passwords must match!");
            return null;
        }
        
        // Hash and save new password
        String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        user.setPassword(hashed);
        
        return userRepository.save(user);
    }
    
    // Find all drivers
    public List<User> findAllDrivers() {
        return userRepository.findByIsDriver(true);
    }
    
    // Find users by role
    public List<User> findByRole(UserRole role) {
        return userRepository.findByRole(role);
    }
}