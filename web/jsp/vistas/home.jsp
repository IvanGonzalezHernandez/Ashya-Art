<%-- 
    Document   : home
    Created on : 22 mar 2025, 12:45:16
    Author     : ivang
--%>

<%@page import="com.ashyaart.ecommerce.modelo.Cursos"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Obtener la lista de cursos del atributo de la aplicación
    List<Cursos> cursos = (List<Cursos>) application.getAttribute("listaCursos");
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
        <script src="${pageContext.request.contextPath}/resources/js/swiper.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>


        <!-- Hero 1 -->
        <section class="hero-section vh-100 position-relative text-white text-center">
            <!-- Overlay más claro -->
            <div class="position-absolute top-0 start-0 w-100 h-100" style="background-color: rgba(0, 0, 0, 0.5);"></div>

            <!-- Contenido -->
            <div class="position-relative d-flex flex-column justify-content-center align-items-center h-100 animate__animated animate__fadeInUp">
                <h1 class="display-4">Welcome to Ashya Art</h1>
                <p class="lead">
                    Handmade ceramics and creative workshops inspired by tradition and passion.
                </p>
            </div>
        </section>




        <!-- Hero 2 - Carrusel dinámico de cursos con Swiper -->
        <section class="carrousel-section vh-100 d-flex flex-column align-items-center justify-content-center text-center">
            <!-- Título -->
            <h3 class="mb-4">DISCOVER OUR CERAMIC WORKSHOPS</h3>

            <!-- Swiper container -->
            <div class="swiper swiper-cursos w-100" style="max-width: 1200px;">
                <div class="swiper-wrapper">
                    <%
                        if (cursos != null && !cursos.isEmpty()) {
                            for (int i = 0; i < cursos.size(); i++) {
                                Cursos curso = cursos.get(i);
                    %>
                    <div class="swiper-slide" style="width: 320px;">
                        <div class="position-relative">
                            <!-- Enlace al detalle del curso -->
                            <a href="jsp/vistas/workshops-details.jsp?curso=<%= curso.getNombre().replace(" ", "%20")%>">
                                <img src="<%= curso.getImg()%>" alt="<%= curso.getNombre()%>" 
                                     style="height: 400px; width: 100%; object-fit: cover; border-radius: 12px;">
                            </a>
                            <div class="position-absolute bottom-0 start-0 w-100 text-center text-white p-2 bg-dark bg-opacity-50">
                                <h5 class="mb-0"><%= curso.getNombre()%></h5>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <div class="swiper-slide" style="width: 320px;">
                        <p class="text-white">No courses available at the moment.</p>
                    </div>
                    <% }%>
                </div>

                <!-- Swiper navigation -->
                <div class="swiper-button-prev text-white"></div>
                <div class="swiper-button-next text-white"></div>

            </div>
        </section>

        <!-- Hero 3 con fondo e info -->
        <section class="vh-100 position-relative text-white text-center d-flex align-items-center justify-content-center" style="background-image: url('./resources/imagenes/home/about.png'); background-size: cover; background-position: center;">
            <!-- Overlay oscuro -->
            <div class="position-absolute top-0 start-0 w-100 h-100" style="background-color: rgba(0, 0, 0, 0.5); z-index: 1;"></div>

            <!-- Contenido -->
            <div class="position-relative z-2">
                <h1 class="display-4 mb-3">HI I'M ASHYA!</h1>
                <p class="lead mb-4">You can learn more about me</p>
                <a href="#sobre-mi" class="btn btn-light btn-lg rounded-pill px-4">HERE</a>
            </div>
        </section>


        <!-- Hero 4 -->
        <section class="giftCard-section vh-100 text-white d-flex align-items-center justify-content-center text-center">
            <div class="container">
                <div class="row align-items-center">
                    <!-- Imagen de la tarjeta regalo -->
                    <div class="col-md-6 mb-4 mb-md-0 text-center">
                        <img src="./resources/imagenes/home/plantillaTarjetaRegalo.png" alt="Tarjeta Regalo" class="img-fluid rounded shadow">
                    </div>

                    <!-- Información de la tarjeta -->
                    <div class="col-md-6 text-md-start">
                        <h3 class="mb-3">Tarjeta Regalo Ashya</h3>
                        <p class="lead mb-3">Regala creatividad y arte a quien tú quieras.</p>
                        <p class="h4 mb-4">Precio: 50€</p>
                        <a href="#" class="btn btn-light btn-lg">Comprar ahora</a>
                    </div>
                </div>
            </div>
        </section>







        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
