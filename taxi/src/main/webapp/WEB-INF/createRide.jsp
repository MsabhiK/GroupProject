<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create a Ride - Taxi Service</title>
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
        .nav-link.active {
            background-color: rgba(102, 126, 234, 0.1);
            border-radius: 20px;
            color: #667eea;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }
        .page-title {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-weight: bold;
        }
        .section-title {
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .section-title i {
            margin-right: 10px;
            color: #667eea;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            padding: 12px 15px;
            margin-bottom: 5px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            transform: translateY(-2px);
        }
        .form-label {
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }
        .form-label i {
            margin-right: 8px;
            color: #667eea;
            width: 16px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .error {
            color: #e53e3e;
            font-style: italic;
            font-size: 0.875rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
        }
        .error i {
            margin-right: 5px;
        }
        .role-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            margin-left: 10px;
        }
        .coordinate-group {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #667eea;
        }
        .coordinate-title {
            color: #667eea;
            font-weight: 600;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .coordinate-title i {
            margin-right: 8px;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .icon-input {
            position: relative;
        }
        .icon-input i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            z-index: 2;
        }
        .icon-input .form-control {
            padding-left: 45px;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px 12px 0 0;
            padding: 15px 25px;
            margin: -40px -40px 30px -40px;
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .back-link:hover {
            color: #5a67d8;
            transform: translateX(-5px);
        }
        .back-link i {
            margin-right: 8px;
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
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-6">
                <div class="form-container">
                    <div class="card-header">
                        <h2 class="mb-0">
                            <i class="fas fa-plus-circle"></i> Create a New Ride
                        </h2>
                    </div>

                    <form:form action="/rides/create" method="post" modelAttribute="ride">
                        <!-- Basic Trip Information -->
                        <div class="section-title">
                            <i class="fas fa-map-marked-alt"></i>
                            Trip Details
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:label path="origin" class="form-label">
                                        <i class="fas fa-map-marker-alt"></i> Origin
                                    </form:label>
                                    <div class="icon-input">
                                        <i class="fas fa-play"></i>
                                        <form:input path="origin" class="form-control" placeholder="Enter pickup location" />
                                    </div>
                                   		
                                    <i class="fas fa-exclamation-circle"></i>
                                    <form:errors path="origin" class="error"/>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <form:label path="destination" class="form-label">
                                        <i class="fas fa-map-marker-alt"></i> Destination
                                    </form:label>
                                    <div class="icon-input">
                                        <i class="fas fa-stop"></i>
                                        <form:input path="destination" class="form-control" placeholder="Enter destination" />
                                    </div>
                                    <i class="fas fa-exclamation-circle"></i>
                                    <form:errors path="destination" class="error"/>
                                        
                                   
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <form:label path="departureTime" class="form-label">
                                <i class="fas fa-clock"></i> Departure Time
                            </form:label>
                            <div class="icon-input">
                                <i class="fas fa-calendar-alt"></i>
                                <form:input path="departureTime" type="datetime-local" class="form-control" />
                            </div>
                            <i class="fas fa-exclamation-circle"></i>
                            <form:errors path="departureTime" class="error"/>
                        </div>

                        <!-- Origin Coordinates -->
                        <div class="coordinate-group">
                            <div class="coordinate-title">
                                <i class="fas fa-crosshairs"></i>
                                Origin Coordinates
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="originLatitude" class="form-label">
                                        <i class="fas fa-globe"></i> Latitude
                                    </label>
                                    <form:input path="originLatitude" type="number" step="0.000001" class="form-control" placeholder="0.000000" />
                                </div>
                                <div class="form-group">
                                    <label for="originLongitude" class="form-label">
                                        <i class="fas fa-globe"></i> Longitude
                                    </label>
                                    <form:input path="originLongitude" type="number" step="0.000001" class="form-control" placeholder="0.000000" />
                                </div>
                            </div>
                        </div>

                        <!-- Destination Coordinates -->
                        <div class="coordinate-group">
                            <div class="coordinate-title">
                                <i class="fas fa-crosshairs"></i>
                                Destination Coordinates
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="destinationLatitude" class="form-label">
                                        <i class="fas fa-globe"></i> Latitude
                                    </label>
                                    <form:input path="destinationLatitude" type="number" step="0.000001" class="form-control" placeholder="0.000000" />
                                </div>
                                <div class="form-group">
                                    <label for="destinationLongitude" class="form-label">
                                        <i class="fas fa-globe"></i> Longitude
                                    </label>
                                    <form:input path="destinationLongitude" type="number" step="0.000001" class="form-control" placeholder="0.000000" />
                                </div>
                            </div>
                        </div>

                        <!-- Car Selection -->
                        <div class="section-title">
                            <i class="fas fa-car"></i>
                            Vehicle Selection
                        </div>

                        <div class="form-group mb-4">
                            <form:label path="car" class="form-label">
                                <i class="fas fa-car-side"></i> Select Vehicle
                            </form:label>
                            <form:select path="car" class="form-control">
                                <form:option value="">-- Select a vehicle --</form:option>
                                <c:forEach items="${cars}" var="car">
                                    <option value="${car.id}">
                                        ${car.make} ${car.model} - ${car.driver.firstName} ${car.driver.lastName}
                                    </option>
                                </c:forEach>
                            </form:select>
                            <c:if test="${carError != null}">
                                <span class="error">
                                    <i class="fas fa-exclamation-circle"></i>
                                    ${carError}
                                </span>
                            </c:if>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-5">
                            <a href="/home" class="btn btn-secondary me-md-2">
                                <i class="fas fa-arrow-left"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Create Ride
                            </button>
                        </div>
                    </form:form>
                </div>

                <!-- Back Link -->
                <div class="text-center mt-4">
                    <a href="/my-rides" class="back-link">
                        <i class="fas fa-arrow-left"></i>
                        Back to Rides List
                    </a>
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