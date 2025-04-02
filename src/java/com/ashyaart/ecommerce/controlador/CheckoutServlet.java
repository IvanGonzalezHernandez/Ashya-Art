// Importaciones necesarias para trabajar con Stripe y JSON
package com.ashyaart.ecommerce.controlador;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session; // Clase necesaria para manejar sesiones de pago de Stripe
import com.stripe.param.checkout.SessionCreateParams; // Parámetros para crear la sesión de pago

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckoutServlet extends HttpServlet {

    // Clase interna para modelar un producto en el carrito de compras
    private static class Producto {

        String nombre; // Nombre del producto
        int precio; // Precio en centavos (ejemplo: 2000 para 20€)
        int cantidad; // Cantidad del producto en el carrito
    }

    // Método que maneja la solicitud POST del Checkout
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Establecer encabezados CORS para permitir solicitudes desde cualquier origen
        response.setHeader("Access-Control-Allow-Origin", "*");  // Permitir solicitudes desde cualquier origen
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS"); // Métodos permitidos
        response.setHeader("Access-Control-Allow-Headers", "Content-Type"); // Encabezados permitidos

        // Si la solicitud es de tipo OPTIONS (preflight de CORS), respondemos con un status OK
        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        // Establecer la clave secreta de Stripe para autenticar la solicitud
        Stripe.apiKey = "sk_test_51R1AfzQsK7W2R2yG8WVaLsvv1BRvqO4LKG8RAtZXhUYhgijhzjcETNftYFhFafv67fYfMTKJNkGEyMHRd2qxEajp00j2cVA5bx"; // Sustituye con tu clave real

        // Leer el cuerpo de la solicitud (JSON) y convertirlo en un objeto de tipo Producto
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        String json = jsonBuilder.toString();

        // Usamos Gson para convertir el JSON recibido en una lista de productos
        Gson gson = new Gson();
        java.lang.reflect.Type listType = new TypeToken<List<Producto>>() {}.getType();
        List<Producto> carrito = gson.fromJson(json, listType);

        try {
            // Crear una lista de los productos que serán parte de la sesión de pago
            List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
            for (Producto producto : carrito) {
                // Crear un objeto LineItem por cada producto en el carrito
                lineItems.add(
                        SessionCreateParams.LineItem.builder()
                                .setPriceData(
                                        SessionCreateParams.LineItem.PriceData.builder()
                                                .setCurrency("eur") // Moneda del pago (Euros en este caso)
                                                .setUnitAmount((long) producto.precio) // Precio del producto en centavos
                                                .setProductData(
                                                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                .setName(producto.nombre) // Nombre del producto
                                                                .setDescription("Hermoso vaso hecho a mano con diseño único.")
                                                                .build()
                                                )
                                                .build()
                                )
                                .setQuantity((long) producto.cantidad) // Cantidad del producto
                                .build()
                );
            }

            // Crear los parámetros de la sesión de pago de Stripe
            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT) // Modo de la sesión (pago)
                    .setCustomerEmail("email@cliente.com") // Email del cliente (opcional)
                    .setAllowPromotionCodes(Boolean.TRUE) // Permitir el uso de códigos de promoción
                    .setSuccessUrl("http://localhost:8080/Ashya-Art/jsp/vistas/success.jsp") // URL de redirección en caso de éxito
                    .setCancelUrl("http://localhost:8080/Ashya-Art/jsp/vistas/cancel.jsp") // URL de redirección en caso de cancelación
                    .addAllLineItem(lineItems) // Agregar los productos a la sesión
                    .build();

            // Crear la sesión de pago en Stripe
            Session session = Session.create(params);

            // Enviar la URL de Stripe al cliente en formato JSON para redirigirlo a la página de pago
            response.setContentType("application/json");
            response.getWriter().write("{\"url\": \"" + session.getUrl() + "\"}");

        } catch (StripeException e) {
            // Si ocurre un error al crear la sesión de Stripe, se lanza una excepción
            throw new ServletException("Error creando sesión de Stripe", e);
        }
    }
}
