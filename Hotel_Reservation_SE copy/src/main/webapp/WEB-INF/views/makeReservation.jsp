<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Make Reservation - GrandStay</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .reservation-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 10px;
            color: white !important;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.8;
            color: #F4E5C3;
        }

        .user-info {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
            text-align: center;
        }

        .user-info p {
            font-size: 1rem;
            color: #E8E8E8;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #F4E5C3;
            font-size: 1rem;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #D4AF37;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 10px rgba(212, 175, 55, 0.3);
        }

        .form-group select option {
            background: #2C2C2C;
            color: white;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(45deg, #D4AF37, #F4E5C3);
            color: #2C2C2C;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: transparent;
            color: #F4E5C3;
            border: 1px solid rgba(244, 229, 195, 0.3);
            border-radius: 25px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }

        .back-btn:hover {
            background: rgba(244, 229, 195, 0.1);
            border-color: #D4AF37;
        }

        @media (max-width: 768px) {
            .reservation-container {
                padding: 30px 20px;
                margin: 10px;
            }
            
            .header h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="reservation-container">
        <div class="header">
            <h1>Make Reservation</h1>
            <p>Experience luxury at its finest</p>
        </div>
        
        <div class="user-info">
            <p><strong>User ID:</strong> ${user != null ? user.id : 'Not logged in'}</p>
        </div>
    
        <form id="reservationForm">
            <div class="form-group">
                <label for="hotelSelect">Select Hotel</label>
                <select id="hotelSelect" name="hotelId" required>
                    <option value="">Select a hotel...</option>
                    <!-- Hotels loaded from database -->
                    <c:forEach var="hotel" items="${hotels}">
                        <option value="${hotel.id}">${hotel.name} - ${hotel.location}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="roomSelect">Number of Rooms</label>
                <select id="roomSelect" name="numberOfRooms" required>
                    <option value="">Select number of rooms...</option>
                    <option value="1">1 Room</option>
                    <option value="2">2 Rooms</option>
                    <option value="3">3 Rooms</option>
                    <option value="4">4 Rooms</option>
                    <option value="5">5 Rooms</option>
                </select>
                <div class="room-info" style="color: #D4AF37; font-size: 0.9rem; margin-top: 5px; font-style: italic;">
                    Select the number of rooms you need for your stay.
                </div>
            </div>
            
            <div class="form-group">
                <label for="checkIn">Check-in Date</label>
                <input type="date" id="checkIn" name="checkInDate" required>
            </div>
            
            <div class="form-group">
                <label for="checkOut">Check-out Date</label>
                <input type="date" id="checkOut" name="checkOutDate" required>
            </div>
            
            <div class="form-group">
                <label for="guests">Number of Guests</label>
                <input type="number" id="guests" name="numberOfGuests" min="1" max="10" required>
            </div>
            
            <div class="form-group">
                <label for="specialRequests">Special Requests</label>
                <textarea id="specialRequests" name="specialRequests" rows="3" placeholder="Any special requests or preferences..."></textarea>
            </div>
            
            <button type="submit" class="submit-btn">Make Reservation</button>
        </form>
        
        <div style="text-align: center;">
            <a href="/dashboard" class="back-btn">← Back to Dashboard</a>
        </div>
    </div>
    
    <script>
        // Form handling and room loading
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Page loaded - hotels populated server-side');
            
            const hotelSelect = document.getElementById('hotelSelect');
            const roomSelect = document.getElementById('roomSelect');
            const reservationForm = document.getElementById('reservationForm');
            
            // Load rooms when hotel is selected
            hotelSelect.addEventListener('change', function() {
                const hotelId = this.value;
                if (hotelId) {
                    // Enable the room selection dropdown
                    roomSelect.disabled = false;
                    roomSelect.innerHTML = '<option value="">Select number of rooms...</option>' +
                        '<option value="1">1 Room</option>' +
                        '<option value="2">2 Rooms</option>' +
                        '<option value="3">3 Rooms</option>' +
                        '<option value="4">4 Rooms</option>' +
                        '<option value="5">5 Rooms</option>';
                } else {
                    roomSelect.innerHTML = '<option value="">Please select a hotel first...</option>';
                    roomSelect.disabled = true;
                }
            });
            
            // Handle form submission
            reservationForm.addEventListener('submit', async function(e) {
                e.preventDefault();
                
                const formData = new FormData(this);
                const numberOfRooms = formData.get('numberOfRooms');
                const reservationData = {
                    hotelId: parseInt(formData.get('hotelId')) || null,
                    numberOfRooms: numberOfRooms && numberOfRooms !== "" ? parseInt(numberOfRooms) : null,
                    checkInDate: formData.get('checkInDate'),
                    checkOutDate: formData.get('checkOutDate'),
                    numberOfGuests: parseInt(formData.get('numberOfGuests')),
                    specialRequests: formData.get('specialRequests')
                };
                
                console.log('Submitting reservation:', reservationData);
                
                try {
                    const response = await fetch('/api/reservations/create', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(reservationData)
                    });
                    
                    let result;
                    try {
                        result = await response.json();
                    } catch (jsonError) {
                        // If response is not JSON, get the text
                        const errorText = await response.text();
                        throw new Error(`Server error: ${errorText}`);
                    }
                    
                    if (response.ok) {
                        alert('Reservation created successfully! Reservation Number: ' + result.reservationNumber);
                        // Redirect to confirmation page or dashboard
                        window.location.href = '/dashboard';
                    } else {
                        alert('Error creating reservation: ' + (result.message || result.error || 'Unknown error'));
                    }
                } catch (error) {
                    console.error('Error:', error);
                    alert('Error creating reservation: ' + error.message);
                }
            });
        });
    </script>
</body>
</html>