<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Details - GrandStay Paradise</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 12px 25px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .event-header {
            text-align: center;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid rgba(102, 126, 234, 0.1);
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

        .event-title {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 15px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .event-date {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }

        .event-location {
            color: #666;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .event-location::before {
            content: "📍";
            margin-right: 10px;
            font-size: 1.5rem;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 40px;
            margin-top: 30px;
        }

        .event-info {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .info-section {
            margin-bottom: 30px;
        }

        .info-section h3 {
            color: #333;
            font-size: 1.3rem;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .info-section h3::before {
            content: "";
            width: 4px;
            height: 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin-right: 10px;
            border-radius: 2px;
        }

        .event-description {
            color: #555;
            line-height: 1.8;
            font-size: 1rem;
        }

        .hotel-info {
            background: rgba(102, 126, 234, 0.1);
            padding: 20px;
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }

        .hotel-name {
            font-size: 1.2rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .hotel-details {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .reservation-form {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }

        .form-title {
            color: #333;
            font-size: 1.5rem;
            margin-bottom: 25px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.2);
        }

        .alert-error {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 10px;
            }

            .event-title {
                font-size: 2rem;
            }

            .content-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .event-info,
            .reservation-form {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/guest/browse-events" class="back-btn">← Back to Events</a>
        
        <div class="event-header">
            <div class="brand-logo">
                <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg" style="width: 60px; height: 60px; margin-right: 15px;">
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
                    <h1 style="font-size: 2.5em; margin: 0; color: #D4AF37; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">GrandStay</h1>
                    <p style="font-size: 1em; margin: 0; color: #F4E5C3; letter-spacing: 2px; opacity: 0.9;">PARADISE</p>
                </div>
            </div>
            <h2 class="event-title">${event.eventName}</h2>
            <div class="event-date">
                ${formattedEventDate}
            </div>
            <div class="event-location">${event.location}</div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                ${errorMessage}
            </div>
        </c:if>

        <div class="content-grid">
            <div class="event-info">
                <div class="info-section">
                    <h3>Event Description</h3>
                    <div class="event-description">
                        <c:choose>
                            <c:when test="${not empty event.description}">
                                ${event.description}
                            </c:when>
                            <c:otherwise>
                                No description available for this event.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <c:if test="${event.hotel != null}">
                    <div class="info-section">
                        <h3>Venue Information</h3>
                        <div class="hotel-info">
                            <div class="hotel-name">🏨 ${event.hotel.name}</div>
                            <div class="hotel-details">
                                <strong>Location:</strong> ${event.hotel.location}<br>
                                <c:if test="${not empty event.hotel.description}">
                                    <strong>About:</strong> ${event.hotel.description}<br>
                                </c:if>
                                <c:if test="${event.hotel.starRating != null}">
                                    <strong>Rating:</strong> ${event.hotel.starRating} ⭐<br>
                                </c:if>
                                <c:if test="${not empty event.hotel.contactPhone}">
                                    <strong>Contact:</strong> ${event.hotel.contactPhone}
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>

            <div class="reservation-form">
                <h3 class="form-title">Reserve This Event</h3>
                
                <form action="/guest/reserve-event" method="post">
                    <input type="hidden" name="eventId" value="${event.eventId}">
                    
                    <div class="form-group">
                        <label for="guestName">Full Name *</label>
                        <input type="text" id="guestName" name="guestName" 
                               value="${not empty user ? user.firstName : ''} ${not empty user ? user.lastName : ''}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="guestEmail">Email Address *</label>
                        <input type="email" id="guestEmail" name="guestEmail" 
                               value="${not empty user ? user.email : ''}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="guestPhone">Phone Number *</label>
                        <input type="tel" id="guestPhone" name="guestPhone" 
                               value="${not empty user and not empty user.phoneNumber ? user.phoneNumber : ''}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="specialRequests">Special Requests (Optional)</label>
                        <textarea id="specialRequests" name="specialRequests" 
                                  placeholder="Any special requirements or requests for this event..."></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        Submit Reservation Request
                    </button>
                </form>
                
                <a href="/guest/browse-events" class="btn btn-secondary">
                    Browse Other Events
                </a>
            </div>
        </div>
    </div>
</body>
</html>
