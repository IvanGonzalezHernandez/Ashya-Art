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

        <title>Home</title>
        <!-- for SEO -->
        <meta name="keywords" content="ceramic art in Hamburg, ceramics workshops, Ashya Art, handcrafted pottery, pottery classes, ceramic studio Hamburg">
        <meta name="description" content="Ashya Art offers unique ceramic workshops in Hamburg and handcrafted pottery made with care. Book your spot online.">
        
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





        <!-- Hero 4 -->
        <section class="giftCard-section py-5 text-center">
            <div class="container">
                <!-- Centered title above -->
                <div class="row mb-5">
                    <div class="col-12">
                        <h3>PERSONALIZED GIFT CARDS</h3>
                    </div>
                </div>

                <!-- Content with image and info -->
                <div class="row align-items-center justify-content-center">
                    <!-- Image -->
                    <div class="col-lg-4 mb-4 mb-lg-0 text-center">
                        <img src="${pageContext.request.contextPath}/resources/imagenes/home/plantillaTarjetaRegalo.png" alt="Gift Card" class="img-fluid rounded shadow hover-zoom">
                    </div>

                    <!-- Info and CTA -->
                    <div class="col-lg-6">
                        <div class="bg-white text-start p-4 rounded shadow">
                            <h4>A Unique Gift</h4>
                            <p class="mb-3">
                                Perfect for birthdays, anniversaries, or just to surprise someone. Our gift cards can be used to book a workshop or buy unique handmade ceramic pieces.
                            </p>
                            <ul class="list-unstyled mb-4">
                                <li>✔ Personalized with your name</li>
                                <li>✔ Valid for 6 months</li>
                                <li>✔ Instant digital delivery</li>
                            </ul>
                            <a href="${pageContext.request.contextPath}/NavigationServlet?page=workshops" class="btn-custom text-decoration-none">View Gift Cards</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>






        <%@ include file="../includes/galery.jsp" %>


        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
