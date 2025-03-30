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
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/workshops-services.css"/>
        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <div class="container mt-4">

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
                </div>
                <div class="tab-pane fade" id="productos">

                </div>
                <div class="tab-pane fade" id="tarjetas">

                </div>

            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
