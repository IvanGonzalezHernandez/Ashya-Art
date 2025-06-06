<%-- 
    Document   : shop
    Created on : 22 mar 2025, 12:24:12
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>Ceramic Shop</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/shop.css"/>
        <%@ include file="../includes/cdn.jsp" %>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>

        
        <%@ include file="../includes/products.jsp" %>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
