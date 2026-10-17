<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - The Grand Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%);
            min-height: 100vh;
            color: #fff;
        }

        .header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 5px;
        }

        .logo p {
            font-size: 12px;
            letter-spacing: 4px;
            opacity: 0.8;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info span {
            font-size: 14px;
            opacity: 0.9;
        }

        .logout-btn {
            background: transparent;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 8px 20px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 1px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 50px;
        }

        .welcome-section h2 {
            font-size: 48px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 20px;
        }

        .welcome-section p {
            font-size: 18px;
            opacity: 0.8;
            letter-spacing: 1px;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .dashboard-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
        }

        .dashboard-card h3 {
            font-size: 24px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 15px;
        }

        .dashboard-card p {
            font-size: 14px;
            opacity: 0.8;
            line-height: 1.6;
        }

        .dashboard-card a {
            color: #fff;
            text-decoration: none;
            display: block;
            width: 100%;
            height: 100%;
        }

        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            opacity: 0.8;
            transition: opacity 0.3s;
        }

        .back-link:hover {
            opacity: 1;
        }

        @media (max-width: 768px) {
            .header {
                padding: 20px;
                flex-direction: column;
                gap: 20px;
            }

            .welcome-section h2 {
                font-size: 32px;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <a href="/" class="back-link">← Back to Home</a>
    
    <div class="header">
        <div class="logo">
            <h1>THE GRAND RESORT</h1>
            <p>PARADISE</p>
        </div>
        <div class="user-info">
            <span>Welcome to your Dashboard</span>
            <a href="/api/auth/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <h2>Welcome Back</h2>
            <p>Manage your hotel reservations and events</p>
        </div>

        <div class="dashboard-grid">
            <div class="dashboard-card">
                <a href="/events">
                    <h3>Events</h3>
                    <p>View and manage special events, conferences, and celebrations at our resort.</p>
                </a>
            </div>

            <div class="dashboard-card">
                <a href="/reservations">
                    <h3>Reservations</h3>
                    <p>Create, view, and manage hotel reservations for our guests.</p>
                </a>
            </div>

            <div class="dashboard-card">
                <a href="/payments">
                    <h3>Payments</h3>
                    <p>Process payments and manage billing for reservations and events.</p>
                </a>
            </div>

            <div class="dashboard-card">
                <a href="/guest-portal">
                    <h3>Guest Portal</h3>
                    <p>Access guest information and provide personalized services.</p>
                </a>
            </div>

            <div class="dashboard-card">
                <a href="/reports">
                    <h3>Reports</h3>
                    <p>Generate reports and analyze hotel performance and guest data.</p>
                </a>
            </div>

            <div class="dashboard-card">
                <a href="/api/admin/users">
                    <h3>User Management</h3>
                    <p>Manage user accounts, roles, and permissions for staff members.</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
