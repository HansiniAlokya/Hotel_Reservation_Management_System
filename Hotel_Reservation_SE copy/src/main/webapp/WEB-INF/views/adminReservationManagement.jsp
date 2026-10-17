<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Reservation Management Portal</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            min-height: 100vh; 
            padding: 20px; 
        }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { 
            background: white; 
            border-radius: 10px; 
            padding: 20px; 
            margin-bottom: 20px; 
            text-align: center; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        }
        .header h1 { color: #333; margin-bottom: 10px; }
        .stats { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 15px; 
            margin-bottom: 20px; 
        }
        .stat-card { 
            background: white; 
            border-radius: 10px; 
            padding: 20px; 
            text-align: center; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        }
        .stat-number { 
            font-size: 2em; 
            font-weight: bold; 
            margin-bottom: 5px; 
        }
        .total { color: #3498db; }
        .pending { color: #f39c12; }
        .confirmed { color: #27ae60; }
        .cancelled { color: #e74c3c; }
        .main-content { 
            background: white; 
            border-radius: 10px; 
            padding: 20px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        }
        .controls { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 20px; 
            flex-wrap: wrap; 
            gap: 10px; 
        }
        .search-box { flex: 1; min-width: 300px; }
        .search-box input { 
            width: 100%; 
            padding: 10px; 
            border: 1px solid #ddd; 
            border-radius: 5px; 
        }
        .filter-buttons { display: flex; gap: 10px; }
        .filter-btn { 
            padding: 8px 16px; 
            border: 1px solid #ddd; 
            background: white; 
            border-radius: 5px; 
            cursor: pointer; 
        }
        .filter-btn.active { background: #3498db; color: white; }
        .refresh-btn { 
            padding: 10px 20px; 
            background: #27ae60; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            cursor: pointer; 
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
        th { background: #f8f9fa; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .status-badge { 
            padding: 4px 8px; 
            border-radius: 4px; 
            font-size: 0.8em; 
            font-weight: bold; 
        }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-confirmed { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }
        .btn { 
            padding: 6px 12px; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-size: 0.8em; 
            margin-right: 5px; 
        }
        .btn-success { background: #27ae60; color: white; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn:disabled { opacity: 0.5; cursor: not-allowed; }
        .loading { text-align: center; padding: 40px; color: #666; }
        .alert { 
            padding: 10px; 
            margin-bottom: 15px; 
            border-radius: 5px; 
        }
        .alert-success { 
            background: #d4edda; 
            color: #155724; 
            border: 1px solid #c3e6cb; 
        }
        .alert-error { 
            background: #f8d7da; 
            color: #721c24; 
            border: 1px solid #f5c6cb; 
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏨 Admin Reservation Management Portal</h1>
            <p>Manage and monitor all hotel reservations efficiently</p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number total" id="total-count">-</div>
                <div>Total Reservations</div>
            </div>
            <div class="stat-card">
                <div class="stat-number pending" id="pending-count">-</div>
                <div>Pending</div>
            </div>
            <div class="stat-card">
                <div class="stat-number confirmed" id="confirmed-count">-</div>
                <div>Confirmed</div>
            </div>
            <div class="stat-card">
                <div class="stat-number cancelled" id="cancelled-count">-</div>
                <div>Cancelled</div>
            </div>
        </div>
        
        <div class="main-content">
            <div class="controls">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search reservations...">
                </div>
                <div class="filter-buttons">
                    <button class="filter-btn active" data-filter="all">All</button>
                    <button class="filter-btn" data-filter="pending">Pending</button>
                    <button class="filter-btn" data-filter="confirmed">Confirmed</button>
                    <button class="filter-btn" data-filter="cancelled">Cancelled</button>
                </div>
                <button class="refresh-btn" onclick="loadReservations()">Refresh</button>
            </div>
            
            <div id="alert-container"></div>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Reservation #</th>
                        <th>Guest Name</th>
                        <th>Email</th>
                        <th>Hotel</th>
                        <th>Check-in</th>
                        <th>Check-out</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="reservations-tbody">
                    <tr><td colspan="11" class="loading">Loading reservations...</td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        let allReservations = [];
        let currentFilter = 'all';

        async function loadReservations() {
            console.log('Loading reservations...');
            try {
                document.getElementById('reservations-tbody').innerHTML = 
                    '<tr><td colspan="11" class="loading">Loading reservations...</td></tr>';
                
                const response = await fetch('/api/reservations/admin/all');
                console.log('Response status:', response.status);
                
                if (!response.ok) throw new Error('HTTP error! status: ' + response.status);
                
                allReservations = await response.json();
                console.log('Loaded reservations:', allReservations.length);
                
                updateStats();
                displayReservations();
            } catch (error) {
                console.error('Error loading reservations:', error);
                showAlert('Error loading reservations: ' + error.message, 'error');
            }
        }

        function updateStats() {
            const total = allReservations.length;
            const pending = allReservations.filter(r => !r.status || r.status === 'PENDING').length;
            const confirmed = allReservations.filter(r => r.status === 'CONFIRMED').length;
            const cancelled = allReservations.filter(r => r.status === 'CANCELLED').length;
            
            document.getElementById('total-count').textContent = total;
            document.getElementById('pending-count').textContent = pending;
            document.getElementById('confirmed-count').textContent = confirmed;
            document.getElementById('cancelled-count').textContent = cancelled;
        }

        function displayReservations() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            let filtered = allReservations.filter(reservation => {
                const matchesFilter = currentFilter === 'all' || 
                    (reservation.status || 'PENDING').toLowerCase() === currentFilter;
                const matchesSearch = !searchTerm || 
                    reservation.guestName?.toLowerCase().includes(searchTerm) ||
                    reservation.guestEmail?.toLowerCase().includes(searchTerm) ||
                    reservation.reservationNumber?.toLowerCase().includes(searchTerm);
                return matchesFilter && matchesSearch;
            });

            const tbody = document.getElementById('reservations-tbody');
            tbody.innerHTML = '';

            if (filtered.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="loading">No reservations found.</td></tr>';
                return;
            }

            filtered.forEach(reservation => {
                const status = reservation.status || 'PENDING';
                const row = document.createElement('tr');
                row.innerHTML = 
                    '<td>' + reservation.id + '</td>' +
                    '<td>' + reservation.reservationNumber + '</td>' +
                    '<td>' + (reservation.guestName || 'N/A') + '</td>' +
                    '<td>' + (reservation.guestEmail || 'N/A') + '</td>' +
                    '<td>' + (reservation.hotelName || 'N/A') + '</td>' +
                    '<td>' + formatDate(reservation.checkInDate) + '</td>' +
                    '<td>' + formatDate(reservation.checkOutDate) + '</td>' +
                    '<td>$' + (reservation.totalAmount || '0.00') + '</td>' +
                    '<td><span class="status-badge status-' + status.toLowerCase() + '">' + status + '</span></td>' +
                    '<td>' + formatDate(reservation.createdAt) + '</td>' +
                    '<td>' +
                        '<button class="btn btn-success" onclick="confirmReservation(' + reservation.id + ')" ' + 
                        (status === 'CONFIRMED' ? 'disabled' : '') + '>Confirm</button>' +
                        '<button class="btn btn-danger" onclick="cancelReservation(' + reservation.id + ')" ' + 
                        (status === 'CANCELLED' ? 'disabled' : '') + '>Cancel</button>' +
                    '</td>';
                tbody.appendChild(row);
            });
        }

        async function confirmReservation(id) {
            if (confirm('Confirm this reservation?')) {
                try {
                    const response = await fetch('/api/reservations/admin/' + id + '/confirm', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' }
                    });
                    
                    if (response.ok) {
                        const updatedReservation = await response.json();
                        const index = allReservations.findIndex(r => r.id === id);
                        if (index !== -1) allReservations[index] = updatedReservation;
                        
                        showAlert('Reservation confirmed!', 'success');
                        updateStats();
                        displayReservations();
                    } else {
                        showAlert('Error confirming reservation', 'error');
                    }
                } catch (error) {
                    showAlert('Error: ' + error.message, 'error');
                }
            }
        }

        async function cancelReservation(id) {
            if (confirm('Cancel this reservation?')) {
                try {
                    const response = await fetch('/api/reservations/admin/' + id + '/cancel', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' }
                    });
                    
                    if (response.ok) {
                        const updatedReservation = await response.json();
                        const index = allReservations.findIndex(r => r.id === id);
                        if (index !== -1) allReservations[index] = updatedReservation;
                        
                        showAlert('Reservation cancelled!', 'success');
                        updateStats();
                        displayReservations();
                    } else {
                        showAlert('Error cancelling reservation', 'error');
                    }
                } catch (error) {
                    showAlert('Error: ' + error.message, 'error');
                }
            }
        }

        function formatDate(dateString) {
            if (!dateString) return 'N/A';
            const date = new Date(dateString);
            return date.toLocaleDateString();
        }

        function showAlert(message, type) {
            const container = document.getElementById('alert-container');
            container.innerHTML = '<div class="alert alert-' + type + '">' + message + '</div>';
            setTimeout(() => container.innerHTML = '', 3000);
        }

        // Event listeners
        document.getElementById('searchInput').addEventListener('input', displayReservations);
        
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                currentFilter = this.dataset.filter;
                displayReservations();
            });
        });

        // Load reservations when page loads
        loadReservations();
    </script>
</body>
</html>
</html>