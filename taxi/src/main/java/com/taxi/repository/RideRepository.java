package com.taxi.repository;



import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.taxi.models.Car;
import com.taxi.models.Ride;
import com.taxi.models.User;

@Repository
public interface RideRepository extends CrudRepository<Ride, Long> {
	List<Ride> findAll();
    List<Ride> findByCar(Car car);
    List<Ride> findByStatus(String status);
    List<Ride> findByStatusAndDepartureTimeAfter(String status, LocalDateTime time);
    
    @Query("SELECT r FROM Ride r JOIN r.passengers p WHERE p = :passenger")
    List<Ride> findByPassenger(@Param("passenger") User passenger);
    
    @Query("SELECT r FROM Ride r JOIN r.car c JOIN c.driver d WHERE d = :driver")
    List<Ride> findByDriver(@Param("driver") User driver);
    
    @Query("SELECT r FROM Ride r WHERE r.origin LIKE %:city% OR r.destination LIKE %:city%")
    List<Ride> findByOriginOrDestinationContaining(@Param("city") String city);
}