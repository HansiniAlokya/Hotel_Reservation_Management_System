<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Events</title>
</head>
<body>
    <h1>Debug Events</h1>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    <p>Event Count: ${eventCount}</p>
    <c:if test="${not empty events}">
        <h2>Events:</h2>
        <ul>
            <c:forEach var="event" items="${events}">
                <li>
                    <strong>${event.eventName}</strong> - ${event.location}
                    <br>Date: ${event.eventDate}
                    <br>Active: ${event.isActive}
                </li>
            </c:forEach>
        </ul>
    </c:if>
</body>
</html>
