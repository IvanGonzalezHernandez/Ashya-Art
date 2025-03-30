<nav class="navbar navbar-expand-lg sticky-top">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- Logo a la izquierda -->
        <a class="navbar-brand me-3" href="#">
            <img src="${pageContext.request.contextPath}/resources/imagenes/logo/logo.png" alt="Logo" width="50">
        </a>

        <!-- Menú de navegación centrado y expandible -->
        <div class="collapse navbar-collapse flex-grow-1 text-center" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=home">HOME</a></li>
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=workshops">WORKSHOPS & SERVICES</a></li>
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=calendar">CALENDAR</a></li>
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=shop">SHOP</a></li>
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=about">ABOUT ASHYA</a></li>
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=studio">ASHYA'S STUDIO</a></li>
            </ul>
        </div>

        <!-- Carrito a la derecha con número de productos -->
        <div class="d-flex align-items-center" style="position: relative;">
            <a href="#" class="nav-link" data-bs-toggle="offcanvas" data-bs-target="#carrito" aria-controls="carrito" id="cart-icon">
                <i class="bi bi-cart" style="font-size: 1.5rem;"></i>
                <span id="cart-count" class="badge">0</span>
            </a>
        </div>

        <!-- Botón para menú en móviles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<!-- Aside del carrito usando offcanvas de Bootstrap -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="carrito" aria-labelledby="carritoLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="carritoLabel">Carrito</h5>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Cerrar"></button>
    </div>
    <div class="offcanvas-body">
        <!-- Los productos se cargarán dinámicamente aquí -->
        <div id="carrito-items">
            <!-- Los productos se insertarán dinámicamente aquí -->
        </div>
    </div>
    <div class="cart-footer mt-4 p-3 border-top">
        <div class="d-flex justify-content-between align-items-center">
            <strong>Total: <span id="cart-total">EUR 0.00</span></strong>
        </div>
        <button id="checkout-btn" class="btn btn-success w-100">Checkout</button>
    </div>

</div>

