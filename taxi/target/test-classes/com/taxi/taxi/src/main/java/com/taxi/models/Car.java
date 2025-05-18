package com.taxi.models;


import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="cars")
public class Car {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotEmpty(message="Model is required!")
    @Size(min=2, max=50, message="Model must be between 2 and 50 characters")
    private String model;
    
    @NotEmpty(message="License plate is required!")
    @Size(max=20, message="License plate must be less than 20 characters")
    @Column(nullable = false)
    private String licensePlate;
    
    @NotEmpty(message="City is required!")
    @Size(max=50, message="City must be less than 50 characters")
    @Column(nullable = false)
    private String city;
    
    @NotNull(message="Maximum number of riders is required!")
    private Integer maxRiders;
    
    @ManyToOne
    @JoinColumn(name = "driver_id")
    private User driver;
    
    @OneToMany(mappedBy = "car")
    private List<Ride> rides;
    
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Integer getMaxRiders() {
        return maxRiders;
    }

    public void setMaxRiders(Integer maxRiders) {
        this.maxRiders = maxRiders;
    }

    public User getDriver() {
        return driver;
    }

    public void setDriver(User driver) {
        this.driver = driver;
    }
    
    public List<Ride> getRides() {
        return rides;
    }

    public void setRides(List<Ride> rides) {
        this.rides = rides;
    }

    public Car() {}
}