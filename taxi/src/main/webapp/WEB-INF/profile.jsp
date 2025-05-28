<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taxi Service - Profile</title>
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
        .profile-container {
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
        .form-control {
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            padding: 10px 15px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .profile-image-container {
            position: relative;
            display: inline-block;
            margin-bottom: 20px;
        }
        .edit-image-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .edit-image-btn:hover {
            background: #5a67d8;
        }
        .role-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            margin-left: 10px;
        }
        .invalid-feedback {
            display: block;
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
                            <a class="nav-link" href="/find-rides">
                                <i class="fas fa-search"></i> Find Rides
                            </a>
                        </li>
                    </c:if>
                    
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="userDropdown" role="button" 
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
                            <li><a class="dropdown-item active" href="/profile"><i class="fas fa-id-card"></i> Profile</a></li>
                            
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
            <div class="col-lg-4 mb-4">
                <!-- Profile Info Card -->
                <div class="profile-container text-center">
                    <div class="profile-image-container">
                        <img src="/api/placeholder/150/150" alt="Profile Picture" class="profile-image">
                        <div class="edit-image-btn">
                            <i class="fas fa-camera"></i>
                        </div>
                    </div>
                    <h3>${user.firstName} ${user.lastName}</h3>
                    <p class="text-muted">
                        <span class="badge rounded-pill bg-primary">
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
                    </p>
                    
                    <div class="d-grid gap-2 mt-4">
                        <a href="/select-role" class="btn btn-outline-primary">
                            <i class="fas fa-exchange-alt"></i> Change Role
                        </a>
                    </div>
                    
                    <hr class="my-4">
                    
                    <div class="text-start">
                        <h5 class="mb-3">Account Stats</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><i class="fas fa-car-side text-primary"></i> Total Rides:</span>
                            <span class="fw-bold">${rides.size()}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><i class="fas fa-star text-warning"></i> Average Rating:</span>
                            <span class="fw-bold">4.8/5</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><i class="fas fa-calendar-check text-success"></i> Member Since:</span>
                            <span class="fw-bold">Jan 2024</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">
                <!-- Edit Profile Form -->
                <div class="profile-container">
                    <h3 class="section-title">
                        <i class="fas fa-user-edit"></i> Edit Profile
                    </h3>
                    
                    <form:form action="/update-profile" method="post" modelAttribute="user" class="needs-validation">
                    	<input type="hidden" name="_method" value="post">
                    	<form:hidden path="id"/>
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <form:label path="firstName" class="form-label">First Name</form:label>
                                <form:input path="firstName" class="form-control" placeholder="First Name" />
                                <form:errors path="firstName" class="invalid-feedback" />
                            </div>
                            <div class="col-md-6">
                                <form:label path="lastName" class="form-label">Last Name</form:label>
                                <form:input path="lastName" class="form-control" placeholder="Last Name" />
                                <form:errors path="lastName" class="invalid-feedback" />
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="email" class="form-label">Email Address</form:label>
                            <form:input path="email" type="email" class="form-control" placeholder="Email Address" />
                            <form:errors path="email" class="invalid-feedback" />
                        </div>
                        
                        <div class="mb-3">
                            <form:label path="phoneNumber" class="form-label">Phone Number</form:label>
                            <form:input path="phoneNumber" class="form-control" placeholder="Phone Number" />
                            <form:errors path="phoneNumber" class="invalid-feedback" />
                        </div>
                        <!-- 
                        <hr class="my-4">
                        
                        <h4 class="mb-3">Change Password</h4>
                        <p class="text-muted mb-4">Leave blank if you don't want to change your password</p>
                        
                        <div class="row mb-3">
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-control" placeholder="Current Password">
                            </div>
                            <div class="col-md-4 mb-3 mb-md-0">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="New Password">
                            </div>
                            <div class="col-md-4">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password">
                            </div>
                        </div>
                        -->
                        <hr class="my-4">
                        
                        <!-- Additional fields based on role -->
                        <!--  
                        <c:if test="${user.role == 'DRIVER' || user.role == 'BOTH'}">
                            <h4 class="mb-3">Driver Information</h4>
                            
                            <div class="mb-3">
                                <label for="driverLicense" class="form-label">Driver's License Number</label>
                                <input type="text" id="driverLicense" name="driverLicense" class="form-control" value="${driverLicense}" placeholder="Driver's License Number">
                            </div>
                            
                            <div class="mb-3">
                                <label for="driverExperience" class="form-label">Driving Experience (Years)</label>
                                <input type="number" id="driverExperience" name="driverExperience" class="form-control" value="${driverExperience}" min="0">
                            </div>
                        </c:if>
                        -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                            <a href="/home" class="btn btn-secondary me-md-2">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </div>
                    </form:form>
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