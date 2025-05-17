<%-- 
    Document   : studio-membership
    Created on : 22 mar 2025, 12:24:40
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%@ include file="../includes/cdn.jsp" %>
    <body>
        <%@ include file="../includes/header.jsp" %>

        <!-- Hero 1 -->
        <section class="vh-100 bg-dark text-white d-flex align-items-center justify-content-center text-center">
            <div>
                <h1 class="display-4">Bienvenido a mi web</h1>
                <p class="lead">Esta es la primera sección tipo hero</p>
            </div>
        </section>

        <!-- Hero 2 -->
        <section class="vh-100 bg-secondary text-white d-flex align-items-center justify-content-center text-center">
            <div>
                <h1 class="display-4">Sobre mí</h1>
                <p class="lead">Una breve descripción sobre quién soy y qué hago</p>
            </div>
        </section>

        <!-- Hero 3 -->
        <section class="vh-100 bg-primary text-white d-flex align-items-center justify-content-center text-center">
            <div>
                <h1 class="display-4">Servicios</h1>
                <p class="lead">Descubre lo que ofrezco</p>
            </div>
        </section>

        <!-- Hero 4 -->
        <section class="vh-100 bg-info text-white d-flex align-items-center justify-content-center text-center">
            <div>
                <h1 class="display-4">Contacto</h1>
                <p class="lead">Ponte en contacto conmigo fácilmente</p>
            </div>
        </section>


        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
