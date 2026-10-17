<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management - GrandStay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            color: white;
            overflow-x: hidden;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
            animation: fadeInUp 1s ease-out;
        }

        .header h1 {
            font-size: 3.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #ffd700, #ffed4e, #ffd700);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 30px rgba(255, 215, 0, 0.5);
            margin-bottom: 10px;
        }

        .header p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 300;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            animation: fadeInUp 1s ease-out;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            color: #ffd700;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        .actions-section {
            text-align: center;
            margin-bottom: 40px;
        }

        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #000;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            margin: 0 10px;
            box-shadow: 0 10px 20px rgba(255, 215, 0, 0.3);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(255, 215, 0, 0.4);
            background: linear-gradient(45deg, #ffed4e, #ffd700);
        }

        .events-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .event-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .event-item:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .event-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 15px;
        }

        .event-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #ffd700;
            margin-bottom: 5px;
        }

        .event-date {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
        }

        .event-location {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 5px;
        }

        .event-hotel {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 15px;
        }

        .event-description {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 15px;
            line-height: 1.4;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 15px;
        }

        .status-active {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.3);
        }

        .status-inactive {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.3);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-small {
            padding: 8px 16px;
            font-size: 0.9rem;
            border-radius: 15px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-edit {
            background: rgba(52, 152, 219, 0.2);
            color: #3498db;
            border: 1px solid rgba(52, 152, 219, 0.3);
        }

        .btn-edit:hover {
            background: rgba(52, 152, 219, 0.3);
            transform: translateY(-2px);
        }

        .btn-delete {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.3);
        }

        .btn-delete:hover {
            background: rgba(231, 76, 60, 0.3);
            transform: translateY(-2px);
        }

        .btn-activate {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.3);
        }

        .btn-activate:hover {
            background: rgba(46, 204, 113, 0.3);
            transform: translateY(-2px);
        }

        .btn-deactivate {
            background: rgba(241, 196, 15, 0.2);
            color: #f1c40f;
            border: 1px solid rgba(241, 196, 15, 0.3);
        }

        .btn-deactivate:hover {
            background: rgba(241, 196, 15, 0.3);
            transform: translateY(-2px);
        }

        .no-events {
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 1.2rem;
        }

        .error-message {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid rgba(231, 76, 60, 0.3);
        }

        .success-message {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid rgba(46, 204, 113, 0.3);
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

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2.5rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .events-container {
                padding: 15px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Event Management</h1>
            <p>Manage and organize special events across all GrandStay properties</p>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Statistics Cards -->
        <div class="stats-grid">
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

        <!-- Action Buttons -->
        <div class="actions-section">
            <a href="/admin/events/new" class="btn">+ Add New Event</a>
            <a href="/dashboard" class="btn">← Back to Dashboard</a>
        </div>

        <!-- Events List -->
        <div class="events-container">
            <c:choose>
                <c:when test="${not empty events}">
                    <c:forEach var="event" items="${events}">
                        <div class="event-item">
                            <div class="event-name">${event.eventName}</div>
                            <div class="event-date">
                                <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy 'at' HH:mm"/>
                            </div>
                            <div class="event-location">📍 ${event.location}</div>
                            <div class="event-hotel">
                                <c:choose>
                                    <c:when test="${event.hotel != null}">
                                        🏨 <strong>${event.hotel.name}</strong> - ${event.hotel.location}
                                    </c:when>
                                    <c:otherwise>
                                        🏨 No hotel assigned
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty event.description}">
                                <div class="event-description">${event.description}</div>
                            </c:if>
                            <div>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <span class="status-badge status-active">✓ Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-inactive">✗ Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="action-buttons">
                                <a href="/admin/events/edit/${event.eventId}" class="btn-small btn-edit">✏️ Edit</a>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <a href="/admin/events/deactivate/${event.eventId}" class="btn-small btn-deactivate">⏸️ Deactivate</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/admin/events/activate/${event.eventId}" class="btn-small btn-activate">▶️ Activate</a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="/admin/events/delete/${event.eventId}" class="btn-small btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this event?')">🗑️ Delete</a>
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
