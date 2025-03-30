<%@page import="com.ashyaart.ecommerce.modelo.Curso"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>


<%
    String nombreCurso = request.getParameter("curso");
    Curso cursoSeleccionado = null;
    List<Curso> cursos = (List<Curso>) application.getAttribute("cursos");

    if (cursos != null && nombreCurso != null) {
        for (Curso curso : cursos) {
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%= request.getAttribute("titulo")%></title>
        <link rel="stylesheet" href="../../resources/css/workshops-details.css">
        <%@ include file="../includes/cdn.jsp" %>

        <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>



    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <div class="container my-5">
            <div class="row justify-content-center">
                <% if (cursoSeleccionado != null) {%>
                <!-- Imagen centrada con tamaño uniforme -->
                <div class="col-md-6 mb-4">
                    <div class="img-container">
                        <img src="<%= cursoSeleccionado.getImagen()%>" class="img-fluid rounded" alt="<%= cursoSeleccionado.getNombre()%>">
                    </div>
                </div>
            </div>

            <!-- Detalles del curso -->
            <div class="row mt-4">
                <div class="col-12">
                    <h4 class="text-center"><%= cursoSeleccionado.getNombre()%></h4>
                    <p class="text-center"><%= cursoSeleccionado.getDescripcion()%></p>

                    <h5 class="text-center my-4">Summary:</h5>
                    <ul class="list-unstyled text-center">
                        <li><strong>Level:</strong> <%= cursoSeleccionado.getNivel()%></li>
                        <li><strong>Duration:</strong> <%= cursoSeleccionado.getDuracion()%></li>
                        <li><strong>Pieces created:</strong> <%= cursoSeleccionado.getPiezas_creadas()%></li>
                        <li><strong>Language:</strong> <%= cursoSeleccionado.getIdioma()%></li>
                        <li><strong>Location:</strong> <%= cursoSeleccionado.getLocalizacion()%></li>
                        <li><strong>Price:</strong> <%= cursoSeleccionado.getPrecio()%>€/Person</li>
                    </ul>
                </div>
            </div>
            <% } else { %>
            <h3 class="text-center text-danger">Curso no encontrado</h3>
            <% }%>
        </div>



        <div id="calendar"></div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth', // Vista inicial
                    events: [
                        {
                            title: 'Evento',
                            start: '2025-04-01',
                            extendedProps: {
                                imageUrl: '../../resources/imagenes/logo/logo.png'
                            }
                        }
                    ],


                });
                calendar.render();
            });
        </script>




        <%@ include file="../includes/footer.jsp" %>
    </body>
</html>
