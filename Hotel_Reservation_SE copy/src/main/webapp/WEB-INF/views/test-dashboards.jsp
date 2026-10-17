<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Test - GrandStay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: url('https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=1920') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            color: #fff;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .test-section {
            margin-bottom: 50px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 30px;
        }

        .test-section h2 {
            font-size: 32px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 20px;
            text-align: center;
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
    </style>
</head>
<body>
    <a href="/" class="back-link">← Back to Home</a>
    
    <div class="container">
        <div class="test-section">
            <h2>Guest Dashboard</h2>
            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <a href="/events">
                        <h3>Browse Events</h3>
                        <p>See available events and special occasions at our resort. View event details, dates, and availability.</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/reservations">
                        <h3>Make Reservation</h3>
                        <p>Select an event, choose your preferences, and book your stay. Create new reservations easily.</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/my-reservations">
                        <h3>My Reservations</h3>
                        <p>View all your reservations, check status, and cancel pending bookings if needed.</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/payments">
                        <h3>Payments</h3>
                        <p>Pay for confirmed reservations and view payment status (Pending / Success / Failed).</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/profile">
                        <h3>Profile Management</h3>
                        <p>Update your personal information including phone number and email address.</p>
                    </a>
                </div>
            </div>
        </div>

        <div class="test-section">
            <h2>Admin Dashboard</h2>
            <div class="dashboard-grid">
                <div class="dashboard-card">
                    <a href="/events">
                        <h3>Event Management</h3>
                        <p>Create, update, and manage special events, conferences, and celebrations.</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/reservations">
                        <h3>Reservation Management</h3>
                        <p>Handle guest bookings, room allocations, and manage all reservations.</p>
                    </a>
                </div>

                <div class="dashboard-card">
                    <a href="/payments">
                        <h3>Payment Management</h3>
                        <p>Process payments, manage billing, and view transaction history.</p>
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
                        <h3>Reports & Analysis</h3>
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
    </div>
</body>
</html>
