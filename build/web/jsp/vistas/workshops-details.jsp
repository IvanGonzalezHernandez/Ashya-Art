<%@page import="com.ashyaart.ecommerce.modelo.Cursos"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<%
    String nombreCurso = request.getParameter("curso");
    Cursos cursoSeleccionado = null;
    List<Cursos> cursos = (List<Cursos>) application.getAttribute("listaCursos");

    if (cursos != null && nombreCurso != null) {
        for (Cursos curso : cursos) {
            if (curso.getNombre().equalsIgnoreCase(nombreCurso)) {
                cursoSeleccionado = curso;
                break;
            }
        }
    }

    request.setAttribute("titulo", cursoSeleccionado != null ? cursoSeleccionado.getNombre() : "Curso no encontrado");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title><%= request.getAttribute("titulo")%></title>

        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

        <!-- CSS personalizados -->
        <link rel="stylesheet" href="../../resources/css/workshops-details.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/calendar.css"/>

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/resources/js/calendar.js" defer></script>
        <script src="${pageContext.request.contextPath}/resources/js/cart.js" defer></script>

        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/formClient.jsp" %>
        <%@ include file="../includes/modalAddToCart.jsp" %>

        <div class="container my-5">
            <div class="row justify-content-center">

                <% if (cursoSeleccionado != null) { %>

                <!-- Imagen del curso -->
                <div class="col-md-6 mb-4 animate__animated animate__fadeInLeft">
                    <div class="img-container">
                        <img src="<%= cursoSeleccionado.getImg() %>" class="img-fluid rounded" alt="<%= cursoSeleccionado.getNombre() %>">
                    </div>
                </div>
            </div>

            <!-- Detalles del curso -->
            <div class="row mt-4 animate__animated animate__fadeInRight">
                <div class="col-12">
                    <h4 class="text-center"><%= cursoSeleccionado.getNombre() %></h4>
                    <p class="text-center"><%= cursoSeleccionado.getDescripcion() %></p>

                    <h5 class="text-center my-4">Summary:</h5>
                    <ul class="list-unstyled text-center">
                        <li><strong>Level:</strong> <%= cursoSeleccionado.getNivel() %></li>
                        <li><strong>Language:</strong> <%= cursoSeleccionado.getIdioma() %></li>
                        <li><strong>Price:</strong> <%= cursoSeleccionado.getPrecio() %>€/Person</li>
                    </ul>
                </div>
            </div>

                <% } else { %>

                <div class="row">
                    <div class="col-12 animate__animated animate__fadeIn">
                        <h3 class="text-center text-danger">Curso no encontrado</h3>
                    </div>
                </div>

                <% } %>
        </div>

        <!-- Calendario con animación -->
        <div class="animate__animated animate__fadeInUp">
            <%@ include file="../includes/calendar.jsp" %>
        </div>

        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
