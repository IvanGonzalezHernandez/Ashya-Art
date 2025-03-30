<nav class="navbar navbar-expand-lg sticky-top"> <!-- Navbar con expansi�n en pantallas grandes y posici�n fija en la parte superior -->
    <div class="container d-flex justify-content-between align-items-center"> <!-- Contenedor flexible para distribuir elementos -->
        
        <!-- Logo a la izquierda -->
        <a class="navbar-brand me-3" href="#"> <!-- Enlace que contiene el logo -->
            <img src="${pageContext.request.contextPath}/resources/imagenes/logo/logo.png" alt="Logo" width="50"> <!-- Imagen del logo -->
        </a>

        <!-- Men� de navegaci�n centrado y expandible -->
        <div class="collapse navbar-collapse flex-grow-1 text-center" id="navbarNav"> <!-- Contenedor del men� de navegaci�n -->
            <ul class="navbar-nav mx-auto"> <!-- Lista de enlaces de navegaci�n con centrado horizontal -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=home">HOME</a></li> <!-- Enlace a la p�gina de inicio -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=workshops">WORKSHOPS & SERVICES</a></li> <!-- Enlace a talleres y servicios -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=calendar">CALENDAR</a></li> <!-- Enlace al calendario general -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=shop">SHOP</a></li> <!-- Enlace a la tienda -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=about">ABOUT ASHYA</a></li> <!-- Enlace a la secci�n "Sobre Ashya" -->
                <li class="nav-item me-5"><a class="nav-link" href="${pageContext.request.contextPath}/NavigationServlet?page=studio">ASHYA'S STUDIO</a></li> <!-- Enlace al estudio y membres�a -->
            </ul>
        </div>

        <!-- Carrito a la derecha con n�mero de productos -->
        <div class="d-flex align-items-center" style="position: relative;"> <!-- Contenedor del carrito con posicionamiento relativo -->
            <a href="#" class="nav-link"> <!-- Enlace al carrito -->
                <i class="bi bi-cart" style="font-size: 1.5rem;"></i> <!-- Icono de carrito con tama�o ajustado -->
                <!-- Contador de productos en el carrito -->
                <span id="cart-count" class="badge"> 
                    0 <!-- Este valor se actualizar� din�micamente mediante JavaScript -->
                </span>
            </a>
        </div>

        <!-- Bot�n para men� en m�viles -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"> <!-- Bot�n para colapsar el men� en dispositivos m�viles -->
            <span class="navbar-toggler-icon"></span> <!-- Icono del bot�n -->
        </button>
    </div>
</nav>
