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
        
        .header h1 {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(45deg, #ffd700, #ffed4e, #ffd700);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #ffd700;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        .events-table {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .table-header {
            background: rgba(255, 215, 0, 0.2);
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .table-header h2 {
            margin: 0;
            font-size: 1.5rem;
            color: #ffd700;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        th {
            background: rgba(255, 255, 255, 0.1);
            font-weight: 600;
            color: #ffd700;
        }
        
        tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 2px;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #000;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
        }
        
        .btn-danger {
            background: linear-gradient(45deg, #ff6b6b, #ff8e8e);
            color: white;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }
        
        .btn-success {
            background: linear-gradient(45deg, #51cf66, #69db7c);
            color: white;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(81, 207, 102, 0.4);
        }
        
        .add-event-btn {
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #000;
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .add-event-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.4);
        }
        
        .error-message {
            background: rgba(255, 107, 107, 0.2);
            border: 1px solid rgba(255, 107, 107, 0.5);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            color: #ff6b6b;
        }
        
        .success-message {
            background: rgba(81, 207, 102, 0.2);
            border: 1px solid rgba(81, 207, 102, 0.5);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            color: #51cf66;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Event Management</h1>
            <p>Manage special events and celebrations</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                ${errorMessage}
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="success-message">
                ${successMessage}
            </div>
        </c:if>

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

        <a href="/admin/events/new" class="add-event-btn">+ Add New Event</a>

        <div class="events-table">
            <div class="table-header">
                <h2>All Events</h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Event Name</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Hotel</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="event" items="${events}">
                        <tr>
                            <td><strong>${event.eventName}</strong></td>
                            <td>
                                <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/>
                            </td>
                            <td>${event.location}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${event.hotel != null}">
                                        ${event.hotel.name} - ${event.hotel.location}
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #ff6b6b;">No Hotel Assigned</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <span style="color: #51cf66;">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: #ff6b6b;">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/admin/events/edit/${event.eventId}" class="btn btn-primary">Edit</a>
                                <c:choose>
                                    <c:when test="${event.isActive}">
                                        <a href="/admin/events/deactivate/${event.eventId}" class="btn btn-danger">Deactivate</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/admin/events/activate/${event.eventId}" class="btn btn-success">Activate</a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="/admin/events/delete/${event.eventId}" class="btn btn-danger" 
                                   onclick="return confirm('Are you sure you want to delete this event?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>