<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Event - Simple</title>
</head>
<body>
    <h1>Create New Event</h1>
    
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">Error: ${errorMessage}</p>
    </c:if>
    
    <c:if test="${not empty hotels}">
        <p>Hotels loaded: ${hotels.size()}</p>
        <ul>
            <c:forEach var="hotel" items="${hotels}">
                <li>${hotel.name} - ${hotel.location}</li>
            </c:forEach>
        </ul>
    </c:if>
    
    <form method="post" action="/admin/events">
        <p>
            <label for="eventName">Event Name:</label>
            <input type="text" id="eventName" name="eventName" required>
        </p>
        
        <p>
            <label for="hotelId">Hotel:</label>
            <select id="hotelId" name="hotelId" required>
                <option value="">Select a hotel</option>
                <c:forEach var="hotel" items="${hotels}">
                    <option value="${hotel.id}">${hotel.name} - ${hotel.location}</option>
                </c:forEach>
            </select>
        </p>
        
        <p>
            <label for="eventDate">Event Date:</label>
            <input type="datetime-local" id="eventDate" name="eventDate" required>
        </p>
        
        <p>
            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required>
        </p>
        
        <p>
            <label for="description">Description:</label>
            <textarea id="description" name="description"></textarea>
        </p>
        
        <p>
            <button type="submit">Create Event</button>
            <a href="/admin/events">Cancel</a>
        </p>
    </form>
</body>
</html>
