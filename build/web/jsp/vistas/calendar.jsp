<%-- 
    Document   : calendar
    Created on : 30 mar 2025, 12:04:26
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>Workshops Calendar</title>
        <%@ include file="../includes/cdn.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css"/>
        <script src="${pageContext.request.contextPath}/resources/js/calendar.js" defer></script>
        <script src="${pageContext.request.contextPath}/resources/js/cart.js" defer></script>

    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/calendar.jsp" %>
        
        <%@ include file="../includes/formContact.jsp" %>

        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>

</html>
