package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class SuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Establecer clave secreta de Stripe
        Stripe.apiKey = "sk_test_51R1AfzQsK7W2R2yG8WVaLsvv1BRvqO4LKG8RAtZXhUYhgijhzjcETNftYFhFafv67fYfMTKJNkGEyMHRd2qxEajp00j2cVA5bx";

        // Obtener el ID de sesión desde la URL
        String sessionId = request.getParameter("session_id");

        System.out.println("Session ID recibido: " + sessionId); // <-- debug

        if (sessionId == null || sessionId.isEmpty()) {
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
            return;
        }

        try {
            // Obtener la sesión desde Stripe
            Session session = Session.retrieve(sessionId);

            System.out.println("Información de la sesión:");
            System.out.println("Cliente email: " + session.getCustomerEmail());
            System.out.println("Estado del pago: " + session.getPaymentStatus());
            System.out.println("Metadatos: " + session.getMetadata());

            String nombre = session.getMetadata().get("nombre");
            String apellido = session.getMetadata().get("apellido");
            String direccion = session.getMetadata().get("direccion");
            String telefono = session.getMetadata().get("telefono");
            String email = session.getMetadata().get("email");
            String idStripe = sessionId;

            // Crear la conexión a la base de datos
            ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
            Connection conexion = conector.getConexion();

            Cliente cliente = new Cliente(nombre,apellido,direccion,telefono,email,idStripe);

            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.guardarCliente(conexion, cliente);

            // Aquí ya puedes hacer el resto: guardar cliente, redirigir, etc.
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
        }
    }
}
