<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>Ashya's Studio</title>
        <meta name="keywords" content="Ashya Art studio, ceramic studio Hamburg, pottery studio, ceramic gallery, Ashya Art location">
        <meta name="description" content="Visit Ashya Art’s studio in Hamburg – a cozy space for ceramic art, workshops, gallery, and handmade pottery. Explore our creative world.">

        <script src="${pageContext.request.contextPath}/resources/js/swiper.js"></script>
        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/studio.css">
        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>

        <!-- Sección Estudio Unificada -->
        <section class="hero-section">
            <div class="grid-container container">
                <!-- Imagen arriba izquierda -->
                <div class="grid-item bg-image-1 animate__animated animate__fadeInLeft"></div>

                <!-- Texto arriba derecha -->
                <div class="grid-item text-background animate__animated animate__fadeInDown">
                    <h2 class="display-5">Welcome to Ashya’s Studio</h2>
                    <p class="lead">
                        Your favourite place for all things ceramics, located in Hamburg. We offer a fun and welcoming atmosphere for everyone — from complete beginners to experienced artists.
                    </p>
                    <p class="lead">
                        Join our creative community and explore techniques like wheel throwing, hand building, and glazing. Our instructors are here to guide and inspire you at every step.
                    </p>
                </div>

                <!-- Texto abajo izquierda -->
                <div class="grid-item text-background animate__animated animate__fadeInUp">
                    <h2 class="display-5">Creative Workshops</h2>
                    <p class="lead">
                        Take part in our interactive workshops or use the studio independently outside course times. We love seeing people create freely in a supportive space.
                    </p>
                </div>

                <!-- Imagen abajo derecha -->
                <div class="grid-item bg-image-2 animate__animated animate__fadeInRight"></div>
            </div>
        </section>


        <%@ include file="../includes/carrousel-workshops.jsp" %>

        <!-- Sección Mapa de Ubicación -->
        <section class="map-section py-5" style="background-color: #EFE5DB; color: #3E3028;">
            <div class="container text-center">
                <h2 class="mb-4">Where to Find Us</h2>
                <p class="lead mb-4">Come visit our cozy studio in Hamburg.</p>
                <div class="map-responsive">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d18926.359878021456!2d9.823812939040971!3d53.632795729079476!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x47b1878164cf82a3%3A0x279976709176fcbf!2sAshya%20Art%20%26%20Keramik%20Studio!5e0!3m2!1ses!2ses!4v1747566669060!5m2!1ses!2ses" 
                        allowfullscreen="" 
                        loading="lazy" 
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>

        </section>



        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
