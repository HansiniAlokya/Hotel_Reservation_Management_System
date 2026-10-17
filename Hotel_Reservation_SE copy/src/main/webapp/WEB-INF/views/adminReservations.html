<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Reservations - GrandStay</title>
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
        .loading {
            text-align: center;
            color: #666;
            font-style: italic;
        }
        .error {
            color: #dc3545;
            text-align: center;
            padding: 20px;
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            margin: 20px 0;
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
            color: #333;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .status {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        .status.pending {
            background-color: #fff3cd;
            color: #856404;
        }
        .status.confirmed {
            background-color: #d4edda;
            color: #155724;
        }
        .status.cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
        .btn {
            padding: 6px 12px;
            margin: 2px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Reservation Management</h1>
        <div id="loading" class="loading">Loading reservations...</div>
        <div id="error" class="error" style="display: none;"></div>
        <div id="reservations-container" style="display: none;">
            <table id="reservations-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Reservation Number</th>
                        <th>Guest Name</th>
                        <th>Guest Email</th>
                        <th>Hotel</th>
                        <th>Check-in Date</th>
                        <th>Check-out Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="reservations-tbody">
                </tbody>
            </table>
        </div>
    </div>

    <script>
        async function loadReservations() {
            try {
                const response = await fetch('/api/reservations/admin/all');
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const reservations = await response.json();
                
                document.getElementById('loading').style.display = 'none';
                
                if (reservations.length === 0) {
                    document.getElementById('error').textContent = 'No reservations found.';
                    document.getElementById('error').style.display = 'block';
                    return;
                }
                
                displayReservations(reservations);
                
            } catch (error) {
                console.error('Error loading reservations:', error);
                document.getElementById('loading').style.display = 'none';
                document.getElementById('error').textContent = 'Error loading reservations: ' + error.message;
                document.getElementById('error').style.display = 'block';
            }
        }
        
        function displayReservations(reservations) {
            const tbody = document.getElementById('reservations-tbody');
            tbody.innerHTML = '';
            
            reservations.forEach(reservation => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${reservation.id}</td>
                    <td>${reservation.reservationNumber}</td>
                    <td>${reservation.guestName || 'N/A'}</td>
                    <td>${reservation.guestEmail || 'N/A'}</td>
                    <td>${reservation.hotelName || 'N/A'}</td>
                    <td>${formatDate(reservation.checkInDate)}</td>
                    <td>${formatDate(reservation.checkOutDate)}</td>
                    <td>$${reservation.totalAmount || '0.00'}</td>
                    <td><span class="status ${(reservation.status || 'pending').toLowerCase()}">${reservation.status || 'PENDING'}</span></td>
                    <td>${formatDate(reservation.createdAt)}</td>
                    <td>
                        <button class="btn btn-success" onclick="confirmReservation(${reservation.id})">Confirm</button>
                        <button class="btn btn-danger" onclick="cancelReservation(${reservation.id})">Cancel</button>
                    </td>
                `;
                tbody.appendChild(row);
            });
            
            document.getElementById('reservations-container').style.display = 'block';
        }
        
        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
        }
        
        function confirmReservation(id) {
            if (confirm('Are you sure you want to confirm this reservation?')) {
                // TODO: Implement confirmation logic
                alert('Reservation confirmation feature not yet implemented.');
            }
        }
        
        function cancelReservation(id) {
            if (confirm('Are you sure you want to cancel this reservation?')) {
                // TODO: Implement cancellation logic
                alert('Reservation cancellation feature not yet implemented.');
            }
        }
        
        // Load reservations when page loads
        document.addEventListener('DOMContentLoaded', loadReservations);
    </script>
</body>
</html>
