<%@page import="com.ashyaart.ecommerce.modelo.TarjetaRegalo"%>
<%@ page import="java.util.List" %>

<%
    List<TarjetaRegalo> tarjetasRegalo = (List<TarjetaRegalo>) application.getAttribute("listaTarjetasRegalo");
    double delay = 0.0; // delay inicial en segundos
%>

<div class="container my-5">
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <%
            if (tarjetasRegalo != null && !tarjetasRegalo.isEmpty()) {
                for (TarjetaRegalo tarjeta : tarjetasRegalo) {
        %>
        <div class="col">
            <div class="card h-100 animate__animated animate__fadeInUp" style="animation-delay: <%= delay%>s;">
                <a href="#" 
                   onclick="añadirAlCarrito(this)" 
                   class="agregar-tarjeta"
                   data-id="<%= tarjeta.getPrecio()%>"
                   data-nombre="Tarjeta Regalo"
                   data-precio="<%= tarjeta.getPrecio()%>"
                   data-img="<%= tarjeta.getImagen()%>">
                    <img src="<%= tarjeta.getImagen()%>" class="card-img-top" alt="Tarjeta Regalo">
                </a>


                <div class="card-body d-flex flex-column">
                    <h5 class="card-title"><%= tarjeta.getIdCuponStripe()%></h5>
                    <p class="card-text fw-bold fs-5">Precio: <%= tarjeta.getPrecio()%>&euro;</p>
                </div>
            </div>
        </div>
        <%
                delay += 0.2; // incrementamos delay para la siguiente tarjeta
            }
        } else {
        %>
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
