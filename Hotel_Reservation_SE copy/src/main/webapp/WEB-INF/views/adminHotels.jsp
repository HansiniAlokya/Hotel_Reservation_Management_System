<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management - GrandStay</title>
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
            max-width: 1200px;
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
        
        .stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffd700;
        }
        
        .stat-label {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.7);
        }
        
        .actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 40px;
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
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
        
        .hotels-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }
        
        .hotels-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }
        
        .hotel-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }
        
        .hotel-item:hover {
            transform: translateY(-5px);
        }
        
        .hotel-item h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #ffd700;
        }
        
        .hotel-item p {
            font-size: 0.95rem;
            line-height: 1.6;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 8px;
        }
        
        .hotel-item .actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }
        
        .hotel-item .btn-small {
            padding: 8px 15px;
            font-size: 0.85rem;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            text-decoration: none;
            transition: background 0.2s ease;
        }
        
        .hotel-item .btn-small:hover {
            background: rgba(255, 255, 255, 0.25);
        }
        
        .hotel-item .btn-delete {
            background: rgba(255, 0, 0, 0.2);
            border-color: rgba(255, 0, 0, 0.3);
            color: #ff6b6b;
        }
        
        .hotel-item .btn-delete:hover {
            background: rgba(255, 0, 0, 0.3);
        }
        
        .no-hotels {
            text-align: center;
            padding: 50px;
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.7);
        }
        
        .error-message {
            background: rgba(255, 0, 0, 0.2);
            color: #ff6b6b;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 0, 0, 0.3);
        }
        
        .success-message {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(46, 204, 113, 0.3);
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
            <h2>Hotel Management</h2>
            <p>Manage and organize hotels across all GrandStay properties</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">${totalHotels}</div>
                <div class="stat-label">Total Hotels</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${activeHotels}</div>
                <div class="stat-label">Active Hotels</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${totalHotels - activeHotels}</div>
                <div class="stat-label">Inactive Hotels</div>
            </div>
        </div>

        <div class="actions">
            <a href="/admin/hotels/new" class="btn">+ Add New Hotel</a>
            <a href="/dashboard" class="btn">← Back to Dashboard</a>
        </div>

        <div class="hotels-container">
            <c:choose>
                <c:when test="${not empty hotels}">
                    <div class="hotels-grid">
                        <c:forEach var="hotel" items="${hotels}">
                            <div class="hotel-item">
                                <h3>${hotel.name}</h3>
                                <p><strong>Location:</strong> ${hotel.location}</p>
                                <p><strong>Star Rating:</strong> ${hotel.starRating != null ? hotel.starRating : 'N/A'}</p>
                                <p><strong>Contact:</strong> ${hotel.contactPhone != null ? hotel.contactPhone : 'N/A'}</p>
                                <p><strong>Status:</strong> ${hotel.isActive ? 'Active' : 'Inactive'}</p>
                                <p>${hotel.description}</p>
                                <div class="actions">
                                    <a href="/admin/hotels/edit/${hotel.id}" class="btn-small">Edit</a>
                                    <c:if test="${hotel.isActive}">
                                        <a href="/admin/hotels/deactivate/${hotel.id}" class="btn-small btn-delete">Deactivate</a>
                                    </c:if>
                                    <c:if test="${!hotel.isActive}">
                                        <a href="/admin/hotels/activate/${hotel.id}" class="btn-small">Activate</a>
                                    </c:if>
                                    <a href="/admin/hotels/delete/${hotel.id}" class="btn-small btn-delete" onclick="return confirm('Are you sure you want to delete this hotel?');">Delete</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="no-hotels">No hotels found. Start by adding a new hotel!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
