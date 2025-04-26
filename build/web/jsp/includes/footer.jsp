<!-- footer.jsp -->
<footer class="py-5 bg-light shadow-lg mt-auto">
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
                <p class="mb-1"><a href="#" class="text-dark text-decoration-none">About Ashya</a></p>
                <p><a href="#" class="text-dark text-decoration-none">The studio</a></p>

                <div class="d-flex justify-content-center justify-content-md-start gap-3">
                    <a class="text-dark" href="https://www.instagram.com/ashya_art/?hl=es" target="_blank"><i class="bi bi-instagram fs-4"></i></a>
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
                <div class="input-group">
                    <input type="email" class="form-control shadow-sm" placeholder="Enter your email">
                    <button id="button" class="btn shadow-sm" style="background-color: #3A9097 !important; color: #ffffff;">Subscribe</button>
                </div>
            </div>
        </div>

        <!-- Logo centrado abajo -->
        <div class="text-center mt-4">
            <img src="${pageContext.request.contextPath}/resources/imagenes/logo/logo.png" alt="Logo" width="80">
        </div>
    </div>
</footer>
