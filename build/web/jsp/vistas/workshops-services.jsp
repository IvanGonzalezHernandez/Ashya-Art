<%-- 
    Document   : workshops-services
    Created on : 22 mar 2025, 12:24:05
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>Workshops & Services</title>
        <meta name="keywords" content="ceramics workshops Hamburg, pottery classes, Ashya Art workshops, learn ceramics, ceramic courses">
        <meta name="description" content="Join Ashya Art's ceramics workshops in Hamburg to learn pottery and ceramic art. Reserve your spot in our creative studio today.">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/workshops-services.css"/>
        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>
        <div class="container-fluid mt-4">

            <!-- Barra de navegación con pestañas -->
            <ul class="nav nav-tabs justify-content-center" id="myTabs">
                <li class="nav-item">
                    <a class="nav-link active" data-bs-toggle="tab" href="#cursos">Workshops</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#firing">Firing Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-bs-toggle="tab" href="#tarjetas">Gift Cards</a>
                </li>
            </ul>

            <!-- Contenido de las pestañas -->
            <div class="tab-content mt-4">
                <div class="tab-pane fade show active" id="cursos">
                    <%@ include file="../includes/workshops.jsp" %>
                    <%@ include file="../includes/valorations.jsp" %>
                </div>
                <div class="tab-pane fade" id="firing">
                    <%@ include file="../includes/firingServices.jsp" %>
                    <%@ include file="../includes/formContact.jsp" %>
                </div>
                <div class="tab-pane fade" id="tarjetas">
                    <%@ include file="../includes/giftCards.jsp" %>
                    <%@ include file="../includes/valorations.jsp" %>
                </div>

            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
