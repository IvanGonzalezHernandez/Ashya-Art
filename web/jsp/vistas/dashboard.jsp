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
                    <a class="nav-link" id="pedidos-tab" data-bs-toggle="pill" href="#pedidos">
                        <i class="bi bi-box"></i> Pedidos
                    </a>
                    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
                    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css">
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
                <div class="tab-pane fade show active" id="inicio">
                    <h2>Inicio</h2>
                    <p>Bienvenido al Dashboard.</p>
                </div>
                <div class="tab-pane fade" id="pedidos">
                    <h2>Pedidos</h2>
                    <p>Gestión de pedidos y su estado.</p>
                </div>
                <div class="tab-pane fade" id="productos">
                    <h2>Productos</h2>
                    <p>Administración de productos en la tienda.</p>
                </div>
                <div class="tab-pane fade" id="clientes">
                    <h2>Clientes</h2>
                    <p>Lista de clientes y su historial de compras.</p>

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

                    <!-- jQuery y DataTables -->
                    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
                    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

                    <script>
    var contextPath = '<%= request.getContextPath()%>';

    $(document).ready(function () {
        $('#tablaClientes').DataTable({
            ajax: {
                url: contextPath + '/AdminServlet',
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
                    <h2>Ventas</h2>
                    <p>Reporte de ventas con gráficos.</p>
                </div>
                <div class="tab-pane fade" id="configuracion">
                    <h2>Configuración</h2>
                    <p>Ajustes generales de la tienda.</p>
                </div>
            </div>

            <form action="../../LoginServlet" method="post" class="mt-3">
                <button id="button" name="button" value="logout" class="btn btn-danger">
                    Cerrar Sesión
                </button>
            </form>
        </main>





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
    </body>
</html>
