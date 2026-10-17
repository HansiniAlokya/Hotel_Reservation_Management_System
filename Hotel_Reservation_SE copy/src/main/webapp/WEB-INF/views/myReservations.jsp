<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reservations - GrandStay Paradise</title>
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
            background-attachment: fixed;
            background-size: cover;
            background-position: center;
            background-image: url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=1920&h=1080&fit=crop');
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            color: #fff;
            font-size: 2.5rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            text-decoration: none;
            border-radius: 25px;
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: all 0.3s;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }

        .main-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .status-info {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .status-info h3 {
            color: #fff;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }

        .status-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.9);
        }

        .status-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .status-pending { background-color: #ffc107; }
        .status-confirmed { background-color: #28a745; }
        .status-cancelled { background-color: #dc3545; }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        th {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        td {
            padding: 15px;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-confirmed, .status-reserved {
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .status-cancelled, .status-no-show {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .status-checked-in {
            background: rgba(0, 123, 255, 0.2);
            color: #007bff;
            border: 1px solid rgba(0, 123, 255, 0.3);
        }

        .status-checked-out {
            background: rgba(108, 117, 125, 0.2);
            color: #6c757d;
            border: 1px solid rgba(108, 117, 125, 0.3);
        }

        .error-message {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #dc3545;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .view-details-btn {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #fff;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.8rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
        }

        .view-details-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-1px);
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            table {
                font-size: 0.9rem;
            }
            
            th, td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📋 My Reservations</h1>
            <p>View all your hotel reservations and their current status</p>
        </div>

        <a href="/dashboard" class="back-btn">← Back to Dashboard</a>

        <div class="main-content">
            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <strong>Error:</strong> ${errorType} - ${errorMessage}
                </div>
            </c:if>
            <div class="status-info">
                <h3>Status Information:</h3>
                <div class="status-item">
                    <div class="status-dot status-pending"></div>
                    <span>PENDING - Your reservation is awaiting admin confirmation</span>
                </div>
                <div class="status-item">
                    <div class="status-dot status-confirmed"></div>
                    <span>CONFIRMED - Your reservation has been confirmed by admin</span>
                </div>
                <div class="status-item">
                    <div class="status-dot status-cancelled"></div>
                    <span>CANCELLED - Your reservation has been cancelled by admin</span>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Reservation #</th>
                        <th>Hotel</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty reservations}">
                            <tr>
                                <td colspan="8" style="text-align: center; padding: 40px; color: rgba(255, 255, 255, 0.8);">
                                    <h3 style="color: #fff; margin-bottom: 15px;">No Reservations Found</h3>
                                    <p>You haven't made any reservations yet.</p>
                                    <a href="/make-reservation" style="display: inline-block; margin-top: 15px; padding: 15px 30px; background: rgba(255, 255, 255, 0.2); backdrop-filter: blur(20px); border: 1px solid rgba(255, 255, 255, 0.3); color: #fff; text-decoration: none; border-radius: 25px; font-size: 14px; letter-spacing: 2px; text-transform: uppercase; transition: all 0.3s;">Make a Reservation</a>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="reservation" items="${reservations}">
                                <tr>
                                    <td><strong>${reservation.reservationNumber}</strong></td>
                                    <td>${reservation.hotelName}</td>
                                    <td>
                                        <fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td><strong>$<fmt:formatNumber value="${reservation.totalAmount}" pattern="0.00" /></strong></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${reservation.status == 'CONFIRMED'}">
                                                <span class="status-badge status-confirmed">CONFIRMED</span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'RESERVED'}">
                                                <span class="status-badge status-reserved">RESERVED</span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CHECKED_IN'}">
                                                <span class="status-badge status-checked-in">CHECKED IN</span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CHECKED_OUT'}">
                                                <span class="status-badge status-checked-out">CHECKED OUT</span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'CANCELLED'}">
                                                <span class="status-badge status-cancelled">CANCELLED</span>
                                            </c:when>
                                            <c:when test="${reservation.status == 'NO_SHOW'}">
                                                <span class="status-badge status-no-show">NO SHOW</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending">PENDING</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${reservation.createdAt}" pattern="MMM dd, yyyy" />
                                    </td>
                                    <td>
                                        <button onclick="showDetails('${reservation.id}', '${reservation.reservationNumber}', '${reservation.hotelName}', '<fmt:formatDate value="${reservation.checkInDate}" pattern="MMM dd, yyyy" />', '<fmt:formatDate value="${reservation.checkOutDate}" pattern="MMM dd, yyyy" />', '${reservation.totalAmount}', '${reservation.status}', '<fmt:formatDate value="${reservation.createdAt}" pattern="MMM dd, yyyy" />')" 
                                                class="view-details-btn">
                                            View Details
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function showDetails(id, reservationNumber, hotelName, checkInDate, checkOutDate, totalAmount, status, createdAt) {
            alert('Reservation Details:\n\n' +
                  'ID: ' + id + '\n' +
                  'Reservation #: ' + reservationNumber + '\n' +
                  'Hotel: ' + hotelName + '\n' +
                  'Check-in: ' + checkInDate + '\n' +
                  'Check-out: ' + checkOutDate + '\n' +
                  'Amount: $' + totalAmount + '\n' +
                  'Status: ' + status + '\n' +
                  'Created: ' + createdAt);
        }
    </script>
</body>
</html>