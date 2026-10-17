<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit Event' : 'Create Event'} - GrandStay Admin</title>
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
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .header p {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
        }

        .required {
            color: #e74c3c;
        }

        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid #ecf0f1;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fff;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .form-control.error {
            border-color: #e74c3c;
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.1);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .error-message {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: none;
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
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            text-align: center;
            min-width: 120px;
        }

        .btn-primary {
            background: linear-gradient(45deg, #3498db, #2980b9);
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(45deg, #2980b9, #1f618d);
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: linear-gradient(45deg, #95a5a6, #7f8c8d);
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(45deg, #7f8c8d, #6c7b7d);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        .back-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }

        .back-link:hover {
            color: #2980b9;
        }

        .help-text {
            font-size: 12px;
            color: #7f8c8d;
            margin-top: 5px;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 500;
        }

        .alert-error {
            background: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
            border: 1px solid rgba(231, 76, 60, 0.3);
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

        <div class="form-container">
            <div class="header">
                <h1>${isEdit ? 'Edit Event' : 'Create New Event'}</h1>
                <p>${isEdit ? 'Update event details below' : 'Fill in the event details below'}</p>
            </div>

            <!-- Error Messages -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    ${errorMessage}
                </div>
            </c:if>

            <form id="eventForm" method="post" action="${isEdit ? '/admin/events/update/' : '/admin/events'}${isEdit ? event.eventId : ''}">
                <div class="form-group">
                    <label for="eventName">Event Name <span class="required">*</span></label>
                    <input type="text" 
                           id="eventName" 
                           name="eventName" 
                           class="form-control" 
                           value="${event.eventName}"
                           placeholder="Enter event name"
                           maxlength="100"
                           required>
                    <div class="error-message" id="eventName-error"></div>
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
                            <option value="${hotel.id}" 
                                    ${event.hotel != null && event.hotel.id == hotel.id ? 'selected' : ''}>
                                ${hotel.name} - ${hotel.location}
                            </option>
                        </c:forEach>
                    </select>
                    <div class="error-message" id="hotelId-error"></div>
                    <div class="help-text">Choose the hotel where this event will take place</div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="eventDate">Event Date & Time <span class="required">*</span></label>
                        <input type="datetime-local" 
                               id="eventDate" 
                               name="eventDate" 
                               class="form-control" 
                               value="${event.eventDate}"
                               required>
                        <div class="error-message" id="eventDate-error"></div>
                        <div class="help-text">${isEdit ? 'Enter the event date and time' : 'Event must be scheduled in the future'}</div>
                    </div>

                    <div class="form-group">
                        <label for="location">Location <span class="required">*</span></label>
                        <input type="text" 
                               id="location" 
                               name="location" 
                               class="form-control" 
                               value="${event.location}"
                               placeholder="Enter event location"
                               maxlength="200"
                               required>
                        <div class="error-message" id="location-error"></div>
                        <div class="help-text">Maximum 200 characters</div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" 
                              name="description" 
                              class="form-control" 
                              placeholder="Enter event description (optional)"
                              maxlength="1000">${event.description}</textarea>
                    <div class="error-message" id="description-error"></div>
                    <div class="help-text">Optional. Maximum 1000 characters</div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        ${isEdit ? 'Update Event' : 'Create Event'}
                    </button>
                    <a href="/admin/events" class="btn btn-secondary">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('eventForm');
            const submitBtn = document.getElementById('submitBtn');
            
            // Set minimum date to current date/time only for new events
            const isEdit = ${isEdit ? 'true' : 'false'};
            if (!isEdit) {
                const now = new Date();
                const minDateTime = new Date(now.getTime() - now.getTimezoneOffset() * 60000).toISOString().slice(0, 16);
                document.getElementById('eventDate').min = minDateTime;
            }
            
            // Form validation
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                if (validateForm()) {
                    submitBtn.disabled = true;
                    submitBtn.textContent = '${isEdit ? 'Updating...' : 'Creating...'}';
                    form.submit();
                }
            });
            
            // Real-time validation
            document.getElementById('eventName').addEventListener('blur', validateEventName);
            document.getElementById('hotelId').addEventListener('change', validateHotel);
            document.getElementById('eventDate').addEventListener('change', validateEventDate);
            document.getElementById('location').addEventListener('blur', validateLocation);
            document.getElementById('description').addEventListener('input', validateDescription);
        });
        
        function validateForm() {
            let isValid = true;
            
            isValid = validateEventName() && isValid;
            isValid = validateHotel() && isValid;
            isValid = validateEventDate() && isValid;
            isValid = validateLocation() && isValid;
            isValid = validateDescription() && isValid;
            
            return isValid;
        }
        
        function validateEventName() {
            const field = document.getElementById('eventName');
            const value = field.value.trim();
            const error = document.getElementById('eventName-error');
            
            if (!value) {
                showError(field, error, 'Event name is required');
                return false;
            } else if (value.length > 100) {
                showError(field, error, 'Event name must not exceed 100 characters');
                return false;
            } else {
                hideError(field, error);
                return true;
            }
        }
        
        function validateHotel() {
            const field = document.getElementById('hotelId');
            const value = field.value;
            const error = document.getElementById('hotelId-error');
            
            if (!value) {
                showError(field, error, 'Please select a hotel');
                return false;
            } else {
                hideError(field, error);
                return true;
            }
        }
        
        function validateEventDate() {
            const field = document.getElementById('eventDate');
            const value = field.value;
            const error = document.getElementById('eventDate-error');
            const isEdit = ${isEdit ? 'true' : 'false'};
            
            if (!value) {
                showError(field, error, 'Event date is required');
                return false;
            } else {
                // Only validate future date for new events, not when editing
                if (!isEdit) {
                    const eventDate = new Date(value);
                    const now = new Date();
                    
                    if (eventDate <= now) {
                        showError(field, error, 'Event date must be in the future');
                        return false;
                    }
                }
                hideError(field, error);
                return true;
            }
        }
        
        function validateLocation() {
            const field = document.getElementById('location');
            const value = field.value.trim();
            const error = document.getElementById('location-error');
            
            if (!value) {
                showError(field, error, 'Location is required');
                return false;
            } else if (value.length > 200) {
                showError(field, error, 'Location must not exceed 200 characters');
                return false;
            } else {
                hideError(field, error);
                return true;
            }
        }
        
        function validateDescription() {
            const field = document.getElementById('description');
            const value = field.value;
            const error = document.getElementById('description-error');
            
            if (value.length > 1000) {
                showError(field, error, 'Description must not exceed 1000 characters');
                return false;
            } else {
                hideError(field, error);
                return true;
            }
        }
        
        function showError(field, errorElement, message) {
            field.classList.add('error');
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        
        function hideError(field, errorElement) {
            field.classList.remove('error');
            errorElement.style.display = 'none';
        }
    </script>
</body>
</html>
