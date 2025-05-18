package com.taxi.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.taxi.models.Notification;
import com.taxi.models.User;

@Repository
public interface NotificationRepository extends CrudRepository<Notification, Long> {
    List<Notification> findByUserOrderByCreatedAtDesc(User user);
    long countByUserAndIsReadFalse(User user);
    List<Notification> findByUserAndIsReadFalse(User user);
}