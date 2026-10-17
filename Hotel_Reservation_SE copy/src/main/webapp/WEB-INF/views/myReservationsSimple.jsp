<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reservations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .reservation-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background: #f9f9f9;
        }
        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .reservation-number {
            font-weight: bold;
            color: #2c3e50;
        }
        .status {
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: bold;
            text-transform: uppercase;
        }
        .status.pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status.confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        .reservation-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        .detail-item {
            display: flex;
            flex-direction: column;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
            font-size: 0.9em;
        }
        .detail-value {
            color: #333;
            margin-top: 5px;
        }
        .no-reservations {
            text-align: center;
            color: #666;
            font-style: italic;
            padding: 40px;
        }
        .error {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>My Reservations</h1>
        
        <c:if test="${not empty error}">
            <div class="error">
                ${error}
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${not empty reservations}">
                <c:forEach var="reservation" items="${reservations}">
                    <div class="reservation-card">
                        <div class="reservation-header">
                            <div class="reservation-number">Reservation #${reservation.reservationNumber}</div>
                            <div class="status ${reservation.status.toLowerCase()}">${reservation.status}</div>
                        </div>
                        
                        <div class="reservation-details">
                            <div class="detail-item">
                                <div class="detail-label">Hotel</div>
                                <div class="detail-value">${reservation.hotelName}</div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Check-in Date</div>
                                <div class="detail-value">
                                    <fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd, yyyy"/>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Check-out Date</div>
                                <div class="detail-value">
                                    <fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy"/>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Total Amount</div>
                                <div class="detail-value">
                                    <fmt:formatNumber value="${reservation.totalAmount}" type="currency"/>
                                </div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Guest Name</div>
                                <div class="detail-value">${reservation.guestName}</div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Guest Email</div>
                                <div class="detail-value">${reservation.guestEmail}</div>
                            </div>
                            
                            <div class="detail-item">
                                <div class="detail-label">Created At</div>
                                <div class="detail-value">
                                    <fmt:formatDate value="${reservation.createdAt}" pattern="MMM dd, yyyy HH:mm"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-reservations">
                    No reservations found.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>