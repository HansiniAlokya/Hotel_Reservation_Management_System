<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Dashboard - GrandStay Paradise</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: transparent !important;
            background-image: none !important;
            overflow: hidden;
            min-height: 100vh;
            color: #fff;
            position: relative;
        }
        
        /* Video styling removed - using inline styles only */

        /* Video background removed - using inline styles */

        /* Dark overlay removed - video will be the background */

        /* Ensure content is above video */
        .header,
        .container {
            position: relative;
            z-index: 10;
        }

        .header {
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
        }

        .logo svg {
            flex-shrink: 0;
        }

        .logo h1 {
            font-size: 32px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 5px;
            margin-left: 0;
        }

        .logo p {
            font-size: 12px;
            letter-spacing: 4px;
            opacity: 0.8;
            margin-left: 0;
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
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 8px 20px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 1px;
            border-radius: 5px;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
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
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
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
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card h3 {
            font-size: 24px;
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 15px;
            color: #fff;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .dashboard-card p {
            font-size: 14px;
            line-height: 1.6;
            color: rgba(255, 255, 255, 0.9);
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }

        .dashboard-card a {
            color: #fff;
            text-decoration: none;
            display: block;
            width: 100%;
            height: 100%;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
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
    <!-- Video Background -->
    <video autoplay muted loop playsinline preload="auto" style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; object-fit: cover; z-index: 1;">
        <source src="/MyMovie.mp4?v=10" type="video/mp4">
    </video>
    
    <div class="header">
        <div class="logo">
            <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="width: 40px; height: 40px; margin-right: 15px;">
                <!-- Elegant Crown/Building Design -->
                <defs>
                    <linearGradient id="goldGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" style="stop-color:#D4AF37;stop-opacity:1" />
                        <stop offset="50%" style="stop-color:#F4E5C3;stop-opacity:1" />
                        <stop offset="100%" style="stop-color:#C5A572;stop-opacity:1" />
                    </linearGradient>
                </defs>
                
                <!-- Central Building/Crown Structure -->
                <!-- Main Tower -->
                <rect x="85" y="70" width="30" height="60" fill="url(#goldGradient)" opacity="0.9"/>
                
                <!-- Side Towers -->
                <rect x="60" y="85" width="20" height="45" fill="url(#goldGradient)" opacity="0.75"/>
                <rect x="120" y="85" width="20" height="45" fill="url(#goldGradient)" opacity="0.75"/>
                
                <!-- Roof/Crown Elements -->
                <polygon points="100,55 110,70 90,70" fill="url(#goldGradient)"/>
                <polygon points="70,75 80,85 60,85" fill="url(#goldGradient)" opacity="0.8"/>
                <polygon points="130,75 140,85 120,85" fill="url(#goldGradient)" opacity="0.8"/>
                
                <!-- Decorative Stars/Sparkles -->
                <circle cx="100" cy="60" r="2" fill="#F4E5C3"/>
                <circle cx="70" cy="80" r="1.5" fill="#F4E5C3" opacity="0.8"/>
                <circle cx="130" cy="80" r="1.5" fill="#F4E5C3" opacity="0.8"/>
                
                <!-- Windows -->
                <rect x="92" y="80" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                <rect x="104" y="80" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                <rect x="92" y="92" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                <rect x="104" y="92" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                <rect x="92" y="104" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                <rect x="104" y="104" width="4" height="6" fill="#2C2C2C" opacity="0.6"/>
                
                <!-- Base Foundation -->
                <rect x="55" y="130" width="90" height="3" fill="url(#goldGradient)"/>
                
                <!-- Letter G Monogram (subtle) -->
                <text x="100" y="155" font-family="serif" font-size="28" font-weight="300" fill="url(#goldGradient)" text-anchor="middle" opacity="0.9">G</text>
                
                <!-- Decorative Flourish Lines -->
                <line x1="40" y1="140" x2="65" y2="140" stroke="url(#goldGradient)" stroke-width="0.5" opacity="0.5"/>
                <line x1="135" y1="140" x2="160" y2="140" stroke="url(#goldGradient)" stroke-width="0.5" opacity="0.5"/>
            </svg>
            <div>
                <h1>GrandStay</h1>
                <p>PARADISE</p>
            </div>
        </div>
        <div class="user-info">
            <% if (request.getAttribute("user") != null) { %>
                <span>Welcome, ${user.firstName}!</span>
            <% } else { %>
                <span>Welcome to your Dashboard</span>
            <% } %>
            <a href="/api/auth/logout" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-section">
            <% if (request.getAttribute("isGuest") != null && (Boolean) request.getAttribute("isGuest")) { %>
                <h2>Guest Portal</h2>
                <p>Welcome to your personal portal for managing reservations and exploring our events</p>
            <% } else { %>
                <h2>Admin Dashboard</h2>
                <p>Manage hotel operations, events, reservations, and system analytics</p>
            <% } %>
        </div>

            <% if (request.getAttribute("isGuest") != null && (Boolean) request.getAttribute("isGuest")) { %>
                <!-- Guest Portal Functions -->
                <div class="dashboard-grid">
                    <div class="dashboard-card">
                        <a href="/guest/browse-events">
                            <h3>Browse Events</h3>
                            <p>Discover amazing events and make reservations. View event details, dates, and book your spot.</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/make-reservation">
                            <h3>Make Reservation</h3>
                            <p>Select a hotel → choose room → book. Create new reservations easily.</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/my-reservations">
                            <h3>My Reservations</h3>
                            <p>View their own reservations. Cancel if still pending.</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/payments">
                            <h3>Payments</h3>
                            <p>Pay for confirmed reservations. View payment status (Pending / Success / Failed).</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/profile">
                            <h3>Profile Management</h3>
                            <p>Update phone/email. Manage personal information.</p>
                        </a>
                    </div>
                </div>
            <% } else { %>
                <!-- Admin/Staff Dashboard Functions -->
                <div class="dashboard-grid">
                    <% if (request.getAttribute("userRole") != null && request.getAttribute("userRole").equals("ADMIN")) { %>
                    <div class="dashboard-card">
                        <a href="/api/admin/users">
                            <h3>User Management</h3>
                            <p>Create staff accounts. View guest accounts (no password editing). Block/unblock users.</p>
                        </a>
                    </div>
                    <% } %>

                    <div class="dashboard-card">
                        <a href="/admin/events">
                            <h3>Event Management</h3>
                            <p>Create / Update / Delete events. View all upcoming and past events.</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/admin/hotels">
                            <h3>Hotel Management</h3>
                            <p>Add, edit, and delete hotels. Manage hotel details and availability.</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/api/reservations/admin/manage-page">
                            <h3>Reservation Management</h3>
                            <p>View all reservations (from all guests). Change status (Confirm / Cancel).</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/payments">
                            <h3>Payment Management</h3>
                            <p>View all payments across the system. Update payment status (if manual).</p>
                        </a>
                    </div>

                    <div class="dashboard-card">
                        <a href="/reports">
                            <h3>Reports & Analytics</h3>
                            <p>Total reservations per event. Revenue from payments. Guest activity stats.</p>
                        </a>
                    </div>
                </div>
            <% } %>
    </div>
</body>
</html>
