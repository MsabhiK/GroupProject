<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taxi Service - Home</title>
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
        .feature-icon {
            font-size: 2rem;
            color: #667eea;
            margin-bottom: 15px;
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
                        <a class="nav-link active" href="/home">
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
                            <a class="nav-link" href="/find-rides">
                                <i class="fas fa-search"></i> Find Rides
                            </a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="nav-link" href="/notifications">
                            <i class="fas fa-bell"></i> Notifications
                            <span class="badge notification-badge">3</span>
                        </a>
                    </li>
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
                            <li><a class="dropdown-item" href="/settings"><i class="fas fa-cog"></i> Settings</a></li>
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
            <div class="col-lg-8">
                <!-- Welcome Section -->
                <div class="main-container mb-4">
                    <h2 class="section-title">Welcome, ${user.firstName}!</h2>
                    <p class="lead">What would you like to do today?</p>
                    
                    <div class="row mt-4">
                        <c:if test="${user.role == 'DRIVER' || user.role == 'BOTH'}">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-car-side feature-icon"></i>
                                        <h5 class="card-title">Offer a Ride</h5>
                                        <p class="card-text">Create a new ride and help others reach their destination.</p>
                                        <a href="/rides/createRide" class="btn btn-primary">Create Ride</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <c:if test="${user.role == 'PASSENGER' || user.role == 'BOTH'}">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100">
                                    <div class="card-body text-center">
                                        <i class="fas fa-search-location feature-icon"></i>
                                        <h5 class="card-title">Find a Ride</h5>
                                        <p class="card-text">Search for available rides to your destination.</p>
                                        <a href="/find-rides" class="btn btn-primary">Find Rides</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="col-md-6 mb-3">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-history feature-icon"></i>
                                    <h5 class="card-title">Ride History</h5>
                                    <p class="card-text">View all your past rides and upcoming trips.</p>
                                    <a href="/ride-history" class="btn btn-primary">View History</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <div class="card h-100">
                                <div class="card-body text-center">
                                    <i class="fas fa-user-edit feature-icon"></i>
                                    <h5 class="card-title">Edit Profile</h5>
                                    <p class="card-text">Update your personal information and preferences.</p>
                                    <a href="/profile" class="btn btn-primary">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activity Section -->
                <div class="main-container">
                    <h3 class="section-title">Recent Activity</h3>
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">Ride to Downtown completed</h5>
                                <small>3 days ago</small>
                            </div>
                            <p class="mb-1">You completed a ride from Home to Downtown. Fare: $15.50</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">New ride booked</h5>
                                <small>1 week ago</small>
                            </div>
                            <p class="mb-1">You booked a ride from Office to Home for tomorrow at 5:30 PM.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">Profile updated</h5>
                                <small>2 weeks ago</small>
                            </div>
                            <p class="mb-1">You updated your profile information and preferences.</p>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4">
                <!-- Upcoming Rides Section -->
                <div class="main-container mb-4">
                    <h3 class="section-title">Upcoming Rides</h3>
                    <c:choose>
                        <c:when test="${empty upcomingRides}">
                            <div class="text-center py-4">
                                <i class="fas fa-calendar-alt text-muted" style="font-size: 3rem;"></i>
                                <p class="mt-3">No upcoming rides scheduled.</p>
                                <a href="/find-rides" class="btn btn-primary btn-sm">Find a Ride</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- This would be populated with real data -->
                            <div class="card mb-3">
                                <div class="card-header">Tomorrow, 9:00 AM</div>
                                <div class="card-body">
                                    <h5 class="card-title">Home to Office</h5>
                                    <p class="card-text">
                                        <i class="fas fa-map-marker-alt text-danger"></i> 123 Home St.<br>
                                        <i class="fas fa-arrow-down text-success"></i><br>
                                        <i class="fas fa-building text-primary"></i> 456 Office Ave.
                                    </p>
                                    <a href="#" class="btn btn-sm btn-primary">View Details</a>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- Notifications Widget -->
                <div class="main-container mb-4">
                    <h3 class="section-title">Notifications</h3>
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">New ride request</h6>
                                <small class="text-muted">Just now</small>
                            </div>
                            <small>Someone wants to join your ride to Downtown.</small>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Ride reminder</h6>
                                <small class="text-muted">2 hours ago</small>
                            </div>
                            <small>Your ride to Office is scheduled for tomorrow.</small>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Payment received</h6>
                                <small class="text-muted">1 day ago</small>
                            </div>
                            <small>You received $12.50 for your last ride.</small>
                        </a>
                    </div>
                    <div class="text-center mt-3">
                        <a href="/notifications" class="btn btn-sm btn-outline-primary">View All</a>
                    </div>
                </div>
                
                <!-- Quick Stats -->
                <div class="main-container">
                    <h3 class="section-title">Your Stats</h3>
                    <div class="row text-center">
                        <div class="col-6 mb-3">
                            <div class="p-3 border rounded">
                                <h3 class="text-primary">25</h3>
                                <small class="text-muted">Total Rides</small>
                            </div>
                        </div>
                        <div class="col-6 mb-3">
                            <div class="p-3 border rounded">
                                <h3 class="text-primary">4.8</h3>
                                <small class="text-muted">Rating</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 border rounded">
                                <h3 class="text-primary">$250</h3>
                                <small class="text-muted">Total Saved</small>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-3 border rounded">
                                <h3 class="text-primary">125</h3>
                                <small class="text-muted">CO₂ Reduced (kg)</small>
                            </div>
                        </div>
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
</body>
</html>