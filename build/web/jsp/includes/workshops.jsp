<%@ page import="java.util.List" %>  <!-- Importar la clase List para manejar listas -->
<%@ page import="com.ashyaart.ecommerce.modelo.Curso" %>  <!-- Importar la clase Curso para poder acceder a sus atributos -->

<div class="container my-5">  <!-- Contenedor principal con margen superior e inferior -->
    <div class="row row-cols-1 row-cols-md-2 g-4">  <!-- Fila con 1 columna en pantallas pequeñas y 2 columnas en pantallas medianas o más grandes -->
        <%
            // Obtener la lista de cursos desde el contexto de la aplicación
            List<Curso> cursos = (List<Curso>) application.getAttribute("cursos");
            
            // Verificar que la lista de cursos no sea nula ni vacía
            if (cursos != null && !cursos.isEmpty()) {
                // Iterar sobre cada curso en la lista
                for (Curso curso : cursos) {
        %>
        <!-- Crear una columna para cada curso -->
        <div class="col"> 
            <div class="card h-100">  <!-- Crear una tarjeta con altura flexible para el curso -->
                <!-- Enlace al detalle del curso, pasando el nombre del curso como parámetro en la URL -->
                <a href="jsp/vistas/workshops-details.jsp?curso=<%= curso.getNombre().replace(" ", "%20") %>">
                    <!-- Imagen del curso con el atributo alt para accesibilidad -->
                    <img src="<%= curso.getImagen() %>" class="card-img-top" alt="<%= curso.getNombre() %>">
                </a>
                <div class="card-body d-flex flex-column">  <!-- Cuerpo de la tarjeta con disposición flexible -->
                    <!-- Nombre del curso -->
                    <h5 class="card-title"><%= curso.getNombre() %></h5>
                    <!-- Subtítulo del curso -->
                    <p class="card-text"><%= curso.getSubtitulo() %></p>
                    <!-- Precio del curso con formato adecuado -->
                    <p class="course-price fw-bold fs-5"><%= curso.getPrecio() %>&euro;/Person</p>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
</div>
