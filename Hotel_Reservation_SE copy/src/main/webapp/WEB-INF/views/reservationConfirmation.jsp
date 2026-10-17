<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Confirmation - GrandStay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
        }

        .header {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            padding: 40px 30px;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        .content {
            padding: 40px;
        }

        .success-icon {
            font-size: 4em;
            color: #27ae60;
            margin-bottom: 20px;
        }

        .reservation-details {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            margin: 30px 0;
            text-align: left;
        }

        .reservation-details h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
        }

        .detail-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.1em;
            color: #27ae60;
        }

        .detail-label {
            font-weight: 600;
            color: #2c3e50;
        }

        .detail-value {
            color: #34495e;
        }

        .btn {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 10px;
        }

        .btn:hover {
            background: linear-gradient(135deg, #2980b9, #1f618d);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60, #229954);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #229954, #1e8449);
        }

        .back-btn {
            position: absolute;
            top: 20px;
            left: 20px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .container {
                margin: 20px;
            }
            
            .content {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 2em;
            }
        }
    </style>
</head>
<body>
    <a href="/dashboard" class="back-btn">← Back to Dashboard</a>
    
    <div class="container">
        <div class="header">
            <h1>Reservation Confirmed!</h1>
            <p>Your stay at GrandStay has been booked successfully</p>
        </div>
        
        <div class="content">
            <div class="success-icon">✅</div>
            
            <div class="reservation-details">
                <h3>Reservation Details</h3>
                <div class="detail-row">
                    <span class="detail-label">Reservation Number:</span>
                    <span class="detail-value" id="reservationNumber">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Hotel:</span>
                    <span class="detail-value" id="hotelName">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Room:</span>
                    <span class="detail-value" id="roomDetails">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Check-in:</span>
                    <span class="detail-value" id="checkInDate">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Check-out:</span>
                    <span class="detail-value" id="checkOutDate">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Guests:</span>
                    <span class="detail-value" id="numberOfGuests">Loading...</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Total Amount:</span>
                    <span class="detail-value" id="totalAmount">Loading...</span>
                </div>
            </div>
            
            <div style="margin-top: 30px;">
                <a href="/dashboard" class="btn btn-success">View My Reservations</a>
                <a href="/api/reservations/make-reservation" class="btn">Make Another Reservation</a>
            </div>
        </div>
    </div>

    <script>
        // Get reservation details from URL parameters or session
        document.addEventListener('DOMContentLoaded', function() {
            // Try to get reservation details from URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const reservationNumber = urlParams.get('reservationNumber');
            
            if (reservationNumber) {
                loadReservationDetails(reservationNumber);
            } else {
                // If no reservation number in URL, show a generic message
                document.getElementById('reservationNumber').textContent = 'N/A';
                document.getElementById('hotelName').textContent = 'Reservation completed';
                document.getElementById('roomDetails').textContent = 'Please check your reservations';
                document.getElementById('checkInDate').textContent = 'N/A';
                document.getElementById('checkOutDate').textContent = 'N/A';
                document.getElementById('numberOfGuests').textContent = 'N/A';
                document.getElementById('totalAmount').textContent = 'N/A';
            }
        });

        async function loadReservationDetails(reservationNumber) {
            try {
                const response = await fetch(`/api/reservations/by-number/${reservationNumber}`);
                if (response.ok) {
                    const reservation = await response.json();
                    populateReservationDetails(reservation);
                } else {
                    showGenericMessage();
                }
            } catch (error) {
                console.error('Error loading reservation details:', error);
                showGenericMessage();
            }
        }

        function populateReservationDetails(reservation) {
            document.getElementById('reservationNumber').textContent = reservation.reservationNumber;
            document.getElementById('hotelName').textContent = reservation.hotelName;
            document.getElementById('roomDetails').textContent = `${reservation.roomType}`;
            document.getElementById('checkInDate').textContent = new Date(reservation.checkInDate).toLocaleDateString();
            document.getElementById('checkOutDate').textContent = new Date(reservation.checkOutDate).toLocaleDateString();
            document.getElementById('numberOfGuests').textContent = reservation.numberOfGuests;
            document.getElementById('totalAmount').textContent = `$${reservation.totalAmount}`;
        }

        function showGenericMessage() {
            document.getElementById('reservationNumber').textContent = 'Reservation completed';
            document.getElementById('hotelName').textContent = 'Please check your reservations for details';
            document.getElementById('roomDetails').textContent = 'N/A';
            document.getElementById('checkInDate').textContent = 'N/A';
            document.getElementById('checkOutDate').textContent = 'N/A';
            document.getElementById('numberOfGuests').textContent = 'N/A';
            document.getElementById('totalAmount').textContent = 'N/A';
        }
    </script>
</body>
</html>
