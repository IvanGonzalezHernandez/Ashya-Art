<!-- footer.jsp -->
<footer class="py-5 shadow-lg mt-auto">
    <div class="container">
        <div class="row text-center text-md-start">
            <!-- Ubicación con Mapa de Google Maps -->
            <div class="col-md-3 mb-4 mb-md-0">
                <h6 class="fw-bold text-uppercase">Location</h6>
                <p class="mt-2">Pinneberger Ch 74, 22523 Hamburg</p>
                <p>0153 222 3434</p>
            </div>

            <!-- Información de Ashya -->
            <div class="col-md-3 mb-4 mb-md-0">
                <h6 class="fw-bold text-uppercase">Ashya</h6>
                <p class="mb-1">
                    <a href="${pageContext.request.contextPath}/jsp/vistas/about-ashya.jsp" class="text-dark text-decoration-none">About Ashya</a>
                </p>
                <p>
                    <a href="${pageContext.request.contextPath}/jsp/vistas/studio-membership.jsp" class="text-dark text-decoration-none">The studio</a>
                </p>
                <div class="d-flex justify-content-center justify-content-md-start gap-3">
                    <a class="text-dark" href="https://www.instagram.com/ashya_art" target="_blank">
                        <i class="bi bi-instagram fs-4"></i>
                    </a>
                </div>
            </div>

            <!-- Ayuda -->
            <div class="col-md-3 mb-4 mb-md-0">
                <h6 class="fw-bold text-uppercase">Help</h6>
                <p class="mb-1"><a href="#" class="text-dark text-decoration-none">Customer Service</a></p>
                <p class="mb-1"><a href="#" class="text-dark text-decoration-none">Terms and Conditions</a></p>
                <p><a href="#" class="text-dark text-decoration-none">Privacy Policy</a></p>
            </div>

            <!-- Newsletter -->
            <div class="col-md-3">
                <h6 class="fw-bold text-uppercase">Newsletter</h6>
                <p>Be the first to see our special offers.</p>

                <form action="<%= request.getContextPath()%>/NewsletterServlet" method="POST" class="d-flex flex-column">
                    <input 
                        type="email" 
                        name="correo" 
                        class="form-control shadow-sm mb-2" 
                        placeholder="Enter your email" 
                        required 
                        aria-label="Email for newsletter"
                        >
                    <button 
                        type="submit" 
                        class="btn shadow-sm mb-2" 
                        style="background-color: #3A9097 !important; color: #ffffff;"
                        >
                        Subscribe
                    </button>

                    <%
                        String exitoFooter = request.getParameter("exito");
                        String errorFooter = request.getParameter("error");
                        if (exitoFooter != null) {
                    %>
                    <div class="alert alert-success alert-dismissible fade show p-2 small" role="alert">
                        <%= exitoFooter%>
                        <button type="button" class="btn-close btn-sm" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                    </div>
                    <%
                    } else if (errorFooter != null) {
                    %>
                    <div class="alert alert-danger alert-dismissible fade show p-2 small" role="alert">
                        <%= errorFooter%>
                        <button type="button" class="btn-close btn-sm" data-bs-dismiss="alert" aria-label="Cerrar"></button>
                    </div>
                    <%
                        }
                    %>



                </form>
            </div>

            <!-- Logo centrado abajo -->
            <a href="#">
                <div class="text-center mt-4">
                    <img src="${pageContext.request.contextPath}/resources/imagenes/logo/logo.png" alt="Logo" width="80" class="footer-logo">
                </div>
            </a>
        </div>
    </div>
</footer>

<script>
    if (window.location.search.includes('exito=') || window.location.search.includes('error=')) {
        const url = new URL(window.location);
        url.searchParams.delete('exito');
        url.searchParams.delete('error');
        window.history.replaceState({}, document.title, url.pathname);
    }
</script>


