<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Form - GrandStay</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            color: white;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .brand-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .brand-logo svg {
            flex-shrink: 0;
        }
        
        .header h1 {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #ffd700;
        }
        
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #ffd700;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .form-actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #333;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        
        .error-message {
            background: rgba(255, 0, 0, 0.2);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 0, 0, 0.3);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="brand-logo">
                <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="width: 80px; height: 80px; margin-right: 25px;">
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
                    <h1 style="font-size: 3rem; margin: 0; color: #D4AF37; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">GrandStay</h1>
                    <p style="font-size: 1.2rem; margin: 0; color: #F4E5C3; letter-spacing: 3px; opacity: 0.9;">PARADISE</p>
                </div>
            </div>
            <h2>${isEdit ? 'Edit Hotel' : 'Add New Hotel'}</h2>
            <p>${isEdit ? 'Update hotel information' : 'Create a new hotel for GrandStay properties'}</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <div class="form-container">
            <form method="post" action="${isEdit ? '/admin/hotels/update/' : '/admin/hotels'}${isEdit ? hotel.id : ''}">
                <div class="form-group">
                    <label for="name">Hotel Name *</label>
                    <input type="text" id="name" name="name" value="${hotel.name}" required>
                </div>
                
                <div class="form-group">
                    <label for="location">Location *</label>
                    <input type="text" id="location" name="location" value="${hotel.location}" required>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="starRating">Star Rating</label>
                        <select id="starRating" name="starRating">
                            <option value="">Select Rating</option>
                            <option value="1" ${hotel.starRating == 1 ? 'selected' : ''}>1 Star</option>
                            <option value="2" ${hotel.starRating == 2 ? 'selected' : ''}>2 Stars</option>
                            <option value="3" ${hotel.starRating == 3 ? 'selected' : ''}>3 Stars</option>
                            <option value="4" ${hotel.starRating == 4 ? 'selected' : ''}>4 Stars</option>
                            <option value="5" ${hotel.starRating == 5 ? 'selected' : ''}>5 Stars</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="contactPhone">Contact Phone</label>
                        <input type="tel" id="contactPhone" name="contactPhone" value="${hotel.contactPhone}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="contactEmail">Contact Email</label>
                    <input type="email" id="contactEmail" name="contactEmail" value="${hotel.contactEmail}">
                </div>
                
                <div class="form-group">
                    <label for="facilities">Facilities</label>
                    <input type="text" id="facilities" name="facilities" value="${hotel.facilities}" placeholder="e.g., Pool, Gym, Spa, Restaurant">
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" placeholder="Describe the hotel, its amenities, and unique features">${hotel.description}</textarea>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn">${isEdit ? 'Update Hotel' : 'Create Hotel'}</button>
                    <a href="/admin/hotels" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>