<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taxi Service - Find Rides</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
            padding-top: 70px;
        }
        .navbar {
            background-color: rgba(255, 255, 255, 0.9);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            color: #667eea;
            font-weight: bold;
        }
        .nav-link {
            color: #555;
            font-weight: 500;
        }
        .nav-link:hover {
            color: #667eea;
        }
        .main-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        .section-title {
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px 10px 0 0 !important;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .role-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            margin-left: 10px;
        }
        .notification-badge {
            position: relative;
            top: -10px;
            left: -5px;
            padding: 3px 6px;
            border-radius: 50%;
            font-size: 0.6rem;
            background-color: #dc3545;
        }
        .search-form {
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .ride-card {
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        .ride-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .ride-info {
            padding: 15px;
        }
        .ride-meta {
            font-size: 0.9rem;
            color: #666;
        }
        .driver-info {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }
        .driver-photo {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .no-rides {
            text-align: center;
            padding: 50px 0;
        }
        .no-rides i {
            font-size: 5rem;
            color: #ccc;
            margin-bottom: 20px;
        }
        .map-container {
            height: 300px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }
        .ride-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background-color: #f9f9f9;
        }
        .ride-item h5 {
            color: #333;
            margin-bottom: 10px;
        }
        .ride-item p {
            margin-bottom: 5px;
            color: #666;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/home">
                <i class="fas fa-taxi"></i> Taxi Service
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/home">
                            <i class="fas fa-home"></i> Home
                        </a>
                    </li>
                    <c:if test="${user.role == 'DRIVER' || user.role == 'BOTH'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/my-cars">
                                <i class="fas fa-car"></i> My Cars
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${user.role == 'DRIVER' || user.role == 'BOTH'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/my-rides">
                                <i class="fas fa-route"></i> My Rides
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${user.role == 'PASSENGER' || user.role == 'BOTH'}">
                        <li class="nav-item">
                            <a class="nav-link active" href="/find-rides">
                                <i class="fas fa-search"></i> Find Rides
                            </a>
                        </li>
                    </c:if>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle"></i> ${user.firstName}
                            <span class="role-badge">
                                <c:choose>
                                    <c:when test="${user.role == 'DRIVER'}">
                                        <i class="fas fa-car-side"></i> Driver
                                    </c:when>
                                    <c:when test="${user.role == 'PASSENGER'}">
                                        <i class="fas fa-user"></i> Passenger
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-tag"></i> Both
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="userDropdown">
                            <li><a class="dropdown-item" href="/profile"><i class="fas fa-id-card"></i> Profile</a></li>
                           
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-4">
        <div class="row">
            <div class="col-12">
                <div class="main-container">
                    <h2 class="section-title">Find Available Rides</h2>
                    
                    <div class="row mb-4">
                        <div class="col-md-8">
                            <!-- Search Form -->
                            <div class="search-form mb-4">
                                <form action="/search-rides" method="get">
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label for="origin" class="form-label">From</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                                                <input type="text" class="form-control" id="origin" name="origin" 
                                                       placeholder="Departure location" value="${origin}">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label for="destination" class="form-label">To</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-map-marker"></i></span>
                                                <input type="text" class="form-control" id="destination" name="destination" 
                                                       placeholder="Arrival location" value="${destination}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="date" class="form-label">Date</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                                <input type="date" class="form-control" id="date" name="date" value="${date}">
                                            </div>
                                        </div>
                                        <div class="col-md-1 d-flex align-items-end">
                                            <button type="submit" class="btn btn-primary w-100">
                                                <i class="fas fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="map-container">
                                <img src="/api/placeholder/400/300" alt="Map View" style="width: 100%; height: 100%; object-fit: cover;">
                                <div class="text-center mt-2">
                                    <button class="btn btn-sm btn-outline-secondary">
                                        <i class="fas fa-map-marked-alt"></i> Toggle Map View
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Filter Section -->
                    <div class="filter-section mb-4">
                        <div class="row">
                            <div class="col-md-12">
                                <h5><i class="fas fa-filter"></i> Filter Results</h5>
                            </div>
                            <div class="col-md-3">
                                <div class="form-check">
                                    <input class="form-check-input filter-checkbox" type="checkbox" value="morning" id="morningFilter">
                                    <label class="form-check-label" for="morningFilter">
                                        Morning (6 AM - 12 PM)
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input filter-checkbox" type="checkbox" value="afternoon" id="afternoonFilter">
                                    <label class="form-check-label" for="afternoonFilter">
                                        Afternoon (12 PM - 6 PM)
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input filter-checkbox" type="checkbox" value="evening" id="eveningFilter">
                                    <label class="form-check-label" for="eveningFilter">
                                        Evening (After 6 PM)
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-check">
                                    <input class="form-check-input filter-checkbox" type="checkbox" value="available" id="availableFilter" checked>
                                    <label class="form-check-label" for="availableFilter">
                                        Available Seats
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input filter-checkbox" type="checkbox" value="highRated" id="highRatedFilter">
                                    <label class="form-check-label" for="highRatedFilter">
                                        Highly Rated Drivers (4.5+)
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select" id="sortBy">
                                    <option value="time">Sort by: Departure Time</option>
                                    <option value="rating">Sort by: Driver Rating</option>
                                    <option value="distance">Sort by: Distance</option>
                                </select>
                            </div>
                            <div class="col-md-3 text-end">
                                <button class="btn btn-sm btn-outline-secondary" id="resetFilters">
                                    <i class="fas fa-undo"></i> Reset Filters
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Results Summary -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <p class="mb-0">
                            <strong>
                                <c:choose>
                                    <c:when test="${availableRides.size() > 0}">
                                        Showing ${availableRides.size()} available rides
                                    </c:when>
                                    <c:otherwise>
                                        No rides found
                                    </c:otherwise>
                                </c:choose>
                            </strong>
                        </p>
                        <div>
                            <button class="btn btn-sm btn-outline-primary me-2">
                                <i class="fas fa-th"></i> Grid
                            </button>
                            <button class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-list"></i> List
                            </button>
                        </div>
                    </div>
                    
                    <!-- Rides List -->
                    <div class="rides-container">
                        <c:choose>
                            <c:when test="${availableRides.size() > 0}">
                                <!-- Card View -->
                                <div class="row">
                                    <c:forEach var="ride" items="${availableRides}">
                                        <div class="col-lg-4 col-md-6 mb-4">
                                            <div class="card ride-card h-100">
                                                <div class="card-header d-flex justify-content-between align-items-center">
                                                    <span>
                                                        <fmt:formatDate pattern="EEE, MMM d" value="${ride.departureTimeAsDate}" />
                                                    </span>
                                                    <span>
                                                        <fmt:formatDate pattern="h:mm a" value="${ride.departureTimeAsDate}" />
                                                    </span>
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                        <i class="fas fa-map-marker-alt text-danger"></i> ${ride.origin}
                                                        <i class="fas fa-long-arrow-alt-right mx-2"></i>
                                                        <i class="fas fa-map-marker text-success"></i> ${ride.destination}
                                                    </h5>
                                                    <div class="ride-meta mb-3">
                                                        <div><i class="fas fa-users"></i> ${ride.passengers.size()} / ${ride.car.maxRiders} passengers</div>
                                                        <div><i class="fas fa-car"></i> ${ride.car.make} ${ride.car.model} (${ride.car.color})</div>
                                                        <div><i class="fas fa-info-circle"></i> Status: ${ride.status}</div>
                                                    </div>
                                                    <div class="driver-info">
                                                        <img src="/api/placeholder/40/40" alt="Driver" class="driver-photo">
                                                        <div>
                                                            <div><strong>${ride.car.driver.firstName} ${ride.car.driver.lastName}</strong></div>
                                                            <div>
                                                                <i class="fas fa-star text-warning"></i> 4.8 (56 rides)
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-footer bg-white border-0 text-end">
                                                    <a href="/rides/${ride.id}" class="btn btn-primary">
                                                        <i class="fas fa-info-circle"></i> View Details
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <!-- Alternative List View (as per your example) -->
                                <div class="mt-4">
                                    <h4>Available Rides List</h4>
                                    <c:forEach var="ride" items="${availableRides}">
                                        <div class="ride-item">
                                            <h5>${ride.origin} to ${ride.destination}</h5>
                                            <p>Departure: <fmt:formatDate value="${ride.departureTimeAsDate}" pattern="yyyy-MM-dd HH:mm" /></p>
                                            <p>Driver: ${ride.car.driver.fullName}</p>
                                            <p>Status: ${ride.status}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <!-- Pagination -->
                                <c:if test="${availableRides.size() > 9}">
                                    <div class="d-flex justify-content-center mt-4">
                                        <nav aria-label="Ride pages">
                                            <ul class="pagination">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
                                                </li>
                                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                                <li class="page-item">
                                                    <a class="page-link" href="#">Next</a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <div class="no-rides">
                                    <i class="fas fa-car-side"></i>
                                    <h3>No rides available</h3>
                                    <p>Try adjusting your search filters or check back later.</p>
                                    <c:if test="${user.role == 'DRIVER' || user.role == 'BOTH'}">
                                        <a href="/rides/createRide" class="btn btn-primary mt-3">
                                            <i class="fas fa-plus-circle"></i> Offer a Ride
                                        </a>
                                    </c:if>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-light text-center text-lg-start mt-5">
        <div class="container p-4">
            <div class="row">
                <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Taxi Service</h5>
                    <p>
                        Connecting drivers and passengers for a better, more efficient commute.
                        Join our community today and start sharing rides!
                    </p>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Links</h5>
                    <ul class="list-unstyled mb-0">
                        <li><a href="#!" class="text-dark">About Us</a></li>
                        <li><a href="#!" class="text-dark">Contact</a></li>
                        <li><a href="#!" class="text-dark">Terms of Service</a></li>
                        <li><a href="#!" class="text-dark">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Follow Us</h5>
                    <ul class="list-unstyled mb-0">
                        <li><a href="#!" class="text-dark"><i class="fab fa-facebook"></i> Facebook</a></li>
                        <li><a href="#!" class="text-dark"><i class="fab fa-twitter"></i> Twitter</a></li>
                        <li><a href="#!" class="text-dark"><i class="fab fa-instagram"></i> Instagram</a></li>
                        <li><a href="#!" class="text-dark"><i class="fab fa-linkedin"></i> LinkedIn</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.05);">
            © 2025 Taxi Service. All rights reserved.
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter and sort functionality
        document.addEventListener('DOMContentLoaded', function() {
            const resetButton = document.getElementById('resetFilters');
            const filterCheckboxes = document.querySelectorAll('.filter-checkbox');
            const sortDropdown = document.getElementById('sortBy');
            
            // Reset filters
            resetButton.addEventListener('click', function() {
                filterCheckboxes.forEach(checkbox => {
                    if (checkbox.id === 'availableFilter') {
                        checkbox.checked = true;
                    } else {
                        checkbox.checked = false;
                    }
                });
                
                sortDropdown.value = 'time';
                
                // This would normally trigger a form submission or AJAX call
                // For now we'll just alert
                alert('Filters reset! In a real application, this would refresh the results.');
            });
            
            // Apply filters functionality would be implemented with AJAX
            // This is just a placeholder for demonstration
            filterCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    console.log('Filter changed: ' + this.id + ' is now ' + this.checked);
                    // In a real app, this would trigger filtering logic
                });
            });
            
            sortDropdown.addEventListener('change', function() {
                console.log('Sort changed to: ' + this.value);
                // In a real app, this would trigger sorting logic
            });
        });
    </script>
</body>
</html>