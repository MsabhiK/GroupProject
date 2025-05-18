package com.taxi.models;


import java.util.List;

import javax.management.Notification;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotEmpty(message="First name is required!")
    @Size(min=2, max=30, message="First name must be between 2 and 30 characters")
    private String firstName;
    
    @NotEmpty(message="Last name is required!")
    @Size(min=2, max=30, message="Last name must be between 2 and 30 characters")
    private String lastName;
    
    @NotEmpty(message="Email is required!")
    @Email(message="Please enter a valid email!")
    private String email;
    
    @NotEmpty(message="Password is required!")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters")
    private String password;
    
    @Transient
    @NotEmpty(message="Confirm Password is required!")
    @Size(min=8, max=128, message="Confirm Password must be between 8 and 128 characters")
    private String confirm;
    
    @NotEmpty(message="Phone number is required!")
    @Size(min=8, max=15, message="Phone number must be between 8 and 15 characters")
    private String phoneNumber;
    
    private boolean isDriver;
    
    @Enumerated(EnumType.STRING)
    private UserRole role;
    
    private boolean roleSelected;
    
    @OneToMany(mappedBy = "driver", fetch = FetchType.LAZY)
    private List<Car> cars;
    
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Notification> notifications;
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirm() {
        return confirm;
    }

    public void setConfirm(String confirm) {
        this.confirm = confirm;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public boolean isDriver() {
        return isDriver;
    }

    public void setDriver(boolean isDriver) {
        this.isDriver = isDriver;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public boolean isRoleSelected() {
        return roleSelected;
    }

    public void setRoleSelected(boolean roleSelected) {
        this.roleSelected = roleSelected;
    }

    public List<Car> getCars() {
        return cars;
    }

    public void setCars(List<Car> cars) {
        this.cars = cars;
    }

    public List<Notification> getNotifications() {
        return notifications;
    }

    public void setNotifications(List<Notification> notifications) {
        this.notifications = notifications;
    }

    public User() {}
    
    // Helper method to get full name
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
}
