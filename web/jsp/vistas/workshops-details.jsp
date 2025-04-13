<%@ page import="com.ashyaart.ecommerce.modelo.Curso" %>  <!-- Importación de la clase Curso para utilizarla en la JSP -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>  <!-- Definir el tipo de contenido y codificación de caracteres para la página -->
<%@ page import="java.util.List" %>  <!-- Importar la clase List para manejar listas de cursos -->

<%
    // Obtener el parámetro 'curso' de la solicitud, proviene de  curso=....... en el include de workshops que pasa el paramentro por URL
    String nombreCurso = request.getParameter("curso");
    
    // Inicializar la variable que almacenará el curso seleccionado
    Curso cursoSeleccionado = null;
    
    // Obtener la lista de cursos almacenada en el contexto de la aplicación
    List<Curso> cursos = (List<Curso>) application.getAttribute("cursos");

    // Si la lista de cursos no es nula y el nombre del curso es válido
    if (cursos != null && nombreCurso != null) {
        // Iterar sobre los cursos para encontrar el que coincide con el nombre proporcionado
        for (Curso curso : cursos) {
            // Comparar el nombre del curso ignorando mayúsculas/minúsculas
            if (curso.getNombre().equalsIgnoreCase(nombreCurso)) {
                // Si se encuentra el curso, asignarlo a la variable cursoSeleccionado
                cursoSeleccionado = curso;
                break;
            }
        }
    }

    // Establecer el título de la página con el nombre del curso o un mensaje de error si no se encuentra
    request.setAttribute("titulo", cursoSeleccionado != null ? cursoSeleccionado.getNombre() : "Curso no encontrado");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  <!-- Definir el tipo de contenido HTML -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">  <!-- Asegurarse de que la página sea responsiva en dispositivos móviles -->
        <title><%= request.getAttribute("titulo") %></title>  <!-- Título de la página que se establece en el bloque anterior -->
        
        <!-- Enlace a una hoja de estilos CSS personalizada -->
        <link rel="stylesheet" href="../../resources/css/workshops-details.css">
        
        <!-- Incluir archivos comunes para el sitio -->
        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>  <!-- Incluir el encabezado común del sitio -->

        <div class="container my-5">  <!-- Contenedor principal de la página -->
            <div class="row justify-content-center">  <!-- Fila centrada para mostrar el contenido -->

                <% if (cursoSeleccionado != null) { %>  <!-- Si se encuentra el curso seleccionado -->
                
                <!-- Mostrar la imagen del curso -->
                <div class="col-md-6 mb-4">
                    <div class="img-container">
                        <img src="<%= cursoSeleccionado.getImagen() %>" class="img-fluid rounded" alt="<%= cursoSeleccionado.getNombre() %>">
                    </div>
                </div>
            </div>

            <!-- Mostrar los detalles del curso -->
            <div class="row mt-4">
                <div class="col-12">
                    <!-- Título del curso -->
                    <h4 class="text-center"><%= cursoSeleccionado.getNombre() %></h4>
                    <!-- Descripción del curso -->
                    <p class="text-center"><%= cursoSeleccionado.getDescripcion() %></p>

                    <!-- Resumen con detalles del curso -->
                    <h5 class="text-center my-4">Summary:</h5>
                    <ul class="list-unstyled text-center">
                        <!-- Detalles del curso -->
                        <li><strong>Level:</strong> <%= cursoSeleccionado.getNivel() %></li>
                        <li><strong>Duration:</strong> <%= cursoSeleccionado.getDuracion() %></li>
                        <li><strong>Pieces created:</strong> <%= cursoSeleccionado.getPiezas_creadas() %></li>
                        <li><strong>Language:</strong> <%= cursoSeleccionado.getIdioma() %></li>
                        <li><strong>Price:</strong> <%= cursoSeleccionado.getPrecio() %>€/Person</li>
                    </ul>
                </div>
            </div>
            
            <% } else { %>  <!-- Si no se encuentra el curso, mostrar mensaje de error -->
            <h3 class="text-center text-danger">Curso no encontrado</h3>
            <% } %>
        </div>

        <%@ include file="../includes/footer.jsp" %>  <!-- Incluir el pie de página común del sitio -->
    </body>
</html>
