package com.taxi.services;



import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taxi.models.Notification;
import com.taxi.models.User;
import com.taxi.repository.NotificationRepository;
import com.taxi.repository.UserRepository;

@Service
public class NotificationService {
    
    @Autowired
    private NotificationRepository notificationRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    // Create a notification
    public Notification createNotification(Long userId, String message) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(optionalUser.isPresent()) {
            Notification notification = new Notification();
            notification.setUser(optionalUser.get());
            notification.setMessage(message);
            notification.setCreatedAt(LocalDateTime.now());
            notification.setRead(false);
            
            return notificationRepository.save(notification);
        }
        
        return null;
    }
    
    // Get all notifications for a user
    public List<Notification> getNotificationsForUser(Long userId) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(optionalUser.isPresent()) {
            return notificationRepository.findByUserOrderByCreatedAtDesc(optionalUser.get());
        }
        
        return null;
    }
    
    // Get unread notifications for a user
    public List<Notification> getUnreadNotificationsForUser(Long userId) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(optionalUser.isPresent()) {
            return notificationRepository.findByUserAndIsReadFalse(optionalUser.get());
        }
        
        return null;
    }
    
    // Count unread notifications for a user
    public long countUnreadNotificationsForUser(Long userId) {
        Optional<User> optionalUser = userRepository.findById(userId);
        
        if(optionalUser.isPresent()) {
            return notificationRepository.countByUserAndIsReadFalse(optionalUser.get());
        }
        
        return 0;
    }
    
    // Mark notification as read
    public Notification markAsRead(Long notificationId) {
        Optional<Notification> optionalNotification = notificationRepository.findById(notificationId);
        
        if(optionalNotification.isPresent()) {
            Notification notification = optionalNotification.get();
            notification.setRead(true);
            return notificationRepository.save(notification);
        }
        
        return null;
    }
    
    // Mark all notifications as read for a user
    public void markAllAsReadForUser(Long userId) {
        List<Notification> unreadNotifications = getUnreadNotificationsForUser(userId);
        
        if(unreadNotifications != null) {
            for(Notification notification : unreadNotifications) {
                notification.setRead(true);
                notificationRepository.save(notification);
            }
        }
    }
    
    // Delete notification
    public void deleteNotification(Long notificationId) {
        notificationRepository.deleteById(notificationId);
    }
    
    // Send notification when user joins a ride
    public void notifyRideJoined(Long driverId, String passengerName, String origin, String destination) {
        String message = passengerName + " has joined your ride from " + origin + " to " + destination;
        createNotification(driverId, message);
    }
    
    // Send notification when user leaves a ride
    public void notifyRideLeft(Long driverId, String passengerName, String origin, String destination) {
        String message = passengerName + " has left your ride from " + origin + " to " + destination;
        createNotification(driverId, message);
    }
    
    // Send notification when ride is canceled
    public void notifyRideCanceled(List<Long> passengerIds, String origin, String destination) {
        String message = "The ride from " + origin + " to " + destination + " has been canceled by the driver";
        
        for(Long passengerId : passengerIds) {
            createNotification(passengerId, message);
        }
    }
}