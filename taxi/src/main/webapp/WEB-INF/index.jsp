<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Taxi Service - Login - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 2rem;
            margin: 1rem;
        }
        .nav-pills .nav-link {
            color: #667eea;
            font-weight: 500;
        }
        .nav-pills .nav-link.active {
            background-color: #667eea;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 30px;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e2e8f0;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .invalid-feedback {
            display: block;
        }
        .alert {
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="form-container">
                    <div class="text-center mb-4">
                        <h2 class="mb-3" style="color: #667eea;">🚕 Taxi Service</h2>
                        <p class="text-muted">Welcome! Please login or register to continue</p>
                    </div>

                    <!-- Navigation tabs -->
                    <ul class="nav nav-pills nav-justified mb-4" id="authTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="login-tab" data-bs-toggle="pill" 
                                    data-bs-target="#login-form" type="button" role="tab">
                                Login
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="register-tab" data-bs-toggle="pill" 
                                    data-bs-target="#register-form" type="button" role="tab">
                                Register
                            </button>
                        </li>
                    </ul>

                    <div class="tab-content" id="authTabContent">
                        <!-- Login Form -->
                        <div class="tab-pane fade show active" id="login-form" role="tabpanel">
                            <form:form action="/login" method="post" modelAttribute="loginUser">
                                <div class="mb-3">
                                    <form:label path="email" class="form-label">Email Address</form:label>
                                    <form:input path="email" type="email" class="form-control" placeholder="Enter your email"/>
                                    <form:errors path="email" class="invalid-feedback"/>
                                </div>

                                <div class="mb-3">
                                    <form:label path="password" class="form-label">Password</form:label>
                                    <form:password path="password" class="form-control" placeholder="Enter your password"/>
                                    <form:errors path="password" class="invalid-feedback"/>
                                </div>

                                <c:if test="${loginError != null}">
                                    <div class="alert alert-danger" role="alert">
                                        ${loginError}
                                    </div>
                                </c:if>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </div>
                            </form:form>
                        </div>

                        <!-- Register Form -->
                        <div class="tab-pane fade" id="register-form" role="tabpanel">
                            <form:form action="/register" method="post" modelAttribute="newUser">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <form:label path="firstName" class="form-label">First Name</form:label>
                                        <form:input path="firstName" type="text" class="form-control" placeholder="First Name"/>
                                        <form:errors path="firstName" class="invalid-feedback"/>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <form:label path="lastName" class="form-label">Last Name</form:label>
                                        <form:input path="lastName" type="text" class="form-control" placeholder="Last Name"/>
                                        <form:errors path="lastName" class="invalid-feedback"/>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <form:label path="email" class="form-label">Email Address</form:label>
                                    <form:input path="email" type="email" class="form-control" placeholder="Enter your email"/>
                                    <form:errors path="email" class="invalid-feedback"/>
                                </div>

                                <div class="mb-3">
                                    <form:label path="phoneNumber" class="form-label">Phone Number</form:label>
                                    <form:input path="phoneNumber" type="tel" class="form-control" placeholder="Enter your phone number"/>
                                    <form:errors path="phoneNumber" class="invalid-feedback"/>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <form:label path="password" class="form-label">Password</form:label>
                                        <form:password path="password" class="form-control" placeholder="Enter your password"/>
                                        <form:errors path="password" class="invalid-feedback"/>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <form:label path="confirm" class="form-label">Confirm Password</form:label>
                                        <form:password path="confirm" class="form-control" placeholder="Confirm your password"/>
                                        <form:errors path="confirm" class="invalid-feedback"/>
                                    </div>
                                </div>
                                <div class="d-grid">
                                    <button type="submit" class="btn btn-primary">Register</button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Switch to register tab if there are registration errors
        <c:if test="${not empty newUser and (not empty newUser.firstName or not empty newUser.lastName)}">
            document.addEventListener('DOMContentLoaded', function() {
                var registerTab = new bootstrap.Tab(document.getElementById('register-tab'));
                registerTab.show();
            });
        </c:if>

        // Add some interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('.form-control');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.style.transform = 'scale(1.02)';
                    this.style.transition = 'transform 0.2s ease';
                });
                
                input.addEventListener('blur', function() {
                    this.style.transform = 'scale(1)';
                });
            });
        });
    </script>
</body>
</html>