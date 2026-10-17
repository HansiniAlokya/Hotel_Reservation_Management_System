<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upcoming Events - GrandStay</title>
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
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .header h1 {
            color: #2c3e50;
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 300;
        }

        .header p {
            color: #7f8c8d;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .back-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: rgba(52, 152, 219, 0.1);
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(52, 152, 219, 0.2);
            transform: translateY(-2px);
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .event-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .event-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
        }

        .event-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(45deg, #3498db, #2980b9);
        }

        .event-header {
            margin-bottom: 20px;
        }

        .event-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .event-date {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #3498db;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .event-date-icon {
            width: 20px;
            height: 20px;
            background: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
        }

        .event-location {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #7f8c8d;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        .event-location-icon {
            width: 16px;
            height: 16px;
            background: #95a5a6;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 10px;
        }

        .event-description {
            color: #5a6c7d;
            line-height: 1.6;
            margin-bottom: 25px;
            font-size: 0.95rem;
        }

        .event-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
            flex: 1;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #2980b9, #1f618d);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(45deg, #27ae60, #229954);
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(45deg, #229954, #1e8449);
            transform: translateY(-2px);
        }

        .no-events {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        .no-events h3 {
            color: #7f8c8d;
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 300;
        }

        .no-events p {
            color: #95a5a6;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .stats-bar {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stats-bar h3 {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 10px;
        }

        .stats-bar p {
            color: #7f8c8d;
            font-size: 1rem;
        }

        .time-until {
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
            margin-top: 10px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2.5rem;
            }
            
            .events-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .event-card {
                padding: 20px;
            }
            
            .event-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Upcoming Events</h1>
            <p>Discover exciting events happening at GrandStay</p>
            <a href="/dashboard" class="back-link">
                ← Back to Dashboard
            </a>
        </div>

        <!-- Stats Bar -->
        <div class="stats-bar">
            <h3>${totalEvents} Upcoming Events</h3>
            <p>Don't miss out on these amazing experiences!</p>
        </div>

        <!-- Events Grid -->
        <c:choose>
            <c:when test="${empty events}">
                <div class="no-events">
                    <h3>No Upcoming Events</h3>
                    <p>We're working on bringing you amazing events soon!</p>
                    <a href="/dashboard" class="btn btn-primary">
                        Back to Dashboard
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="events-grid">
                    <c:forEach var="event" items="${events}">
                        <div class="event-card">
                            <div class="event-header">
                                <h3 class="event-name">${event.eventName}</h3>
                                <div class="event-date">
                                    <div class="event-date-icon">📅</div>
                                    <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMMM dd, yyyy 'at' HH:mm"/>
                                </div>
                                <div class="event-location">
                                    <div class="event-location-icon">📍</div>
                                    ${event.location}
                                </div>
                            </div>
                            
                            <c:if test="${not empty event.description}">
                                <div class="event-description">
                                    ${event.description}
                                </div>
                            </c:if>
                            
                            <div class="time-until" id="time-until-${event.eventId}">
                                <!-- JavaScript will populate this -->
                            </div>
                            
                            <div class="event-actions">
                                <a href="/make-reservation" class="btn btn-primary">
                                    Book Now
                                </a>
                                <a href="/dashboard" class="btn btn-secondary">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Calculate time until each event
        function updateTimeUntil() {
            <c:forEach var="event" items="${events}">
                const eventDate${event.eventId} = new Date('<fmt:formatDate value="${event.eventDate}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>');
                const now = new Date();
                const timeDiff = eventDate${event.eventId} - now;
                
                if (timeDiff > 0) {
                    const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
                    const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));
                    
                    let timeString = '';
                    if (days > 0) {
                        timeString = days + ' day' + (days > 1 ? 's' : '') + ' remaining';
                    } else if (hours > 0) {
                        timeString = hours + ' hour' + (hours > 1 ? 's' : '') + ' remaining';
                    } else {
                        timeString = minutes + ' minute' + (minutes > 1 ? 's' : '') + ' remaining';
                    }
                    
                    const element = document.getElementById('time-until-${event.eventId}');
                    if (element) {
                        element.textContent = timeString;
                    }
                } else {
                    const element = document.getElementById('time-until-${event.eventId}');
                    if (element) {
                        element.textContent = 'Event has started';
                        element.style.background = 'rgba(231, 76, 60, 0.1)';
                        element.style.color = '#e74c3c';
                    }
                }
            </c:forEach>
        }
        
        // Update time every minute
        document.addEventListener('DOMContentLoaded', function() {
            updateTimeUntil();
            setInterval(updateTimeUntil, 60000); // Update every minute
        });
        
        // Add smooth scrolling for better UX
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>
