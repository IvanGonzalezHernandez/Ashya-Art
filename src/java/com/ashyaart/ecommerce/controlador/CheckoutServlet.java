package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.modelo.ProductoCarrito;
import com.google.gson.Gson;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // CORS
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");

        if ("OPTIONS".equalsIgnoreCase(request.getMethod())) {
            response.setStatus(HttpServletResponse.SC_OK);
            return;
        }

        // Clave secreta de Stripe
        Stripe.apiKey = "sk_test_51R1AfzQsK7W2R2yG8WVaLsvv1BRvqO4LKG8RAtZXhUYhgijhzjcETNftYFhFafv67fYfMTKJNkGEyMHRd2qxEajp00j2cVA5bx";

        // Leer JSON
        BufferedReader reader = request.getReader();
        StringBuilder jsonBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }

        String json = jsonBuilder.toString();
        Gson gson = new Gson();

        Map<String, Object> datos = gson.fromJson(json, Map.class);
        Map<String, String> cliente = (Map<String, String>) datos.get("cliente");

        // Convertir carrito a lista de ProductoCarrito
        List<?> carritoRaw = (List<?>) datos.get("carrito");
        List<ProductoCarrito> carrito = new ArrayList<>();
        for (Object obj : carritoRaw) {
            String itemJson = gson.toJson(obj);
            carrito.add(gson.fromJson(itemJson, ProductoCarrito.class));
        }

        String nombre = cliente.get("nombre");
        String apellido = cliente.get("apellido");
        String direccion = cliente.get("direccion");
        String telefono = cliente.get("telefono");
        String email = cliente.get("email");

        try {
            List<SessionCreateParams.LineItem> lineItems = new ArrayList<>();
            for (ProductoCarrito producto : carrito) {
                lineItems.add(
                        SessionCreateParams.LineItem.builder()
                                .setPriceData(
                                        SessionCreateParams.LineItem.PriceData.builder()
                                                .setCurrency("eur")
                                                .setUnitAmount((long) producto.getPrecio())
                                                .setProductData(
                                                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                .setName(producto.getNombre())
                                                                .setDescription("Hermoso vaso hecho a mano con diseño único.")
                                                                .build()
                                                )
                                                .build()
                                )
                                .setQuantity((long) producto.getCantidad())
                                .build()
                );
            }

            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setAllowPromotionCodes(true)
                    .addAllLineItem(lineItems)
                    .setBillingAddressCollection(SessionCreateParams.BillingAddressCollection.REQUIRED)
                    .setShippingAddressCollection(SessionCreateParams.ShippingAddressCollection.builder().build())
                    .putMetadata("nombre", nombre)
                    .putMetadata("apellido", apellido)
                    .putMetadata("direccion", direccion)
                    .putMetadata("telefono", telefono)
                    .putMetadata("email", email)
                    .putMetadata("productos", gson.toJson(carrito))
                    .setCustomerEmail(email)
                    .setSuccessUrl("http://localhost:8080/Ashya-Art/SuccessServlet?session_id={CHECKOUT_SESSION_ID}")
                    .setCancelUrl("http://localhost:8080/Ashya-Art/CancelServlet?session_id={CHECKOUT_SESSION_ID}")
                    .build();

            Session session = Session.create(params);

            response.setContentType("application/json");
            response.getWriter().write("{\"url\": \"" + session.getUrl() + "\"}");

        } catch (StripeException e) {
            throw new ServletException("Error creando sesión de Stripe", e);
        }
    }
}
