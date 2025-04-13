// Importaciones necesarias para trabajar con Stripe y JSON
package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.util.SuccessLog;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session; // Clase necesaria para manejar sesiones de pago de Stripe
import com.stripe.param.checkout.SessionCreateParams; // Parámetros para crear la sesión de pago

import java.io.BufferedReader;
import java.io.IOException;
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

        // Leer los datos enviados como JSON
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        String json = jsonBuilder.toString();

        // Usar Gson para convertir el JSON en un objeto de tipo Map
        Gson gson = new Gson();
        java.lang.reflect.Type mapType = new TypeToken<java.util.Map<String, Object>>() {
        }.getType();
        java.util.Map<String, Object> datos = gson.fromJson(json, mapType);

        // Extraer los datos del cliente y del carrito
        java.util.Map<String, String> cliente = (java.util.Map<String, String>) datos.get("cliente");
        List<Producto> carrito = gson.fromJson(gson.toJson(datos.get("carrito")), new TypeToken<List<Producto>>() {
        }.getType());

        // Extraer datos del cliente
        String nombre = cliente.get("nombre");
        String apellido = cliente.get("apellido");
        String direccion = cliente.get("direccion");
        String telefono = cliente.get("telefono");
        String email = cliente.get("email");

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

                // Log para registrar cada producto comprado en success.log //AQUI HE CREADO EL LOG SUCCES Y EL DE CANCEL EL DE CANCEL NO LO HE USADO TODAVIA.
                SuccessLog.logPurchase(producto.nombre, producto.precio, producto.cantidad);
            }

            // Crear los parámetros de la sesión de pago de Stripe
            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT) // Modo de la sesión (pago)
                    .setAllowPromotionCodes(Boolean.TRUE) // Permitir el uso de códigos de promoción
                    .addAllLineItem(lineItems) // Agregar los productos a la sesión
                    .setBillingAddressCollection(SessionCreateParams.BillingAddressCollection.REQUIRED) // <- Obligatorio que rellene su dirección
                    .setShippingAddressCollection(
                            SessionCreateParams.ShippingAddressCollection.builder()
                                    .build()
                    )
                    .putMetadata("nombre", nombre) // Agregar datos del cliente a metadata
                    .putMetadata("apellido", apellido)
                    .putMetadata("direccion", direccion)
                    .putMetadata("telefono", telefono)
                    .putMetadata("email", email)
                    .setCustomerEmail(email) // Establece el correo electrónico para el checkout
                    .setSuccessUrl("http://localhost:8080/Ashya-Art/SuccessServlet?session_id={CHECKOUT_SESSION_ID}")
                    .setCancelUrl("http://localhost:8080/Ashya-Art/jsp/vistas/cancel.jsp") // URL de redirección en caso de cancelación
                    .build();

            // Crear la sesión de pago en Stripe
            Session session = Session.create(params);

            // Mostrar información útil de la sesión
            System.out.println("===== SESIÓN DE STRIPE =====");
            System.out.println("ID de la sesión: " + session.getId());
            System.out.println("URL de pago: " + session.getUrl());
            System.out.println("Estado del pago: " + session.getPaymentStatus()); // Puede ser 'unpaid', 'paid', 'no_payment_required', etc.
            System.out.println("Método de pago: " + session.getPaymentMethodTypes()); // Tipos permitidos (ej: [card])
            System.out.println("Email del cliente: " + session.getCustomerEmail()); // Puede estar vacío si no se ha configurado
            System.out.println("ID del cliente (Stripe): " + session.getCustomer()); // ID del cliente en Stripe (puede ser null)
            System.out.println("Modo de sesión: " + session.getMode()); // payment, subscription, etc.
            System.out.println("Metadatos:");
            System.out.println("Nombre: " + session.getMetadata().get("nombre"));
            System.out.println("Apellido: " + session.getMetadata().get("apellido"));
            System.out.println("Dirección: " + session.getMetadata().get("direccion"));

            // Enviar la URL de Stripe al cliente en formato JSON para redirigirlo a la página de pago
            response.setContentType("application/json");
            response.getWriter().write("{\"url\": \"" + session.getUrl() + "\"}");

        } catch (StripeException e) {
            // Si ocurre un error al crear la sesión de Stripe, se lanza una excepción
            throw new ServletException("Error creando sesión de Stripe", e);
        }
    }
}
