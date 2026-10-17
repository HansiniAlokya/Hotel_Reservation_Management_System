<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: transparent !important;
            background-image: none !important;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.2);
            z-index: -1;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            text-align: center;
            max-width: 500px;
            backdrop-filter: blur(10px);
        }
        
        h1 {
            color: #333;
            margin-bottom: 20px;
            font-size: 2.5rem;
        }
        
        p {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }
        
        .btn {
            display: inline-block;
            background: #007bff;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 1.1rem;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 123, 255, 0.3);
        }
        
        .api-info {
            margin-top: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        
        .api-info h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .api-info p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 10px;
        }
        
        .api-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        
        .api-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Video Background -->
    <video autoplay muted loop playsinline preload="auto" style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; object-fit: cover; z-index: -999; background: #000;">
        <source src="/MyMovie.mp4" type="video/mp4">
    </video>
    <div class="container">
        <h1>🎯 Admin Dashboard</h1>
        <p>Welcome to the Hotel Reservation System Admin Panel</p>
        
        <a href="/admin/user-management" class="btn">👥 Manage Users</a>
        
        <div class="api-info">
            <h3>📡 API Endpoints</h3>
            <p><strong>User Management Page:</strong></p>
            <p><a href="/admin/user-management" class="api-link">/admin/user-management</a></p>
            <p><a href="/admin/users-page" class="api-link">/admin/users-page</a></p>
            <p><a href="/admin/users" class="api-link">/admin/users</a></p>
            
            <p><strong>API Data:</strong></p>
            <p><a href="/api/admin/users" class="api-link">/api/admin/users</a> (JSON data)</p>
        </div>
    </div>
</body>
</html>
