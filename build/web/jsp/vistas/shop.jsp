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
        <title>Thank You</title>
        <%@ include file="../includes/cdn.jsp" %>
        <style>
            .text-custom {
                color: #3A9097 !important;
            }
            .success-container {
                background-color: #F9F3EC;
                min-height: 100vh;
            }
            .back-link {
                color: #000;
                text-decoration: none;
                font-weight: 600;
                font-size: 1rem;
            }
            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/formClient.jsp" %>

        <div class="success-container d-flex flex-column justify-content-center align-items-center text-center w-100">
            <h1 class="text-custom fw-bold">Our online store is under construction.</h1>
            <p class="text-secondary fs-5">Meanwhile, visit our Etsy shop:</p>
            <a href="https://www.etsy.com/shop/ashyaart" class="back-link" target="_blank">Go to Etsy</a>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
