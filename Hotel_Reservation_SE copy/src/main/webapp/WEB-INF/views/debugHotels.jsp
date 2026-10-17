<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Debug Hotels</title>
</head>
<body>
    <h1>Debug Hotels</h1>
    <c:if test="${not empty message}">
        <p style="color: green;">${message}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>
    <p>Hotel Count: ${hotelCount}</p>
    <c:if test="${not empty hotels}">
        <h2>Hotels:</h2>
        <ul>
            <c:forEach var="hotel" items="${hotels}">
                <li>
                    <strong>${hotel.name}</strong> - ${hotel.location}
                    <br>Active: ${hotel.isActive}
                </li>
            </c:forEach>
        </ul>
    </c:if>
</body>
</html>
