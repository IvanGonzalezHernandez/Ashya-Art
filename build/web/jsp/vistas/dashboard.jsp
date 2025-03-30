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


    </body>
</html>
