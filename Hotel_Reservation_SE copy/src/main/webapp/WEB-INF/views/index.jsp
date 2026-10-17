<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GrandStay Paradise - Luxury Hotel & Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            overflow-x: hidden;
            background: #000;
            color: #fff;
        }

        /* Navigation */
        nav {
            position: fixed;
            top: 0;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            z-index: 1000;
        }

        .menu-toggle {
            width: 40px;
            height: 30px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            cursor: pointer;
        }

        .menu-toggle span {
            width: 100%;
            height: 2px;
            background: #fff;
            transition: all 0.3s;
        }

        .logo {
            display: flex;
            align-items: center;
            text-align: left;
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

        .nav-actions {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .lang-selector {
            background: transparent;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 8px 15px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-sign-in {
            background: transparent;
            border: none;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 2px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-sign-in:hover {
            opacity: 0.7;
        }

        .btn-book {
            background: transparent;
            border: 2px solid #fff;
            color: #fff;
            padding: 12px 30px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 2px;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-book:hover {
            background: #fff;
            color: #000;
        }

        /* Hero Section */
        .hero {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .hero-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.6);
        }

        .hero-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(1.2);
            opacity: 1;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.4), rgba(0,0,0,0.6));
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            padding: 0 20px;
        }

        .hero-content h2 {
            font-size: 72px;
            font-weight: 400;
            letter-spacing: 4px;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease;
        }

        .hero-content p {
            font-size: 18px;
            letter-spacing: 3px;
            opacity: 0.9;
            animation: fadeInUp 1s ease 0.2s backwards;
        }

        .scroll-indicator {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            cursor: pointer;
            animation: bounce 2s infinite;
        }

        .scroll-indicator svg {
            width: 40px;
            height: 40px;
            stroke: #fff;
        }

        /* Booking Form */
        .booking-section {
            position: absolute;
            bottom: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(20px);
            padding: 30px 50px;
            z-index: 100;
        }

        .booking-form {
            display: flex;
            gap: 20px;
            align-items: flex-end;
            flex-wrap: wrap;
            justify-content: center;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            opacity: 0.8;
        }

        .form-group input,
        .form-group select {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 12px 15px;
            font-size: 14px;
            min-width: 150px;
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-group select option {
            background: #000;
            color: #fff;
        }

        .btn-search {
            background: #fff;
            color: #000;
            border: none;
            padding: 14px 40px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: all 0.3s;
            margin-top: 20px;
        }

        .btn-search:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateX(-50%) translateY(0);
            }
            40% {
                transform: translateX(-50%) translateY(-10px);
            }
            60% {
                transform: translateX(-50%) translateY(-5px);
            }
        }

        @media (max-width: 768px) {
            nav {
                padding: 20px 20px;
            }

            .hero-content h2 {
                font-size: 42px;
            }

            .booking-form {
                flex-direction: column;
                align-items: stretch;
            }

            .form-group input,
            .form-group select {
                width: 100%;
            }

            .nav-actions {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav>
        <div class="menu-toggle">
            <span></span>
            <span></span>
            <span></span>
        </div>

        <div class="logo">
            <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="width: 60px; height: 60px; margin-right: 20px;">
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

        <div class="nav-actions">
            <select class="lang-selector">
                <option value="en">EN</option>
                <option value="es">ES</option>
                <option value="fr">FR</option>
            </select>
            <a href="/login" class="btn-sign-in">SIGN IN</a>
            <a href="/events" class="btn-book">BOOK NOW</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <video autoplay muted loop playsinline class="hero-video">
            <source src="https://videos.pexels.com/video-files/4069480/4069480-uhd_2560_1440_25fps.mp4" type="video/mp4">
            <!-- Fallback image if video doesn't load -->
            <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=1920&h=1080&fit=crop" alt="Maldives Resort" class="hero-bg">
        </video>
        <div class="hero-overlay"></div>
        
        <div class="hero-content">
            <h2>A Majestic Escape Awaits</h2>
            <p>EXPERIENCE UNPARALLELED LUXURY</p>
        </div>

        <div class="scroll-indicator">
            <svg viewBox="0 0 24 24" fill="none">
                <path d="M7 13l5 5 5-5M7 6l5 5 5-5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>

        <!-- Booking Form -->
        <div class="booking-section">
            <form action="/events" method="get" class="booking-form">
                <div class="form-group">
                    <label for="checkin">Check In</label>
                    <input type="date" id="checkin" name="checkin" required>
                </div>

                <div class="form-group">
                    <label for="checkout">Check Out</label>
                    <input type="date" id="checkout" name="checkout" required>
                </div>

                <div class="form-group">
                    <label for="adults">Adults</label>
                    <select id="adults" name="adults">
                        <option value="1">1</option>
                        <option value="2" selected>2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="children">Children</label>
                    <select id="children" name="children">
                        <option value="0" selected>0</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="rooms">Rooms</label>
                    <select id="rooms" name="rooms">
                        <option value="1" selected>1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                </div>

                <button type="submit" class="btn-search">Search Events</button>
            </form>
        </div>
    </section>

    <script>
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('checkin').setAttribute('min', today);
        document.getElementById('checkout').setAttribute('min', today);

        // Update checkout min date when checkin changes
        document.getElementById('checkin').addEventListener('change', function() {
            const checkinDate = new Date(this.value);
            checkinDate.setDate(checkinDate.getDate() + 1);
            const minCheckout = checkinDate.toISOString().split('T')[0];
            document.getElementById('checkout').setAttribute('min', minCheckout);
        });

        // Smooth scroll
        document.querySelector('.scroll-indicator').addEventListener('click', function() {
            window.scrollBy({
                top: window.innerHeight,
                behavior: 'smooth'
            });
        });

        // Menu toggle animation
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            this.classList.toggle('active');
        });
    </script>
</body>
</html>
