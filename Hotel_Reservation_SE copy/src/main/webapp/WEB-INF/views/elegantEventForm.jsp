<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - GrandStay</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.5)), 
                        url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            color: white;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        
        .header p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #ffd700;
            font-size: 1rem;
        }
        
        .required {
            color: #e74c3c;
        }
        
        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #ffd700;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
            background: rgba(255, 255, 255, 0.15);
        }
        
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 40px;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            min-width: 120px;
            text-align: center;
        }
        
        .btn-primary {
            background: linear-gradient(45deg, #ffd700, #ffed4e);
            color: #000;
        }
        
        .btn-primary:hover {
            background: linear-gradient(45deg, #ffed4e, #ffd700);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(255, 215, 0, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
        }
        
        .back-link {
            color: #ffd700;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        
        .back-link:hover {
            color: #ffed4e;
        }
        
        .help-text {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.6);
            margin-top: 5px;
        }
        
        .error-message {
            background: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(231, 76, 60, 0.3);
        }
        
        .success-message {
            background: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid rgba(46, 204, 113, 0.3);
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .form-container {
                padding: 20px;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/admin/events" class="back-link">
            ← Back to Events
        </a>

        <div class="header">
            <h1>Create New Event</h1>
            <p>Fill in the event details below</p>
        </div>

        <div class="form-container">
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    ${errorMessage}
                </div>
            </c:if>

            <form method="post" action="/admin/events">
                <div class="form-group">
                    <label for="eventName">Event Name <span class="required">*</span></label>
                    <input type="text" 
                           id="eventName" 
                           name="eventName" 
                           class="form-control" 
                           placeholder="Enter event name"
                           maxlength="100"
                           required>
                    <div class="help-text">Maximum 100 characters</div>
                </div>

                <div class="form-group">
                    <label for="hotelId">Hotel <span class="required">*</span></label>
                    <select id="hotelId" 
                            name="hotelId" 
                            class="form-control" 
                            required>
                        <option value="">Select a hotel</option>
                        <c:forEach var="hotel" items="${hotels}">
                            <option value="${hotel.id}">
                                ${hotel.name} - ${hotel.location}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="help-text">Choose the hotel where this event will take place</div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="eventDate">Event Date & Time <span class="required">*</span></label>
                        <input type="datetime-local" 
                               id="eventDate" 
                               name="eventDate" 
                               class="form-control" 
                               required>
                        <div class="help-text">Event must be scheduled in the future</div>
                    </div>

                    <div class="form-group">
                        <label for="location">Location <span class="required">*</span></label>
                        <input type="text" 
                               id="location" 
                               name="location" 
                               class="form-control" 
                               placeholder="Enter event location"
                               maxlength="200"
                               required>
                        <div class="help-text">Maximum 200 characters</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" 
                              name="description" 
                              class="form-control" 
                              placeholder="Enter event description (optional)"
                              maxlength="1000"></textarea>
                    <div class="help-text">Optional. Maximum 1000 characters</div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        Create Event
                    </button>
                    <a href="/admin/events" class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Set minimum date to current date/time
        const now = new Date();
        const minDateTime = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 16);
        document.getElementById('eventDate').min = minDateTime;
    </script>
</body>
</html>
