<%@page import="java.util.List"%>
<%@page import="com.ashyaart.ecommerce.modelo.Curso"%>
<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-2 g-4"> <!-- Solo 2 columnas en todas las pantallas -->
        <%
            List<Curso> cursos = (List<Curso>) application.getAttribute("cursos");
            if (cursos != null && !cursos.isEmpty()) {
                for (Curso curso : cursos) {
        %>
        <div class="col">
            <div class="card h-100">
                <a href="jsp/vistas/workshops-details.jsp?curso=<%= curso.getNombre().replace(" ", "%20")%>">
                    <img src="<%= curso.getImagen()%>" class="card-img-top" alt="<%= curso.getNombre()%>">
                </a>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= curso.getNombre()%></h5>
                    <p class="card-text"><%= curso.getSubtitulo()%></p>
                    <p class="course-price fw-bold fs-5"><%= curso.getPrecio()%>&euro;/Person</p>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>