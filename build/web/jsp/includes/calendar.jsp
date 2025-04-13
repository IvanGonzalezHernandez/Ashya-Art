<%@page import="com.ashyaart.ecommerce.modelo.Curso"%>  <!-- Importa la clase Curso del paquete modelo -->
<%@page import="java.util.List"%>  <!-- Importa la clase List de la librer�a java.util -->
<%
    // Obtiene la lista de cursos almacenada en el contexto de la aplicaci�n
    List<Curso> cursos = (List<Curso>) application.getAttribute("cursos");
%>

<!-- Contenedor principal del calendario -->
<div class="container">
    <div class="controls">
        <!-- Bot�n para cambiar al mes anterior -->
        <button class="btn btn-link text-dark" onclick="changeMonth(-1)" aria-label="Anterior">
            <i class="bi bi-caret-left-fill" style="font-size: 1.5rem;"></i>
        </button>

        <!-- T�tulo que mostrar� el mes y a�o actual -->
        <h1 id="monthYear"></h1>

        <!-- Bot�n para cambiar al mes siguiente -->
        <button class="btn btn-link text-dark" onclick="changeMonth(1)" aria-label="Siguiente">
            <i class="bi bi-caret-right-fill" style="font-size: 1.5rem;"></i>
        </button>
    </div>

    <!-- Encabezado con los nombres de los d�as de la semana -->
    <div class="header" id="header">
        <div>Dom</div>
        <div>Lun</div>
        <div>Mar</div>
        <div>Mi�</div>
        <div>Jue</div>
        <div>Vie</div>
        <div>S�b</div>
    </div>

    <!-- Contenedor donde se generar� el calendario din�micamente con JavaScript -->
    <div class="calendar" id="calendar"></div>
</div>

<!-- Modal para mostrar detalles del curso -->
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                
                <!-- Selecci�n de Curso -->
                <h6>Seleccione un curso:</h6>
                <select id="courseSelect" class="form-select" onchange="updateCourseDetails()">
                    <%-- Aqu� iteramos sobre la lista de cursos --%>
                    <%
                        // Itera sobre la lista de cursos y los muestra como opciones en el select
                        for (Curso curso : cursos) {
                    %>
                        <option value="<%= curso.getId_curso()%>" 
                                data-img="<%= curso.getImagen() %>" 
                                data-price="<%= curso.getPrecio() %>"
                                data-time="<%= curso.getDuracion() %>"
                                data-spots="<%= curso.getNivel() %>">
                            <%= curso.getNombre() %>
                        </option>
                    <%
                        }
                    %>
                </select>

                <!-- Imagen del curso seleccionado -->
                <img id="eventImage" src="/Ashya-Art/resources/imagenes/workshops-services/courses/hand_building_class.png" alt="Imagen del curso" style="width: 100%; height: auto; max-height: 300px; object-fit: cover; margin-top: 10px;">
                
                <!-- Detalles del curso -->
                <p><strong>Precio:</strong> <span id="coursePrice"></span></p>
                <p><strong>Horario:</strong> <span id="courseTime"></span></p>
                <p><strong>Plazas restantes:</strong> <span id="courseSpots"></span></p>
                <p><a id="courseLink" href="${pageContext.request.contextPath}/NavigationServlet?page=workshops">M�s informaci�n</a></p>

                <!-- Bot�n para agregar al carrito -->
                <button type="button" id="addToCartButton" class="btn btn-primary w-100">Add to the cart</button>
                
            </div>
        </div>
    </div>
</div>
