<%@page import="com.ashyaart.ecommerce.modelo.Cursos"%>
<%@ page import="java.util.List" %>

<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <%
            List<Cursos> cursos = (List<Cursos>) application.getAttribute("listaCursos");
            if (cursos != null && !cursos.isEmpty()) {
                double delay = 0.0; // delay en segundos, con decimales
                for (Cursos curso : cursos) {
        %>
        <div class="col">
            <div class="card h-100 animate__animated animate__fadeInUp" style="animation-delay: <%= delay %>s;">
                <a href="jsp/vistas/workshops-details.jsp?curso=<%= curso.getNombre().replace(" ", "%20") %>">
                    <img src="<%= curso.getImg() %>" class="card-img-top" alt="<%= curso.getNombre() %>">
                </a>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= curso.getNombre() %></h5>
                    <p class="card-text"><%= curso.getSubtitulo() %></p>
                    <p class="course-price fw-bold fs-5"><%= curso.getPrecio() %>&euro;/Person</p>
                </div>
            </div>
        </div>
        <%
                    delay += 0.2; // suma 0.2s para la siguiente tarjeta
                }
            }
        %>
    </div>
</div>
