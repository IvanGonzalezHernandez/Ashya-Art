<%@page import="com.ashyaart.ecommerce.modelo.Cursos"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String adminEmail = (String) session.getAttribute("adminEmail");
    if (adminEmail == null) {
        response.sendRedirect("login.jsp"); // Redirige al login si no hay sesión activa
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
        <link rel="stylesheet" href="../../resources/css/admin.css">
        <%@ include file="../includes/cdn.jsp" %>

        <!-- CSS de DataTables y Botones -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">

        <!-- jQuery y JS de DataTables -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>
        <script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.print.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>

        <script src="../../resources/js/datatables.js"></script>
    </head>
    <body>



        <aside id="aside" role="navigation">
            <img src="../../resources/imagenes/logo/logo.png" alt="Ashya Art Logo" id="logo">
            <ul class="nav flex-column nav-pills" id="menuTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="inicio-tab" data-bs-toggle="pill" href="#inicio">
                        <i class="bi bi-house-door"></i> Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cursos-tab" data-bs-toggle="pill" href="#cursos">
                        <i class="bi bi-easel"></i> Cursos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="productos-tab" data-bs-toggle="pill" href="#productos">
                        <i class="bi bi-bag"></i> Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="tarjetasRegalo-tab" data-bs-toggle="pill" href="#tarjetasRegalo">
                        <i class="bi bi-gift"></i> Tarjetas Regalo
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="clientes-tab" data-bs-toggle="pill" href="#clientes">
                        <i class="bi bi-people"></i> Clientes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="reservas-tab" data-bs-toggle="pill" href="#reservas">
                        <i class="bi bi-calendar-check"></i> Reservas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="configuracion-tab" data-bs-toggle="pill" href="#configuracion">
                        <i class="bi bi-gear"></i> Configuración
                    </a>
                </li>
            </ul>
        </aside>

        <main>
            <script>
                var contextPath = '<%= request.getContextPath()%>';
            </script>

            <div class="tab-content" id="contenido">

                <% String mensaje = request.getParameter("mensaje"); %>
                <% String error = request.getParameter("error"); %>

                <% if (mensaje != null) {%>
                <div class="alert alert-success"><%= mensaje%></div>
                <% } %>

                <% if (error != null) {%>
                <div class="alert alert-danger"><%= error%></div>
                <% }%>

                <!-- INICIO -->
                <div class="tab-pane fade show active" id="inicio">
                    <h2>Inicio</h2>
                    <p>Bienvenido al Dashboard.</p>
                </div>

                <!-- CURSOS -->
                <div class="tab-pane fade" id="cursos">
                    <h2>Gestión de Cursos</h2>

                    <!-- Botones de acción -->
                    <div class="d-flex justify-content-end mb-3">
                        <button type="button" class="btn btn-custom me-2" data-bs-toggle="modal" data-bs-target="#modalAgregarCurso">
                            Añadir Curso
                        </button>
                        <button type="button" class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#modalAsignarFecha">
                            📅 Asignar Fecha
                        </button>
                    </div>

                    <!-- Tabla de Cursos -->
                    <table id="tablaCursos" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Subtítulo</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Nivel</th>
                                <th>Idioma</th>
                                <th>Eliminar</th>
                                <th>Editar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Aquí se llenarán dinámicamente -->
                        </tbody>
                    </table>

                    <!-- Modal Añadir Curso -->
                    <div class="modal fade" id="modalAgregarCurso" tabindex="-1" aria-labelledby="modalAgregarCursoLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="<%= request.getContextPath()%>/AdminServlet" method="post">
                                    <input type="hidden" name="action" value="insertarCurso">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalAgregarCursoLabel">Añadir Nuevo Curso</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre del curso</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="subtitulo" class="form-label">Subtítulo</label>
                                            <input type="text" class="form-control" id="subtitulo" name="subtitulo">
                                        </div>
                                        <div class="mb-3">
                                            <label for="descripcion" class="form-label">Descripción</label>
                                            <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
                                        </div>
                                        <div class="mb-3">
                                            <label for="precio" class="form-label">Precio (€)</label>
                                            <input type="number" step="0.01" class="form-control" id="precio" name="precio" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="nivel" class="form-label">Nivel</label>
                                            <input type="text" class="form-control" id="nivel" name="nivel">
                                        </div>
                                        <div class="mb-3">
                                            <label for="idioma" class="form-label">Idioma</label>
                                            <input type="text" class="form-control" id="idioma" name="idioma">
                                        </div>
                                        <div class="mb-3">
                                            <label for="img" class="form-label">Imagen del curso (URL)</label>
                                            <input type="text" class="form-control" id="img" name="img">
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-custom">Guardar Curso</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Asignar Fecha a Curso -->
                    <div class="modal fade" id="modalAsignarFecha" tabindex="-1" aria-labelledby="modalAsignarFechaLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="<%= request.getContextPath()%>/AdminServlet" method="post">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalAsignarFechaLabel">Asignar Fecha a Curso</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="id_curso" class="form-label">Curso</label>
                                            <select name="id_curso" id="id_curso" class="form-select">
                                                <%
                                                    List<Cursos> listaCursos = (List<Cursos>) application.getAttribute("listaCursos");
                                                    if (listaCursos != null) {
                                                        for (Cursos curso : listaCursos) {
                                                %>
                                                <option value="<%= curso.getId()%>"><%= curso.getNombre()%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="fecha" class="form-label">Fecha</label>
                                            <input type="date" class="form-control" id="fecha" name="fecha" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="hora" class="form-label">Hora</label>
                                            <input type="time" class="form-control" id="hora" name="hora" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="plazas" class="form-label">Plazas disponibles</label>
                                            <input type="number" class="form-control" id="plazas" name="plazas_disponibles" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" name="action" value="insertarFechaCurso" class="btn btn-custom">Asignar Fecha</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Editar Curso -->
                    <div class="modal fade" id="modalEditarCurso" tabindex="-1" aria-labelledby="modalEditarCursoLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form id="formEditarCurso" action="${pageContext.request.contextPath}/AdminServlet" method="POST">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalEditarCursoLabel">Editar Curso</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                    </div>

                                    <div class="modal-body">
                                        <input type="hidden" name="action" value="editarCurso">
                                        <input type="hidden" id="editarId" name="id">
                                        <input type="hidden" id="editarImg" name="img">


                                        <div class="mb-3">
                                            <label for="editarNombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control" id="editarNombre" name="nombre" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="editarSubtitulo" class="form-label">Subtítulo</label>
                                            <input type="text" class="form-control" id="editarSubtitulo" name="subtitulo" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="editarDescripcion" class="form-label">Descripción</label>
                                            <textarea class="form-control" id="editarDescripcion" name="descripcion" rows="3" required></textarea>
                                        </div>

                                        <div class="mb-3">
                                            <label for="editarPrecio" class="form-label">Precio</label>
                                            <input type="number" class="form-control" id="editarPrecio" name="precio" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="editarNivel" class="form-label">Nivel</label>
                                            <input type="text" class="form-control" id="editarNivel" name="nivel" required>
                                        </div>

                                        <div class="mb-3">
                                            <label for="editarIdioma" class="form-label">Idioma</label>
                                            <input type="text" class="form-control" id="editarIdioma" name="idioma" required>
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-custom">Guardar cambios</button>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>


                </div>


                <!-- PRODUCTOS -->
                <div class="tab-pane fade" id="productos">
                    <h2>Gestión de Productos</h2>

                    <table id="tablaProductos" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará dinámicamente -->
                        </tbody>
                    </table>
                </div>

                <!-- TARJETAS REGALO -->
                <div class="tab-pane fade" id="tarjetasRegalo">
                    <h2>Gestión de Tarjetas Regalo</h2>

                    <table id="tablaTarjetasRegalo" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará dinámicamente -->
                        </tbody>
                    </table>

                    <h3>Crear Cupón (Tarjeta Regalo)</h3>
                    <form action="<%= request.getContextPath()%>/GiftCardServlet" method="post">
                        <div class="mb-3">
                            <label for="idCupon" class="form-label">ID del Cupón</label>
                            <input type="text" id="idCupon" name="idCupon" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label for="precioTarjeta" class="form-label">Precio (en euros)</label>
                            <input type="number" id="precioTarjeta" name="precioTarjeta" class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-custom">Crear Cupón</button>
                    </form>
                </div>






                <!-- CLIENTES -->
                <div class="tab-pane fade" id="clientes">
                    <h2>Listado de Clientes</h2>

                    <table id="tablaClientes" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Email</th>
                                <th>ID Stripe</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará dinámicamente -->
                        </tbody>
                    </table>

                </div>

                <!-- RESERVAS -->
                <div class="tab-pane fade" id="reservas">
                    <h2>Gestión de Reservas</h2>

                    <table id="tablaReservas" class="display" style="width:100%">
                        <thead>
                            <tr>
                                <th>Curso</th>
                                <th>Cliente</th>
                                <th>Fecha Reserva</th>
                                <th>Hora Reserva</th>
                                <th>Plazas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Se llenará dinámicamente -->
                        </tbody>
                    </table>
                </div>

                <!-- CONFIGURACIÓN -->
                <div class="tab-pane fade" id="configuracion">
                    <h2>Configuración</h2>
                    <p>Ajustes generales de la tienda.</p>

                    <form action="${pageContext.request.contextPath}/ResetCursosServlet" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-warning" onclick="return confirm('¿Seguro que quieres actualizar las listas de cursos?')">
                            Resetear Listas de Cursos
                        </button>
                    </form>

                </div>
            </div>

            <!-- Botón de logout -->
            <form action="../../LoginServlet" method="post" class="mt-3">
                <button id="button" name="button" value="logout" class="btn btn-dark">
                    Cerrar Sesión
                </button>
            </form>
        </main>
    </body>
</html>
