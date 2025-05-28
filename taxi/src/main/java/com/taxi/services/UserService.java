package com.taxi.services;

import java.util.Optional;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import com.taxi.models.LoginUser;
import com.taxi.models.User;
import com.taxi.models.UserRole;
import com.taxi.repository.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
       
    @Autowired
    private EntityManager entityManager;
    
    public UserService(UserRepository userRepository, EntityManager entityManager) {
    	this.userRepository=userRepository;
    	this.entityManager=entityManager;
    }
    
    public User register(User newUser, BindingResult result) {
        // Check if email already exists
        if(userRepository.existsByEmail(newUser.getEmail())) {
            result.rejectValue("email", "Unique", "Email already in use!");
            return null;
        }
        
        // Check if passwords match
        if(!newUser.getPassword().equals(newUser.getConfirm())) {
            result.rejectValue("confirm", "Matches", "Passwords must match!");
            return null;
        }
        
        // CHECK FOR ANY VALIDATION ERRORS BEFORE SAVING
        if(result.hasErrors()) {
            return null;
        }
        
        // Hash password and save only if no errors
        String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
        newUser.setPassword(hashed);
        newUser.setRoleSelected(false);
        
        return userRepository.save(newUser);
    }
    
    public User login(LoginUser loginUser, BindingResult result) {
        if(result.hasErrors()) {
            return null;
        }
        Optional<User> potentialUser = userRepository.findByEmail(loginUser.getEmail());
        if(!potentialUser.isPresent()) {
            result.rejectValue("email", "Invalid", "Invalid email/password!");
            return null;
        }
        User user = potentialUser.get();
        if(!BCrypt.checkpw(loginUser.getPassword(), user.getPassword())) {
            result.rejectValue("password", "Invalid", "Invalid email/password!");
            return null;
        }
        return user;
    }
    
    @Transactional
    public User updateUserRole(Long userId, UserRole role) {
        int updatedRows = entityManager.createQuery(
            "UPDATE User u SET u.role = :role, u.roleSelected = true, " +
            "u.isDriver = :isDriver WHERE u.id = :userId")
            .setParameter("role", role)
            .setParameter("isDriver", role == UserRole.DRIVER || role == UserRole.BOTH)
            .setParameter("userId", userId)
            .executeUpdate();
        
        if (updatedRows > 0) {
            return findById(userId);
        }
        return null;
    }
    
    public User findById(Long id) {
        Optional<User> optionalUser = userRepository.findById(id);
        return optionalUser.orElse(null);
    }
    
    public User updateProfile(User updatedUser) {
        Optional<User> optionalUser = userRepository.findById(updatedUser.getId());
        if(optionalUser.isPresent()) {
            User user = optionalUser.get();
            user.setFirstName(updatedUser.getFirstName());
            user.setLastName(updatedUser.getLastName());
            user.setPhoneNumber(updatedUser.getPhoneNumber());
            return userRepository.save(user);
        }
        return null;
    }
}
