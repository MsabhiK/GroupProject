package com.taxi.services;


import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.taxi.models.Car;
import com.taxi.models.User;
import com.taxi.repository.CarRepository;
import com.taxi.repository.UserRepository;

@Service
public class CarService {
    @Autowired
    private CarRepository carRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    // Create a new car
    public Car createCar(Car car, Long driverId, BindingResult result) {
        Optional<User> optionalDriver = userRepository.findById(driverId);
        
        if(!optionalDriver.isPresent()) {
            result.rejectValue("driver", "Invalid", "Driver not found");
            return null;
        }
        
        User driver = optionalDriver.get();
        
        if(!driver.isDriver()) {
            result.rejectValue("driver", "Invalid", "User is not registered as a driver");
            return null;
        }
        
        car.setDriver(driver);
        return carRepository.save(car);
    }
    
    // Get car by ID
    public Car findById(Long id) {
        Optional<Car> optionalCar = carRepository.findById(id);
        return optionalCar.orElse(null);
    }
    
    // Get all cars for a driver
    public List<Car> getCarsForDriver(Long driverId) {
        Optional<User> optionalDriver = userRepository.findById(driverId);
        
        if(optionalDriver.isPresent()) {
            User driver = optionalDriver.get();
            return carRepository.findByDriver(driver);
        }
        
        return null;
    }
    
    // Get cars by city
    public List<Car> getCarsByCity(String city) {
        return carRepository.findByCity(city);
    }
    
    // Update car information
    public Car updateCar(Car updatedCar) {
        Optional<Car> optionalCar = carRepository.findById(updatedCar.getId());
        
        if(optionalCar.isPresent()) {
            Car car = optionalCar.get();
            car.setModel(updatedCar.getModel());
            car.setLicensePlate(updatedCar.getLicensePlate());
            car.setCity(updatedCar.getCity());
            car.setMaxRiders(updatedCar.getMaxRiders());
            
            return carRepository.save(car);
        }
        
        return null;
    }
    
    // Delete car
    public void deleteCar(Long carId) {
        carRepository.deleteById(carId);
    }
    
    // Get all cars
    public List<Car> getAllCars() {
        return (List<Car>) carRepository.findAll();
    }
}