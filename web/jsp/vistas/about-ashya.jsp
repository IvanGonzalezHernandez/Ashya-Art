<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title>About Ashya</title>
        <meta name="keywords" content="Ashya Art, ceramic studio Hamburg, handcrafted pottery, ceramic artists, about Ashya Art">
        <meta name="description" content="Discover the story behind Ashya Art, a ceramic studio in Hamburg dedicated to handcrafted pottery and creative workshops.">
        <link rel="stylesheet" href="./resources/css/about.css">
        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>

        <!-- Sección About Ashya -->
        <section class="about-section py-5">
            <div class="container d-flex flex-column flex-md-row align-items-center">
                <!-- Imagen izquierda -->
                <div class="about-img animate__animated animate__fadeInLeft mb-4 mb-md-0 me-md-5">
                    <img src="${pageContext.request.contextPath}/resources/imagenes/about/aboutAshya.jpg" alt="Ashya Studio" class="img-fluid rounded shadow">
                </div>

                <!-- Texto derecha -->
                <div class="about-text animate__animated animate__fadeInRight text-md-start text-center">
                    <h2 class="display-5 mb-3">Meet Ashya</h2>
                    <p class="lead">
                        My name is Ashya, and I am thrilled that you found your way here. I am a ceramics artist from Wroclaw, now living in the beautiful city of Hamburg.
                        Ceramics have changed my life, and I am passionate about sharing this joy with others.
                    </p>
                    <p class="lead">
                        Whether you are a complete beginner or an experienced ceramics enthusiast, my classes are tailored to meet your individual needs.
                        On this page you can get to know more about me and my studio, purchase my ceramics or book a course with me.
                    </p>

                </div>
            </div>
        </section>

        <%@ include file="../includes/galery.jsp" %>

        <%@ include file="../includes/formContact.jsp" %>


        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>
        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
