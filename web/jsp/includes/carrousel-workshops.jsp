<%@page import="com.ashyaart.ecommerce.modelo.Cursos"%>
<%@page import="java.util.List"%>

<%
    // Obtener la lista de cursos del atributo de la aplicación
    List<Cursos> cursos = (List<Cursos>) application.getAttribute("listaCursos");
%>

<!-- Hero 2 - Carrusel dinámico de cursos con Swiper -->
<section class="carrousel-section d-flex flex-column align-items-center justify-content-center text-center"
         style="background-color: #F9F3EC; color: #3E3028; padding: 6rem 2rem;">
    <!-- Título -->
    <h3 class="mb-4">DISCOVER OUR CERAMIC WORKSHOPS</h3>

    <!-- Swiper container -->
    <div class="swiper swiper-cursos w-100" style="max-width: 1200px;">
        <div class="swiper-wrapper">
            <%
                if (cursos != null && !cursos.isEmpty()) {
                    for (int i = 0; i < cursos.size(); i++) {
                        Cursos curso = cursos.get(i);
            %>
            <div class="swiper-slide" style="width: 320px;">
                <div class="position-relative">
                    <!-- Enlace al detalle del curso -->
                    <a href="jsp/vistas/workshops-details.jsp?curso=<%= curso.getNombre().replace(" ", "%20")%>">
                        <img src="<%= curso.getImg()%>" alt="<%= curso.getNombre()%>" 
                             style="height: 400px; width: 100%; object-fit: cover; border-radius: 12px;">
                    </a>
                    <div class="position-absolute bottom-0 start-0 w-100 text-center text-white p-2 bg-dark bg-opacity-50">
                        <h5 class="mb-0"><%= curso.getNombre()%></h5>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="swiper-slide" style="width: 320px;">
                <p class="text-muted">No courses available at the moment.</p>
            </div>
            <% } %>
        </div>

        <!-- Swiper navigation -->
        <div class="swiper-button-prev text-white"></div>
        <div class="swiper-button-next text-white"></div>
    </div>
</section>
