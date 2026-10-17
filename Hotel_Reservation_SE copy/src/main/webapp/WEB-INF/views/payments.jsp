<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management - GrandStay Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1920') center/cover no-repeat fixed;
            min-height: 100vh;
            padding: 20px;
        }

        .header {
            background: rgba(255, 255, 255, 0.4);
            color: #333;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
        }

        .header p {
            font-size: 1.2rem;
            opacity: 0.7;
        }

        .main-content {
            background: rgba(255, 255, 255, 0.4);
            border-radius: 20px;
            padding: 40px;
            margin-top: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .stats-card {
            background: rgba(255, 255, 255, 0.3);
            color: #333;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.1);
        }

        .stats-card:hover {
            transform: translateY(-5px);
        }

        .stats-card h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .stats-card p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .table-container {
            background: rgba(255, 255, 255, 0.3);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }

        .table th {
            background: rgba(248, 249, 250, 0.3);
            color: #333;
            border: none;
            padding: 15px;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }

        .table td {
            padding: 15px;
            vertical-align: middle;
            border-color: #f8f9fa;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .badge {
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .badge-success {
            background: #28a745;
            color: white;
        }

        .badge-warning {
            background: #ffc107;
            color: #212529;
        }

        .badge-danger {
            background: #dc3545;
            color: white;
        }

        .btn {
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .btn-primary {
            background: #007bff;
            border: none;
            color: white;
        }

        .btn-success {
            background: #28a745;
            border: none;
            color: white;
        }

        .btn-danger {
            background: #dc3545;
            border: none;
            color: white;
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-credit-card"></i> Payment Management</h1>
        <p>Monitor and manage all payment transactions with comprehensive analytics</p>
    </div>

    <div class="container-fluid">
        <div class="main-content">
            <!-- Statistics Cards -->
            <div class="row">
                <div class="col-md-4">
                    <div class="stats-card">
                        <h3>${totalPayments}</h3>
                        <p><i class="fas fa-receipt"></i> Total Payments</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card">
                        <h3>$<fmt:formatNumber value="${totalAmount}" pattern="#,##0.00"/></h3>
                        <p><i class="fas fa-dollar-sign"></i> Total Amount</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card">
                        <h3>0</h3>
                        <p><i class="fas fa-check-circle"></i> Completed</p>
                    </div>
                </div>
            </div>

            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>

            <!-- Payments Table -->
            <div class="table-container">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3><i class="fas fa-list"></i> Payment Transactions</h3>
                    <button class="btn btn-primary" onclick="location.reload()">
                        <i class="fas fa-sync-alt"></i> Refresh
                    </button>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Payment ID</th>
                                <th>Reservation</th>
                                <th>Guest</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty payments}">
                                    <tr>
                                        <td colspan="8" class="text-center">No payments found</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="payment" items="${payments}">
                                        <tr>
                                            <td><strong>#${payment.id}</strong></td>
                                            <td>${payment.reservationNumber}</td>
                                            <td>${payment.guestName}</td>
                                            <td><strong>$<fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></strong></td>
                                            <td>
                                                <span class="badge badge-primary">${payment.paymentMethod}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${payment.status == 'COMPLETED'}">
                                                        <span class="badge badge-success">${payment.status}</span>
                                                    </c:when>
                                                    <c:when test="${payment.status == 'PENDING'}">
                                                        <span class="badge badge-warning">${payment.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-danger">${payment.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><fmt:formatDate value="${payment.createdAt}" pattern="MMM dd, yyyy HH:mm"/></td>
                                            <td>
                                                <button class="btn btn-success btn-sm" onclick="updatePaymentStatus(${payment.id}, 'COMPLETED')">
                                                    <i class="fas fa-check"></i>
                                                </button>
                                                <button class="btn btn-danger btn-sm" onclick="updatePaymentStatus(${payment.id}, 'FAILED')">
                                                    <i class="fas fa-times"></i>
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
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updatePaymentStatus(paymentId, newStatus) {
            if (confirm('Are you sure you want to update this payment status to ' + newStatus + '?')) {
                fetch('/api/payments/api/' + paymentId, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({status: newStatus})
                })
                .then(response => response.json())
                .then(data => {
                    alert('Payment status updated successfully!');
                    location.reload();
                })
                .catch(error => {
                    console.error('Error updating payment:', error);
                    alert('Error updating payment status');
                });
            }
        }
    </script>
</body>
</html>