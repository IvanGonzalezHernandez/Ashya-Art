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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />

        <title>Dashboard Ashya</title>
        <link rel="stylesheet" href="../../resources/css/admin.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="../../resources/js/chart.js"></script>
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



        <script>
            var contextPath = '<%= request.getContextPath()%>';
        </script>



        <script src="../../resources/js/datatables.js"></script>
    </head>



    <aside id="aside" role="navigation" class="d-flex flex-column justify-content-between vh-100 p-3">
        <div>
            <img src="../../resources/imagenes/logo/logo.png" alt="Ashya Art Logo" id="logo" class="mb-4">
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
                    <a class="nav-link" id="reservas-tab" data-bs-toggle="pill" href="#reservas">
                        <i class="bi bi-calendar-check"></i> Reservas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="productos-tab" data-bs-toggle="pill" href="#productos" tabindex="-1" aria-disabled="true">
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
                    <a class="nav-link disabled" id="configuracion-tab" data-bs-toggle="pill" href="#newsletter">
                        <i class="bi bi-envelope"></i> Newsletter
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="configuracion-tab" data-bs-toggle="pill" href="#configuracion">
                        <i class="bi bi-gear"></i> Configuración
                    </a>
                </li>
            </ul>
        </div>

        <!-- Botón de logout abajo -->
        <form action="../../LoginServlet" method="post" class="mt-3">
            <button id="buttonWeb" name="button" value="web" class="btn btn-secondary mb-2 w-100">
                Ir a la Web
            </button>
            <button id="button" name="button" value="logout" class="btn btn-dark w-100">
                Cerrar Sesión
            </button>
        </form>
    </aside>


    <main>

        <div class="tab-content" id="contenido">

            <% String mensaje = request.getParameter("mensaje"); %>
            <% String error = request.getParameter("error"); %>

            <% if (mensaje != null) {%>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= mensaje%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <% if (error != null) {%>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= error%>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }%>

            <!-- INICIO -->
            <div class="tab-pane fade show active" id="inicio">
                <h2>Inicio</h2>
                <canvas id="reservasPorMesChart" width="400" height="200"></canvas>

            </div>

            <!-- CURSOS -->
            <div class="tab-pane fade" id="cursos">
                <h2>Gestión de Cursos</h2>

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
                            <th>Imagen</th>
                            <th>Eliminar</th>
                            <th>Editar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Aquí se llenarán dinámicamente -->
                    </tbody>
                </table>


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





                <div class="accordion" id="accordionCursos">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#formCurso">✏️ Add Course</button>
                        </h2>
                        <div id="formCurso" class="accordion-collapse collapse">
                            <div class="accordion-body">

                                <form action="<%= request.getContextPath()%>/AdminServlet" method="post" class="mb-5">
                                    <input type="hidden" name="action" value="insertarCurso">


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

                                    <button type="submit" class="btn btn-custom">Guardar Curso</button>
                                </form>



                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#formFecha">📅 Add Course Date</button>
                        </h2>
                        <div id="formFecha" class="accordion-collapse collapse">
                            <div class="accordion-body">
                                <form action="<%= request.getContextPath()%>/AdminServlet" method="post">
                                    <input type="hidden" name="action" value="insertarFechaCurso">


                                    <div class="mb-3">
                                        <label for="id_curso" class="form-label">Curso</label>
                                        <select name="id_curso" id="id_curso" class="form-select" required>
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

                                    <button type="submit" class="btn btn-custom">Asignar Fecha</button>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>




            </div>


            <!-- RESERVAS -->
            <div class="tab-pane fade" id="reservas">
                <h2>Gestión de Reservas</h2>

                <table id="tablaReservas" class="display" style="width:100%">
                    <thead>
                        <tr>
                            <th>Curso Reservado</th>
                            <th>Email Cliente</th>
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





            <!-- PRODUCTOS -->
            <div class="tab-pane fade" id="productos">
                <h2>Gestión de Productos</h2>

                <!-- Tabla de Productos -->
                <table id="tablaProductos" class="display" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Descripción</th>
                            <th>Precio</th>
                            <th>Stock</th>
                            <th>Categoría</th>
                            <th>Imagen</th>
                            <th>Borrar</th>
                            <th>Editar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Aquí se llenarán dinámicamente -->
                    </tbody>
                </table>

                <div class="accordion" id="accordionProductos">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#formProducto">✏️ Añadir Producto</button>
                        </h2>
                        <div id="formProducto" class="accordion-collapse collapse">
                            <div class="accordion-body">

                                <form action="<%= request.getContextPath()%>/AdminServlet" method="post" class="mb-5">
                                    <input type="hidden" name="action" value="insertarProducto">

                                    <div class="mb-3">
                                        <label for="nombreProducto" class="form-label">Nombre del producto</label>
                                        <input type="text" class="form-control" id="nombreProducto" name="nombre" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="descripcionProducto" class="form-label">Descripción</label>
                                        <textarea class="form-control" id="descripcionProducto" name="descripcion" rows="3"></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="precioProducto" class="form-label">Precio (€)</label>
                                        <input type="number" step="0.01" class="form-control" id="precioProducto" name="precio" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="stockProducto" class="form-label">Stock</label>
                                        <input type="number" class="form-control" id="stockProducto" name="stock" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="categoriaProducto" class="form-label">Categoría</label>
                                        <select class="form-select" id="categoriaProducto" name="categoria" required>
                                            <option value="" disabled selected>Selecciona una categoría</option>
                                            <option value="Tazas">Tazas</option>
                                            <option value="Platos">Platos</option>
                                            <option value="Cuencos">Cuencos</option>
                                            <option value="Jarrones">Jarrones</option>
                                            <option value="Macetas">Macetas</option>
                                            <option value="Fuentes">Fuentes</option>
                                            <option value="Decoración">Decoración</option>
                                            <option value="Candelabros">Candelabros</option>
                                        </select>
                                    </div>


                                    <div class="mb-3">
                                        <label for="imagenProducto" class="form-label">Imagen del producto (URL)</label>
                                        <input type="text" class="form-control" id="imagenProducto" name="imagen">
                                    </div>

                                    <button type="submit" class="btn btn-custom">Guardar Producto</button>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>


                <!-- Modal Editar Producto -->
                <div class="modal fade" id="modalEditarProducto" tabindex="-1" aria-labelledby="modalEditarProductoLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form id="formEditarProducto" action="${pageContext.request.contextPath}/AdminServlet" method="POST">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalEditarProductoLabel">Editar Producto</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                </div>

                                <div class="modal-body">
                                    <input type="hidden" name="action" value="editarProducto">
                                    <input type="hidden" id="editarIdProducto" name="id">

                                    <div class="mb-3">
                                        <label for="editarNombreProducto" class="form-label">Nombre</label>
                                        <input type="text" class="form-control" id="editarNombreProducto" name="nombre" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editarDescripcionProducto" class="form-label">Descripción</label>
                                        <textarea class="form-control" id="editarDescripcionProducto" name="descripcion" rows="3" required></textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editarPrecioProducto" class="form-label">Precio (€)</label>
                                        <input type="number" step="0.01" class="form-control" id="editarPrecioProducto" name="precio" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editarStockProducto" class="form-label">Stock</label>
                                        <input type="number" class="form-control" id="editarStockProducto" name="stock" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editarCategoriaProducto" class="form-label">Categoría</label>
                                        <select class="form-select" id="editarCategoriaProducto" name="categoria" required>
                                            <option value="" disabled>Selecciona una categoría</option>
                                            <option value="Tazas">Tazas</option>
                                            <option value="Platos">Platos</option>
                                            <option value="Cuencos">Cuencos</option>
                                            <option value="Jarrones">Jarrones</option>
                                            <option value="Macetas">Macetas</option>
                                            <option value="Fuentes">Fuentes</option>
                                            <option value="Decoración">Decoración</option>
                                            <option value="Candelabros">Candelabros</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="editarImagenProducto" class="form-label">URL Imagen</label>
                                        <input type="text" class="form-control" id="editarImagenProducto" name="imagen">
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

            <!-- TARJETAS REGALO -->
            <div class="tab-pane fade" id="tarjetasRegalo">
                <h2>Gestión de Tarjetas Regalo</h2>

                <table id="tablaTarjetasRegalo" class="display" style="width:100%">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre Tarjeta</th>
                            <th>ID Referencia Stripe</th>
                            <th>Precio</th>
                            <th>Imagen</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Se llenará dinámicamente -->
                    </tbody>
                </table>

                <!-- Acordeón solo para el formulario -->
                <div class="accordion" id="accordionCrearTarjeta">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="headingCrearTarjeta">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCrearTarjeta" aria-expanded="true" aria-controls="collapseCrearTarjeta">
                                ✏️ Add Gift Card
                            </button>
                        </h2>
                        <div id="collapseCrearTarjeta" class="accordion-collapse collapse" aria-labelledby="headingCrearTarjeta" data-bs-parent="#accordionCrearTarjeta">
                            <div class="accordion-body">
                                <form action="<%= request.getContextPath()%>/GiftCardServlet" method="post">
                                    <div class="mb-3">
                                        <label for="idCupon" class="form-label">ID del Cupón Stripe</label>
                                        <input type="text" id="idCupon" name="idCupon" class="form-control" required>
                                        <small class="form-text text-muted">Identificador de Stripe para asociar la tarjeta regalo ejm: Tarjeta_70.</small>
                                    </div>

                                    <div class="mb-3">
                                        <label for="precioTarjeta" class="form-label">Precio (en euros)</label>
                                        <input type="number" id="precioTarjeta" name="precioTarjeta" class="form-control" required step="0.01" min="0">
                                        <small class="form-text text-muted">Valor económico de la tarjeta regalo.</small>
                                    </div>

                                    <div class="mb-3">
                                        <label for="imagen" class="form-label">Ruta de la Imagen</label>
                                        <input type="text" id="imagen" name="imagen" class="form-control" required>
                                        <small class="form-text text-muted">Ruta de la imagen que se asociará con la tarjeta regalo.</small>
                                    </div>

                                    <button type="submit" class="btn btn-custom">Crear Plantilla</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
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
                            <th>👁️ Cursos</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Se llenará dinámicamente -->
                    </tbody>
                </table>



                <div class="modal fade" id="modalCursosCliente" tabindex="-1" aria-labelledby="cursosClienteLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="cursosClienteLabel">Cursos reservados por el cliente</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <table id="tablaCursosCliente" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Nombre del Curso</th>
                                            <th>Subtítulo</th>
                                            <th>Descripción</th>
                                            <th>Precio</th>
                                            <th>Nivel</th>
                                            <th>Idioma</th>
                                            <th>Imagen</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Se rellena por JS -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <!-- NEWSLETTER -->
            <div class="tab-pane fade" id="newsletter">
            </div>



            <!-- CONFIGURACIÓN -->
            <div class="tab-pane fade" id="configuracion">
                <h2>Configuración</h2>
                <p>Ajustes generales de la tienda.</p>

                <form action="${pageContext.request.contextPath}/ResetCursosServlet" method="post" style="display:inline;">
                    <button type="submit" class="btn btn-warning" value="resetPassword">
                        Resetear Listas de Cursos
                    </button>
                </form>

                <!-- Botón que abre el modal -->
                <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#cambiarContraseñaModal">
                    Cambiar contraseña
                </button>

                <!-- Modal para cambiar la contraseña -->
                <div class="modal fade" id="cambiarContraseñaModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <form action="${pageContext.request.contextPath}/AdminServlet" method="post" class="modal-content">
                            <!-- Input oculto para la acción -->
                            <input type="hidden" name="action" value="cambiarContrasena">

                            <div class="modal-header">
                                <h5 class="modal-title" id="modalLabel">Cambiar contraseña</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <input type="email" name="email" class="form-control mb-2" placeholder="Email" required>
                                <input type="password" name="nuevaPassword" class="form-control mb-2" placeholder="Nueva contraseña" required>
                                <input type="password" name="confirmarPassword" class="form-control" placeholder="Confirmar contraseña" required>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Actualizar contraseña</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            </div>
                        </form>
                    </div>
                </div>





            </div>
        </div>


    </main>                 
    <!--Para evitar el error de uncaught reference del carrito-->
    <div style="display: none">
        <%@ include file="../includes/header.jsp" %>
    </div>

</html>

