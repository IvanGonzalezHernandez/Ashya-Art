<%@page import="com.ashyaart.ecommerce.modelo.TarjetaRegalo"%>
<%@ page import="java.util.List" %>

<%
    // Obtener la lista de tarjetas de regalo desde el contexto de la aplicación
    List<TarjetaRegalo> tarjetasRegalo = (List<TarjetaRegalo>) application.getAttribute("listaTarjetasRegalo");
%>

<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <%-- Verificar si la lista de tarjetas de regalo no es nula ni vacía --%>
        <%
            if (tarjetasRegalo != null && !tarjetasRegalo.isEmpty()) {
                // Iterar sobre cada tarjeta en la lista
                for (TarjetaRegalo tarjeta : tarjetasRegalo) {
        %>
        <!-- Crear una columna para cada tarjeta -->
        <div class="col">
            <div class="card h-100">
                <!-- Enlace al detalle de la tarjeta de regalo -->
                <a href="#" class="agregar-tarjeta"
                   data-id="<%= tarjeta.getPrecio() %>"
                   data-nombre="Tarjeta Regalo"
                   data-precio="<%= tarjeta.getPrecio() %>"
                   data-img="<%= tarjeta.getImagen() %>">
                    <img src="<%= tarjeta.getImagen() %>" class="card-img-top" alt="Tarjeta Regalo">
                </a>

                <div class="card-body d-flex flex-column">
                    <!-- ID del cupón de la tarjeta -->
                    <h5 class="card-title"><%= tarjeta.getIdCuponStripe() %></h5>
                    <!-- Precio de la tarjeta -->
                    <p class="card-text fw-bold fs-5">Precio: <%= tarjeta.getPrecio() %>&euro;</p>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <!-- Mensaje cuando no hay tarjetas de regalo disponibles -->
        <div class="col-12">
            <div class="alert alert-warning" role="alert">
                No hay tarjetas de regalo disponibles en este momento.
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>
