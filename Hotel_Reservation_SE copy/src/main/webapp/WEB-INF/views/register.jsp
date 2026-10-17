<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - GrandStay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Cormorant Garamond', 'Georgia', serif;
            background: url('https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=1920') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            padding: 20px 0;
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

        .register-container {
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

        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            flex: 1;
        }

        .form-group.full-width {
            flex: none;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 8px;
            opacity: 0.9;
        }

        .form-group input, .form-group select {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 15px;
            font-size: 16px;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-group select option {
            background: #2d2d2d;
            color: #fff;
        }

        .btn-register {
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

        .btn-register:hover {
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

        .success-message {
            background: rgba(0, 255, 0, 0.2);
            border: 1px solid rgba(0, 255, 0, 0.3);
            color: #4ade80;
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
            
            .register-container {
                right: 5%;
                width: 350px;
                max-width: 45%;
            }
        }

        @media (max-width: 600px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .priority-heading {
                font-size: 32px;
                letter-spacing: 1px;
                left: 5%;
                max-width: 90%;
                top: 20%;
                transform: translateY(0);
            }
            
            .register-container {
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
    <h2 class="priority-heading">Seamless Stays, One Click Away</h2>
    <a href="/" class="back-link">← Back to Home</a>
    
    <div class="register-container">
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

        <form id="registerForm">
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" placeholder="First Name" required>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" placeholder="Last Name" required>
                </div>
            </div>

            <div class="form-group full-width">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group full-width">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="form-group full-width">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            </div>

            <div class="form-group full-width">
                <label for="phone">Phone Number</label>
                <input type="tel" id="phone" name="phone" placeholder="e.g., +1 (555) 123-4567 or 555-123-4567" required>
            </div>

                <div class="form-group full-width">
                    <label for="role">Account Type</label>
                    <select id="role" name="role" required>
                        <option value="">Select Account Type</option>
                        <option value="GUEST">Guests</option>
                        <option value="ADMIN">Admin</option>
                        <option value="STAFF">Staff</option>
                    </select>
                </div>

            <button type="submit" class="btn-register">Create Account</button>
        </form>

        <div class="links">
            <a href="/login">Already have an account? Sign In</a>
        </div>
    </div>

    <script>
        // Form validation and submission
        document.getElementById('registerForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const firstName = document.getElementById('firstName').value;
            const lastName = document.getElementById('lastName').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const phone = document.getElementById('phone').value;
            const role = document.getElementById('role').value;
            
            if (!firstName || !lastName || !email || !password || !confirmPassword || !phone || !role) {
                alert('Please fill in all fields');
                return;
            }
            
            // Email validation
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                alert('Please enter a valid email address');
                return;
            }
            
            // Password validation
            if (password.length < 6) {
                alert('Password must be at least 6 characters long');
                return;
            }
            
            // Password confirmation
            if (password !== confirmPassword) {
                alert('Passwords do not match');
                return;
            }
            
            // Phone validation - more flexible regex
            const phoneRegex = /^[\+]?[\d\s\-\(\)]{7,20}$/;
            if (!phoneRegex.test(phone)) {
                alert('Please enter a valid phone number (7-20 digits, can include spaces, dashes, parentheses)');
                return;
            }

            // Prepare JSON data for API
            const registrationData = {
                username: email, // Use email as username
                email: email,
                password: password,
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phone,
                accountType: role
            };

            try {
                const response = await fetch('/api/auth/register', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(registrationData)
                });

                if (response.ok) {
                    alert('Account created successfully! You can now sign in.');
                    window.location.href = '/login';
                } else {
                    const errorText = await response.text();
                    alert('Registration failed: ' + errorText);
                }
            } catch (error) {
                console.error('Registration error:', error);
                alert('Registration failed. Please try again.');
            }
        });

        // Real-time password confirmation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (password !== confirmPassword) {
                this.style.borderColor = 'rgba(255, 0, 0, 0.5)';
            } else {
                this.style.borderColor = 'rgba(255, 255, 255, 0.3)';
            }
        });
    </script>
</body>
</html>
