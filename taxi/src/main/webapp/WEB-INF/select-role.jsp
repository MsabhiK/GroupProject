<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Role</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Arial', sans-serif;
        }
        .role-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }
        .role-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        .role-card h2 {
            margin-bottom: 30px;
            color: #333;
        }
        .role-option {
            margin: 20px 0;
        }
        .form-check-label {
            font-size: 1.2rem;
            color: #555;
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            color: white;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>

<div class="role-container">
    <div class="role-card">
        <h2><i class="fas fa-user-tag"></i> Choose Your Role</h2>

        <form action="/update-role" method="post">
            <div class="form-check role-option text-start">
                <input class="form-check-input" type="radio" name="role" value="DRIVER" id="driver" required>
                <label class="form-check-label" for="driver">
                    <i class="fas fa-car-side"></i> Driver
                </label>
            </div>

            <div class="form-check role-option text-start">
                <input class="form-check-input" type="radio" name="role" value="PASSENGER" id="passenger" required>
                <label class="form-check-label" for="passenger">
                    <i class="fas fa-user"></i> Passenger
                </label>
            </div>

            <button type="submit" class="btn btn-submit">
                <i class="fas fa-arrow-right"></i> Continue
            </button>
        </form>
    </div>
</div>

</body>
</html>
