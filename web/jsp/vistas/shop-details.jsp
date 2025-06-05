<%@page import="com.ashyaart.ecommerce.modelo.Productos"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<%
    String nombreProducto = request.getParameter("producto");
    Productos productoSeleccionado = null;
    List<Productos> productos = (List<Productos>) application.getAttribute("listaProductos");

    if (productos != null && nombreProducto != null) {
        for (Productos producto : productos) {
            if (producto.getNombre().equalsIgnoreCase(nombreProducto)) {
                productoSeleccionado = producto;
                break;
            }
        }
    }

    request.setAttribute("titulo", productoSeleccionado != null ? productoSeleccionado.getNombre() : "Producto no encontrado");
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
        <title><%= request.getAttribute("titulo")%></title>

        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

        <!-- CSS personalizado -->
        <link rel="stylesheet" href="../../resources/css/shop-details.css">

        <!-- JS -->
        <script src="${pageContext.request.contextPath}/resources/js/cart.js" defer></script>
        <script src="${pageContext.request.contextPath}/resources/js/modalAddToCart.js" defer></script>

        <%@ include file="../includes/cdn.jsp" %>
    </head>
    <body>
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/formClient.jsp" %>

        <main class="container my-5">
            <div class="container my-5">
                <div class="row justify-content-center">

                    <% if (productoSeleccionado != null) {%>

                    <!-- Imagen del producto -->
                    <div class="col-md-6 mb-4 d-flex justify-content-center align-items-center animate__animated animate__fadeInLeft">
                        <div class="img-container text-center">
                            <img src="<%= productoSeleccionado.getImagen()%>" class="img-fluid rounded" alt="<%= productoSeleccionado.getNombre()%>" style="max-height: 400px;">
                        </div>
                    </div>


                    <!-- Detalles del producto -->
                    <div class="row mt-4 animate__animated animate__fadeInRight">
                        <div class="col-12">
                            <h4 class="text-center"><%= productoSeleccionado.getNombre()%></h4>
                            <p class="text-center"><%= productoSeleccionado.getDescripcion()%></p>

                            <ul class="list-unstyled text-center">
                                <li><strong>Categoría:</strong> <%= productoSeleccionado.getCategoria()%></li>
                                <li><strong>Stock disponible:</strong> <%= productoSeleccionado.getStock()%> unidades</li>
                                <li><strong>Precio:</strong> <%= productoSeleccionado.getPrecio()%>€</li>
                            </ul>
                            <div class="text-center py-3">
                                <button type="button" 
                                        class="btn btn-custom btn-agregar-ceramica"
                                        data-id="<%= productoSeleccionado.getId()%>"
                                        data-nombre="<%= productoSeleccionado.getNombre()%>"
                                        data-precio="<%= productoSeleccionado.getPrecio()%>"
                                        data-img="<%= productoSeleccionado.getImagen()%>"
                                        onclick="añadirAlCarrito(this)">
                                    Add to the Cart
                                </button>
                            </div>

                        </div>
                    </div>

                    <% } else { %>

                    <div class="row">
                        <div class="col-12 animate__animated animate__fadeIn">
                            <h3 class="text-center text-danger">Producto no encontrado</h3>
                        </div>
                    </div>

                    <% }%>
                </div>
        </main>

        <%@ include file="../includes/footer.jsp" %>

        <%@ include file="../includes/modalAddToCart.jsp" %>

        <script>

        </script>

    </body>
</html>





