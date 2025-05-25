<%-- 
    Document   : cancel
    Created on : 1 abr 2025, 16:35:24
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>Thank You!</title>
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
            <h1 class="text-custom fw-bold">Thank you for your purchase!</h1>
            <p class="text-secondary fs-5">You will be receiving a confirmation e-mail shortly.</p>
            <a href="home.jsp" class="back-link">Back to Home</a>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
