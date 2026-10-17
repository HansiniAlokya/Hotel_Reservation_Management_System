<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - GrandStay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1920') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
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

        .priority-heading {
            position: absolute;
            top: 50%;
            left: 10%;
            transform: translateY(-50%);
            font-size: 72px;
            font-weight: 400;
            letter-spacing: 4px;
            color: #fff;
            text-align: left;
            z-index: 10;
            animation: fadeInUp 1s ease;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            max-width: 40%;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(-50%) translateX(-100px);
            }
            to {
                opacity: 1;
                transform: translateY(-50%) translateX(0);
            }
        }

        .login-container {
            position: absolute;
            top: 50%;
            right: 10%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 400px;
            max-width: 40%;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
        }

        .logo svg {
            flex-shrink: 0;
        }

        .logo h1 {
            font-size: 36px;
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

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 8px;
            opacity: 0.9;
        }

        .form-group input {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 15px;
            font-size: 16px;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .btn-signin {
            width: 100%;
            background: #fff;
            color: #000;
            border: none;
            padding: 15px;
            cursor: pointer;
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            border-radius: 8px;
            transition: all 0.3s;
            margin-bottom: 20px;
        }

        .btn-signin:hover {
            background: #f0f0f0;
            transform: translateY(-2px);
        }

        .links {
            text-align: center;
        }

        .links a {
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            opacity: 0.8;
            transition: opacity 0.3s;
        }

        .links a:hover {
            opacity: 1;
        }

        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            transition: all 0.3s;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
        }

        .error-message {
            background: rgba(255, 0, 0, 0.2);
            border: 1px solid rgba(255, 0, 0, 0.3);
            color: #ff6b6b;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            text-align: center;
        }

        @media (max-width: 768px) {
            .priority-heading {
                font-size: 42px;
                letter-spacing: 2px;
                left: 5%;
                max-width: 45%;
            }
            
            .login-container {
                right: 5%;
                width: 350px;
                max-width: 45%;
            }
        }

        @media (max-width: 480px) {
            .priority-heading {
                font-size: 32px;
                letter-spacing: 1px;
                left: 5%;
                max-width: 90%;
                top: 20%;
                transform: translateY(0);
            }
            
            .login-container {
                right: 5%;
                width: 90%;
                max-width: 90%;
                top: 60%;
                transform: translateY(0);
                margin: 20px;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <h2 class="priority-heading">Your Stay, Our Priority</h2>
    <a href="/" class="back-link">← Back to Home</a>
    
    <div class="login-container">
        <div class="logo">
            <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="width: 50px; height: 50px; margin-right: 15px;">
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

        <form action="/api/auth/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn-signin">Sign In</button>
        </form>

        <div class="links">
            <a href="/register">Don't have an account? Register</a>
        </div>
    </div>

    <script>
        // Simple form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
                return;
            }
            
            // Basic email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return;
            }
        });
    </script>
</body>
</html>
