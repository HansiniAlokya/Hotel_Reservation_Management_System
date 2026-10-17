<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Simple Events Test</title>
</head>
<body>
    <h1>Simple Events Test</h1>
    <p>If you see this, JSP is working!</p>
    <c:if test="${not empty events}">
        <p>Events count: ${events.size()}</p>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <p style="color: red;">Error: ${errorMessage}</p>
    </c:if>
</body>
</html>
