<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management - GrandStay</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1445019980597-93fa8acb246c?w=1920');
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
            background: linear-gradient(45deg, #ffffff, #f0f0f0);
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
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .actions {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(45deg, #ffffff, #f0f0f0);
            color: #000;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            margin: 0 10px;
            transition: transform 0.3s ease;
        }
        
        .btn:hover {
            transform: translateY(-3px);
        }
        
        .events-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .event-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .event-name {
            font-size: 1.2rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 8px;
        }
        
        .event-details {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
        }
        
        .event-hotel {
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 15px;
        }
        
        .status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .status-active {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
        }
        
        .status-inactive {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
        }
        
        .btn-small {
            padding: 6px 12px;
            font-size: 0.8rem;
            border-radius: 10px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-edit {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
            border: 1px solid rgba(52, 152, 219, 0.3);
        }
        
        .btn-delete {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.3);
        }
        
        .btn-activate {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.3);
        }
        
        .btn-deactivate {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .no-events {
            text-align: center;
            padding: 40px;
            color: rgba(255, 255, 255, 0.6);
        }
        
        .error-message {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(231, 76, 60, 0.3);
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
                    <h1 style="font-size: 3rem; margin: 0; color: #ffffff; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);">GrandStay</h1>
                    <p style="font-size: 1.2rem; margin: 0; color: #ffffff; letter-spacing: 3px; opacity: 0.9;">PARADISE</p>
                </div>
            </div>
            <h2>Event Management</h2>
            <p>Manage and organize special events across all GrandStay properties</p>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">${totalEvents}</div>
                <div class="stat-label">Total Events</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${activeEvents}</div>
                <div class="stat-label">Active Events</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${upcomingEvents}</div>
                <div class="stat-label">Upcoming Events</div>
            </div>
        </div>

        <div class="actions">
            <a href="/admin/events/new" class="btn">+ Add New Event</a>
            <a href="/dashboard" class="btn">← Back to Dashboard</a>
        </div>

        <div class="events-container">
            <c:choose>
                <c:when test="${not empty events}">
                    <c:forEach var="event" items="${events}">
                        <div class="event-item">
                            <div class="event-name">${event.eventName}</div>
                            <div class="event-details">📅 ${event.eventDate}</div>
                            <div class="event-details">📍 ${event.location}</div>
                            <div class="event-hotel">
                                <c:choose>
                                    <c:when test="${event.hotel != null}">
                                        🏨 ${event.hotel.name} - ${event.hotel.location}
                                    </c:when>
                                    <c:otherwise>
                                        🏨 No hotel assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty event.description}">
                                <div class="event-details">${event.description}</div>
                            </c:if>
                            <div>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <span class="status status-active">✓ Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status status-inactive">✗ Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="action-buttons">
                                <a href="/admin/events/edit/${event.eventId}" class="btn-small btn-edit">Edit</a>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <a href="/admin/events/deactivate/${event.eventId}" class="btn-small btn-deactivate">Deactivate</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/admin/events/activate/${event.eventId}" class="btn-small btn-activate">Activate</a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="/admin/events/delete/${event.eventId}" class="btn-small btn-delete" 
                                   onclick="return confirm('Delete this event?')">Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-events">
                        <h3>No events found</h3>
                        <p>Start by creating your first event!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
