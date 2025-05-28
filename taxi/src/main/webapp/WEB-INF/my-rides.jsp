<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taxi Service - My Rides</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Arial', sans-serif';
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
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .car-card {
            border-left: 5px solid #667eea;
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
        .car-icon {
            font-size: 2rem;
            color: #667eea;
            margin-right: 15px;
        }
        .action-buttons .btn {
            margin-right: 5px;
        }
        .empty-state {
            text-align: center;
            padding: 40px 0;
        }
        .empty-state i {
            font-size: 4rem;
            color: #ccc;
            margin-bottom: 20px;
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
                            <a class="nav-link active" href="/my-rides">
                                <i class="fas fa-route"></i> My Rides
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${user.role == 'PASSENGER' || user.role == 'BOTH'}">
                        <li class="nav-item">
                            <a class="nav-link" href="/find-rides">
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
        <!-- Flash Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <div class="row">
            <div class="col-lg-9">
                <div class="main-container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title mb-0">
                            <i class="fas fa-route me-2"></i> My Rides
                        </h2>
                        <a href="/rides/createRide" class="btn btn-primary">
                            <i class="fas fa-plus-circle"></i> Add New Ride
                        </a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty rides}">
                            <!-- Empty State -->
                            <div class="empty-state">
                                <i class="fas fa-car-side"></i>
                                <h4>No Rides Yet</h4>
                                <p class="text-muted">Add your first ride to start offering cars to passengers</p>
                                <a href="/rides/createRide" class="btn btn-primary mt-3">
                                    <i class="fas fa-plus-circle"></i> Add Your First Ride
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Ride List -->
                            <div class="route-list">
                                <c:forEach items="${rides}" var="ride">
                                    <div class="card car-card mb-3">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="d-flex align-items-center">
                                                    <i class="fas fa-route route-icon"></i>
                                                    <div>
                                                        <h5 class="card-title mb-1">
                                                        	<i class="fas fa-map-marker-alt text-danger"></i> ${ride.origin}
	                                                        <i class="fas fa-long-arrow-alt-right mx-2"></i>
	                                                        <i class="fas fa-map-marker text-success"></i> ${ride.destination}
                                                        </h5>
                                                        <p class="card-text text-muted mb-0">
                                                            <i class="fas fa-calendar-alt me-2"></i> <fmt:formatDate pattern="EEE, MMM d" value="${ride.departureTimeAsDate}" /> | 
                                                            <i class="fas fa-clock me-2"></i> <fmt:formatDate pattern="h:mm a" value="${ride.departureTimeAsDate}" /> | 
                                                            <i class="fas fa-globe me-2"></i> Origin: ${ride.originLatitude}/${ride.originLongitude} |
                                                            <i class="fas fa-globe me-2"></i> Destination: ${ride.destinationLatitude}/${ride.destinationLongitude} |
                                                            <i class="fas fa-car me-2"></i> ${ride.car.make} ${ride.car.model} | 
                                                            <i class="fas fa-users me-2"></i> ${ride.car.driver.firstName} ${ride.car.driver.lastName}
                                                        </p>
                                                    </div>
                                                </div>
                                                <div class="action-buttons">
                                                    <c:if test="${user==ride.car.driver}">
                                                    <a href="/delete-ride/${ride.id}" class="btn btn-sm btn-outline-danger" 
                                                       onclick="return confirm('Are you sure you want to delete this ride?');">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </a>
                                                    </c:if>
                                                    <c:if test="${user!=ride.car.driver}">
                                                    <a href="" class="btn btn-sm btn-outline-info" 
                                                       onclick="return confirm('You can't delete this ride?');">
                                                        <i class="fas fa-lock"></i> Locked
                                                    </a>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="col-lg-3">
                <!-- Sidebar Content -->
                <div class="main-container mb-4">
                    <h3 class="section-title">Quick Stats</h3>
                    <div class="d-flex justify-content-between mb-3">
                        <div>Total Rides:</div>
                        <div><strong>${rides.size()}</strong></div>
                    </div>
                    <div class="progress mb-4" style="height: 10px;">
                        <div class="progress-bar" role="progressbar" style="width: ${rides.size() * 20}%;" 
                             aria-valuenow="${rides.size()}" aria-valuemin="0" aria-valuemax="5"></div>
                    </div>
                    <div class="text-center mt-3">
                        <a href="/rides/createRide" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus-circle"></i> Add Another Ride
                        </a>
                    </div>
                </div>
                
                <div class="main-container">
                    <h3 class="section-title">Tips for Drivers</h3>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i> Keep your car clean
                        </li>
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i> Be punctual for pickups
                        </li>
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i> Drive safely at all times
                        </li>
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i> Be courteous to passengers
                        </li>
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i> Keep your profile updated
                        </li>
                    </ul>
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
</body>
</html>