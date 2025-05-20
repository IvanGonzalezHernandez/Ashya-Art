<%-- 
    Document   : home
    Created on : 22 mar 2025, 12:45:16
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
        <script src="${pageContext.request.contextPath}/resources/js/swiper.js"></script>
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



        <%@ include file="../includes/carrousel-workshops.jsp" %>


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




        <%@ include file="../includes/galery.jsp" %>


        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
