package com.taxi.repository;




import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.taxi.models.Car;
import com.taxi.models.User;

@Repository
public interface CarRepository extends CrudRepository<Car, Long> {
    List<Car> findByDriver(User driver);
    List<Car> findByCity(String city);
    List<Car> findByDriverAndCity(User driver, String city);
}