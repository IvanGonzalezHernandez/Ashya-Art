package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.PaymentLog;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class CancelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Establecer clave secreta de Stripe
        Stripe.apiKey = "sk_test_51R1AfzQsK7W2R2yG8WVaLsvv1BRvqO4LKG8RAtZXhUYhgijhzjcETNftYFhFafv67fYfMTKJNkGEyMHRd2qxEajp00j2cVA5bx";

        // Obtener el ID de sesión desde la URL
        String sessionId = request.getParameter("session_id");

        System.out.println("Session ID recibido: " + sessionId);

        if (sessionId == null || sessionId.isEmpty()) {
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
            return;
        }

        try {
            // Obtener la sesión desde Stripe
            Session session = Session.retrieve(sessionId);

            String nombre = session.getMetadata().get("nombre");
            String apellido = session.getMetadata().get("apellido");
            String direccion = session.getMetadata().get("direccion");
            String telefono = session.getMetadata().get("telefono");
            String email = session.getMetadata().get("email");
            String idStripe = sessionId;

            
            // Log para registrar cada producto comprado en success.log
            PaymentLog.logClienteCancel(nombre, apellido, direccion, telefono, email, idStripe);

            // Redirigir a la vista de éxito
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");

            // Aquí ya puedes hacer el resto: guardar cliente, redirigir, etc.
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
        }
    }
}
