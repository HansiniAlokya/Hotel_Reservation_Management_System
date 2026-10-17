<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Management - GrandStay Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            flex: 1;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-card h3 {
            font-size: 24px;
            margin: 0;
            color: #007bff;
        }
        .stat-card p {
            margin: 5px 0 0 0;
            color: #666;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .status-pending { color: #ffc107; font-weight: bold; }
        .status-confirmed { color: #28a745; font-weight: bold; }
        .status-cancelled { color: #dc3545; font-weight: bold; }
        .btn {
            padding: 5px 10px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-confirm { background: #28a745; color: white; }
        .btn-reject { background: #dc3545; color: white; }
        .btn:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reservation Management - GrandStay Admin</h1>
        
        <!-- Statistics -->
        <div class="stats">
            <div class="stat-card">
                <h3>${reservations.size()}</h3>
                <p>Total Reservations</p>
            </div>
            <div class="stat-card">
                <h3>${pendingReservations.size()}</h3>
                <p>Pending Approval</p>
            </div>
            <div class="stat-card">
                <h3>${confirmedReservations.size()}</h3>
                <p>Confirmed</p>
            </div>
            <div class="stat-card">
                <h3>${cancelledReservations.size()}</h3>
                <p>Cancelled</p>
            </div>
        </div>
        
        <!-- Debug Information -->
        <div style="background: #f8f9fa; padding: 15px; margin: 20px 0; border-radius: 5px;">
            <h3>Debug Information:</h3>
            <p>Total Reservations: ${reservations.size()}</p>
            <p>Pending Reservations: ${pendingReservations.size()}</p>
            <p>Confirmed Reservations: ${confirmedReservations.size()}</p>
            <p>Cancelled Reservations: ${cancelledReservations.size()}</p>
            <%
                java.util.List<com.hotelreservation.dto.ReservationResponseDTO> reservations = 
                    (java.util.List<com.hotelreservation.dto.ReservationResponseDTO>) request.getAttribute("reservations");
                if (reservations != null && !reservations.isEmpty()) {
                    out.println("<p>First Reservation Status: " + reservations.get(0).getStatus() + "</p>");
                    out.println("<p>First Reservation Guest: " + reservations.get(0).getGuestName() + "</p>");
                } else {
                    out.println("<p>No reservations found in request attribute</p>");
                }
            %>
        </div>
        
        <!-- Reservations Table -->
        <table>
            <thead>
                <tr>
                    <th>Reservation #</th>
                    <th>Guest Name</th>
                    <th>Hotel</th>
                    <th>Room</th>
                    <th>Check-in</th>
                    <th>Check-out</th>
                    <th>Guests</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (reservations != null && !reservations.isEmpty()) {
                        for (com.hotelreservation.dto.ReservationResponseDTO reservation : reservations) {
                            out.println("<tr>");
                            out.println("<td>" + reservation.getReservationNumber() + "</td>");
                            out.println("<td>" + reservation.getGuestName() + "</td>");
                            out.println("<td>" + reservation.getHotelName() + "</td>");
                            out.println("<td>" + reservation.getRoomNumber() + " (" + reservation.getRoomType() + ")</td>");
                            out.println("<td>" + reservation.getCheckInDate() + "</td>");
                            out.println("<td>" + reservation.getCheckOutDate() + "</td>");
                            out.println("<td>" + reservation.getNumberOfGuests() + "</td>");
                            out.println("<td>$" + reservation.getTotalAmount() + "</td>");
                            out.println("<td class='status-" + reservation.getStatus().toLowerCase() + "'>" + reservation.getStatus() + "</td>");
                            out.println("<td>");
                            if ("PENDING".equals(reservation.getStatus())) {
                                out.println("<button class='btn btn-confirm' onclick=\"updateReservationStatus(" + reservation.getId() + ", 'CONFIRMED')\">Confirm</button>");
                                out.println("<button class='btn btn-reject' onclick=\"updateReservationStatus(" + reservation.getId() + ", 'CANCELLED')\">Reject</button>");
                            } else {
                                out.println("<span style='opacity: 0.6;'>No actions</span>");
                            }
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    } else {
                        out.println("<tr><td colspan='10' style='text-align: center;'>No reservations found</td></tr>");
                    }
                %>
            </tbody>
        </table>
    </div>
    
    <script>
        async function updateReservationStatus(reservationId, newStatus) {
            try {
                console.log('Updating reservation', reservationId, 'to', newStatus);
                const endpoint = newStatus === 'CONFIRMED' ? 'confirm' : 'reject';
                const url = '/api/reservations/admin/' + reservationId + '/' + endpoint;
                console.log('Making request to:', url);
                
                const response = await fetch(url, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });

                console.log('Response status:', response.status);
                console.log('Response ok:', response.ok);

                if (!response.ok) {
                    const errorText = await response.text();
                    console.error('Error response:', errorText);
                    throw new Error('HTTP ' + response.status + ': ' + errorText);
                }

                const result = await response.json();
                console.log('Success response:', result);
                
                alert('Reservation ' + newStatus.toLowerCase() + ' successfully!');
                location.reload(); // Reload page to show updated status
                
            } catch (error) {
                console.error('Error updating reservation status:', error);
                alert('Failed to update reservation status: ' + error.message);
            }
        }
    </script>
</body>
</html>
