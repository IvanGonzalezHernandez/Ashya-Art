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

                <!-- Formulario de Reserva -->
                <h5><strong>Formulario de Reserva</strong></h5>
                <form id="reservationForm">
                    <!-- Campo para ingresar el nombre -->
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="name" required>
                    </div>
                    <!-- Campo para ingresar los apellidos -->
                    <div class="mb-3">
                        <label for="lastname" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="lastname" required>
                    </div>
                    <!-- Campo para ingresar el correo electr�nico -->
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo Electr�nico</label>
                        <input type="email" class="form-control" id="email" required>
                    </div>
                    <!-- Campo para ingresar el tel�fono -->
                    <div class="mb-3">
                        <label for="phone" class="form-label">Tel�fono</label>
                        <input type="tel" class="form-control" id="phone" required>
                    </div>
                    <!-- Campo para ingresar la direcci�n -->
                    <div class="mb-3">
                        <label for="address" class="form-label">Direcci�n</label>
                        <input type="text" class="form-control" id="address" required>
                    </div>
                    <!-- Bot�n para agregar al carrito -->
                    <button type="button" id="addToCartButton" class="btn btn-primary w-100">Add to the cart</button>
                </form>
            </div>
        </div>
    </div>
</div>
