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
                    <a class="nav-link" id="pedidos-tab" data-bs-toggle="pill" href="#cursos">
                        <i class="bi bi-box"></i> Cursos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="productos-tab" data-bs-toggle="pill" href="#productos">
                        <i class="bi bi-bag"></i> Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="clientes-tab" data-bs-toggle="pill" href="#clientes">
                        <i class="bi bi-people"></i> Clientes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="ventas-tab" data-bs-toggle="pill" href="#ventas">
                        <i class="bi bi-graph-up"></i> Ventas
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
            <div class="tab-content" id="contenido">



                <% String mensaje = request.getParameter("mensaje"); %>
                <% String error = request.getParameter("error"); %>

                <% if (mensaje != null) {%>
                <div class="alert alert-success">
                    <%= mensaje%>
                </div>
                <% } %>

                <% if (error != null) {%>
                <div class="alert alert-danger">
                    <%= error%>
                </div>
                <% }%>



                <div class="tab-pane fade show active" id="inicio">
                    <h2>Inicio</h2>
                    <p>Bienvenido al Dashboard.</p>
                </div>








                <div class="tab-pane fade" id="cursos">
                    <h2>Gestión de Cursos</h2>



                    <!-- Tabla donde se mostrarán los cursos -->
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
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Los datos se llenarán dinámicamente por DataTables -->
                        </tbody>
                    </table>


                    <script>
                        var contextPath = '<%= request.getContextPath()%>';

                        $(document).ready(function () {
                            $('#tablaCursos').DataTable({
                                ajax: {
                                    url: contextPath + '/AdminServlet?tipo=cursos', // URL que devolverá los cursos en formato JSON
                                    dataSrc: '', // Especificamos que la fuente de datos está en la raíz del JSON
                                    error: function (xhr, status, error) {
                                        console.error("Error al cargar datos:", xhr.responseText);
                                    }
                                },
                                columns: [
                                    {data: 'id'},
                                    {data: 'nombre'},
                                    {data: 'subtitulo'},
                                    {data: 'descripcion'},
                                    {data: 'precio'},
                                    {data: 'nivel'},
                                    {data: 'idioma'}
                                ],
                                responsive: true,
                                dom: 'Bfrtip', // Posiciona los botones arriba
                                buttons: [
                                    {
                                        extend: 'copyHtml5',
                                        text: '<i class="bi bi-clipboard"></i> Copiar', // Ícono de clipboard de Bootstrap
                                        titleAttr: 'Copiar al portapapeles',
                                        className: 'btn btn-success' // Estilo de botón con Bootstrap
                                    },
                                    {
                                        extend: 'excelHtml5',
                                        text: '<i class="bi bi-file-earmark-excel"></i> Excel', // Ícono de archivo Excel
                                        titleAttr: 'Exportar a Excel',
                                        className: 'btn btn-success'
                                    },
                                    {
                                        extend: 'pdfHtml5',
                                        text: '<i class="bi bi-file-earmark-pdf"></i> PDF', // Ícono de archivo PDF
                                        titleAttr: 'Exportar a PDF',
                                        orientation: 'landscape', // Establecer la orientación como "landscape"
                                        pageSize: 'A4',
                                        className: 'btn btn-danger',
                                        customize: function (doc) {
                                            doc.content[1].table.widths = ['10%', '20%', '20%', '20%', '10%', '10%', '10%', '10%'];
                                        }
                                    },
                                    {
                                        extend: 'print',
                                        text: '<i class="bi bi-printer"></i> Imprimir', // Ícono de impresora 
                                        titleAttr: 'Imprimir tabla',
                                        className: 'btn btn-info'
                                    }
                                ],
                                language: {
                                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                                }
                            });
                        });
                    </script>




                    <h3>Añadir Curso</h3>
                    <form action="<%= request.getContextPath()%>/AdminServlet" method="post" enctype="multipart/form-data">
                        <!-- Campo oculto con la acción que va a realizar el servlet -->
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
                            <label for="img" class="form-label">Imagen del curso</label>
                            <input type="text" class="form-control" id="img" name="img" placeholder="Ingrese la URL de la imagen">
                        </div>

                        <button name="insertarCurso" type="submit" class="btn btn-success">Guardar Curso</button>
                    </form>




                    <!-- Formulario para asignar fecha a un curso -->
                    <h3>Asignar fecha a un curso</h3>
                    <form action="<%= request.getContextPath()%>/AdminServlet" method="post">
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

                        <button type="submit" name="action" value="insertarFechaCurso" class="btn btn-success">Asignar fecha</button>
                    </form>

                </div>










                <div class="tab-pane fade" id="productos">
                    <h2>Productos</h2>
                    <p>Administración de productos en la tienda.</p>
                </div>
                <div class="tab-pane fade" id="clientes">
                    <h2>Listado de Clientes</h2>

                    <!-- Estilos de DataTables -->
                    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

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
                        <tbody></tbody>
                    </table>



                    <script>
                        var contextPath = '<%= request.getContextPath()%>';

                        $(document).ready(function () {
                            $('#tablaClientes').DataTable({
                                ajax: {
                                    url: contextPath + '/AdminServlet?tipo=clientes',
                                    dataSrc: '',
                                    error: function (xhr, status, error) {
                                        console.error("Error al cargar datos:", xhr.responseText);
                                    }
                                },
                                columns: [
                                    {data: 'nombre'},
                                    {data: 'apellido'},
                                    {data: 'direccion'},
                                    {data: 'telefono'},
                                    {data: 'email'},
                                    {data: 'idStripe'}
                                ],
                                responsive: true,
                                dom: 'Bfrtip', // Posiciona los botones arriba
                                buttons: [
                                    {
                                        extend: 'copyHtml5',
                                        text: '<i class="bi bi-clipboard"></i> Copiar', // Ícono de clipboard de Bootstrap
                                        titleAttr: 'Copiar al portapapeles',
                                        className: 'btn btn-success' // Estilo de botón con Bootstrap
                                    },
                                    {
                                        extend: 'excelHtml5',
                                        text: '<i class="bi bi-file-earmark-excel"></i> Excel', // Ícono de archivo Excel
                                        titleAttr: 'Exportar a Excel',
                                        className: 'btn btn-success'
                                    },
                                    {
                                        extend: 'pdfHtml5',
                                        text: '<i class="bi bi-file-earmark-pdf"></i> PDF', // Ícono de archivo PDF
                                        titleAttr: 'Exportar a PDF',
                                        orientation: 'landscape', // Establecer la orientación como "landscape"
                                        pageSize: 'A4',
                                        className: 'btn btn-danger',
                                        customize: function (doc) {
                                            doc.content[1].table.widths = ['25%', '25%', '25%', '25%', '25%', '25%'];
                                        }
                                    },
                                    {
                                        extend: 'print',
                                        text: '<i class="bi bi-printer"></i> Imprimir', // Ícono de impresora 
                                        titleAttr: 'Imprimir tabla',
                                        className: 'btn btn-info'
                                    }
                                ],
                                language: {
                                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                                }
                            });
                        });
                    </script>


                </div>
                <div class="tab-pane fade" id="ventas">
                    <h2>Reservas</h2>

                    <!-- Tabla de reservas -->
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
                            <!-- Los datos se llenarán dinámicamente mediante DataTables -->
                        </tbody>
                    </table>

                    <script>
        var contextPath = '<%= request.getContextPath()%>';

        $(document).ready(function () {
            $('#tablaReservas').DataTable({
                ajax: {
                    url: contextPath + '/AdminServlet?tipo=reservas', // URL que devolverá las reservas en formato JSON
                    dataSrc: '', // Especificamos que la fuente de datos está en la raíz del JSON
                    error: function (xhr, status, error) {
                        console.error("Error al cargar datos:", xhr.responseText);
                    }
                },
                columns: [
                    {data: 'nombreCurso'}, // Nombre del curso
                    {data: 'nombreCliente'}, // Nombre del cliente
                    {data: 'fechaCurso'}, // Fecha de la reserva
                    {data: 'horaCurso'}, // Hora de la reserva
                    {data: 'plazasReservadas'} // Plazas reservadas
                ],
                responsive: true,
                dom: 'Bfrtip', // Posiciona los botones arriba
                buttons: [
                    {
                        extend: 'copyHtml5',
                        text: '<i class="bi bi-clipboard"></i> Copiar', // Ícono de clipboard de Bootstrap
                        titleAttr: 'Copiar al portapapeles',
                        className: 'btn btn-success' // Estilo de botón con Bootstrap
                    },
                    {
                        extend: 'excelHtml5',
                        text: '<i class="bi bi-file-earmark-excel"></i> Excel', // Ícono de archivo Excel
                        titleAttr: 'Exportar a Excel',
                        className: 'btn btn-success'
                    },
                    {
                        extend: 'pdfHtml5',
                        text: '<i class="bi bi-file-earmark-pdf"></i> PDF', // Ícono de archivo PDF
                        titleAttr: 'Exportar a PDF',
                        orientation: 'landscape', // Establecer la orientación como "landscape"
                        pageSize: 'A4',
                        className: 'btn btn-danger',
                        customize: function (doc) {
                            doc.content[1].table.widths = ['20%', '20%', '20%', '15%', '15%'];
                        }
                    },
                    {
                        extend: 'print',
                        text: '<i class="bi bi-printer"></i> Imprimir', // Ícono de impresora 
                        titleAttr: 'Imprimir tabla',
                        className: 'btn btn-info'
                    }
                ],
                language: {
                    url: "//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                }
            });
        });
                    </script>
                </div>



                <div class="tab-pane fade" id="configuracion">
                    <h2>Configuración</h2>
                    <p>Ajustes generales de la tienda.</p>
                </div>
            </div>

            <form action="../../LoginServlet" method="post" class="mt-3">
                <button id="button" name="button" value="logout" class="btn btn-custom">
                    Cerrar Sesión
                </button>
            </form>
        </main>






    </body>
</html>
