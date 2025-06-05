<%@ page import="com.ashyaart.ecommerce.modelo.Productos" %>
<%@ page import="java.util.List" %>

<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <%
            List<Productos> productos = (List<Productos>) application.getAttribute("listaProductos");
            if (productos != null && !productos.isEmpty()) {
                double delay = 0.0;
                for (Productos producto : productos) {
        %>
        <div class="col">
            <div class="card h-100 animate__animated animate__fadeInUp" style="animation-delay: <%= delay %>s;">
                <a href="jsp/vistas/shop-details.jsp?producto=<%= producto.getNombre().replace(" ", "%20") %>">
                    <img src="<%= producto.getImagen() %>" class="card-img-top" alt="<%= producto.getNombre() %>">
                </a>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= producto.getNombre() %></h5>
                    <p class="card-text"><%= producto.getDescripcion() %></p>
                    <p class="product-price fw-bold fs-5"><%= producto.getPrecio() %>&euro;</p>
                </div>
            </div>
        </div>
        <%
                    delay += 0.2;
                }
            }
        %>
    </div>
</div>
