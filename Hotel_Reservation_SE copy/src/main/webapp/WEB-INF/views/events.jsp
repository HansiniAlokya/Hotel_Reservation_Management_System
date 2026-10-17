<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
            letter-spacing: 2px;
        }

        .header p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
            animation: fadeInUp 1s ease-out 0.2s both;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffd700;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 500;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out 0.4s both;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #000;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(255, 215, 0, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-3px);
        }

        .events-table-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease-out 0.6s both;
            overflow-x: auto;
        }

        .events-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .events-table th {
            background: rgba(255, 215, 0, 0.2);
            color: #ffd700;
            padding: 20px 15px;
            text-align: left;
            font-weight: 600;
            font-size: 1.1rem;
            border-bottom: 2px solid rgba(255, 215, 0, 0.3);
        }

        .events-table td {
            padding: 20px 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
            vertical-align: top;
        }

        .events-table tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .event-name {
            font-weight: 600;
            color: white;
            font-size: 1.1rem;
        }

        .event-date {
            color: #ffd700;
            font-weight: 500;
        }

        .event-location {
            color: rgba(255, 255, 255, 0.8);
            font-style: italic;
        }

        .event-description {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            line-height: 1.4;
            max-width: 300px;
        }

        .hotel-info {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }

        .hotel-name {
            font-weight: 600;
            color: #ffd700;
        }

        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: rgba(34, 197, 94, 0.2);
            color: #22c55e;
            border: 1px solid rgba(34, 197, 94, 0.3);
        }

        .status-inactive {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn-small {
            padding: 8px 16px;
            font-size: 0.9rem;
            border-radius: 20px;
        }

        .btn-edit {
            background: rgba(59, 130, 246, 0.2);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .btn-edit:hover {
            background: rgba(59, 130, 246, 0.3);
            transform: translateY(-2px);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .btn-delete:hover {
            background: rgba(239, 68, 68, 0.3);
            transform: translateY(-2px);
        }

        .btn-toggle {
            background: rgba(168, 85, 247, 0.2);
            color: #a855f7;
            border: 1px solid rgba(168, 85, 247, 0.3);
        }

        .btn-toggle:hover {
            background: rgba(168, 85, 247, 0.3);
            transform: translateY(-2px);
        }

        .no-events {
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.7);
        }

        .no-events h3 {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: rgba(255, 255, 255, 0.9);
        }

        .no-events p {
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .alert {
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            animation: fadeInUp 1s ease-out;
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.2);
            border: 1px solid rgba(34, 197, 94, 0.3);
            color: #22c55e;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #ef4444;
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
            .header h1 {
                font-size: 2.5rem;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-bar {
                flex-direction: column;
                gap: 20px;
            }
            
            .events-table-container {
                padding: 20px;
            }
            
            .events-table {
                font-size: 0.9rem;
            }
            
            .events-table th,
            .events-table td {
                padding: 15px 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <h1>Event Management</h1>
            <p>Manage and organize special events across all GrandStay properties</p>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <strong>Success!</strong> ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <strong>Error!</strong> ${errorMessage}
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

        <!-- Actions Bar -->
        <div class="actions-bar">
            <a href="/admin/events/new" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Event
            </a>
            <a href="/admin/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <!-- Events Table -->
        <div class="events-table-container">
            <c:choose>
                <c:when test="${not empty events}">
                    <table class="events-table">
                        <thead>
                            <tr>
                                <th>Event Name</th>
                                <th>Date & Time</th>
                                <th>Location</th>
                                <th>Hotel</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${events}">
                                <tr>
                                    <td>
                                        <div class="event-name">${event.eventName}</div>
                                    </td>
                                    <td>
                                        <div class="event-date">
                                            <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy" />
                                            <br>
                                            <fmt:formatDate value="${event.eventDate}" pattern="HH:mm" />
                                        </div>
                                    </td>
                                    <td>
                                        <div class="event-location">${event.location}</div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${event.hotel != null}">
                                                <div class="hotel-info">
                                                    <div class="hotel-name">${event.hotel.name}</div>
                                                    <div>${event.hotel.location}</div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="hotel-info">No Hotel Assigned</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="event-description">
                                            <c:choose>
                                                <c:when test="${fn:length(event.description) > 100}">
                                                    ${fn:substring(event.description, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${event.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${event.isActive}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="/admin/events/edit/${event.eventId}" class="btn btn-small btn-edit">
                                                Edit
                                            </a>
                                            <c:choose>
                                                <c:when test="${event.isActive}">
                                                    <a href="/admin/events/deactivate/${event.eventId}" class="btn btn-small btn-toggle">
                                                        Deactivate
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/admin/events/activate/${event.eventId}" class="btn btn-small btn-toggle">
                                                        Activate
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="/admin/events/delete/${event.eventId}" class="btn btn-small btn-delete" 
                                               onclick="return confirm('Are you sure you want to delete this event?')">
                                                Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="no-events">
                        <h3>No Events Found</h3>
                        <p>Start by creating your first event to get started.</p>
                        <a href="/admin/events/new" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Create First Event
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</body>
</html>