<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Event Test</title>
</head>
<body>
    <h1>Event Test Page</h1>
    
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    
    <c:if test="${not empty events}">
        <h2>Events (${events.size()}):</h2>
        <ul>
            <c:forEach var="event" items="${events}">
                <li>${event.eventName} - ${event.location}</li>
            </c:forEach>
        </ul>
    </c:if>
</body>
</html>