package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.dao.CursoDAO;
import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.modelo.ProductoCarrito;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.EmailSender;
import com.ashyaart.ecommerce.util.PaymentLog;
import com.google.gson.Gson;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

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

            // Extraer los productos desde la metadata
            String productosJson = session.getMetadata().get("productos");

            Gson gson = new Gson();
            ProductoCarrito[] productosArray = gson.fromJson(productosJson, ProductoCarrito[].class);

            String nombre = session.getMetadata().get("nombre");
            String apellido = session.getMetadata().get("apellido");
            String direccion = session.getMetadata().get("direccion");
            String telefono = session.getMetadata().get("telefono");
            String email = session.getMetadata().get("email");
            String idStripe = sessionId;

            Cliente cliente = new Cliente(nombre, apellido, direccion, telefono, email, idStripe);

            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.guardarCliente(conexion, cliente);

            // Aquí puedes guardar las reservas basándote en los productos
            CursosDAO cursoDAO = new CursosDAO();
            for (ProductoCarrito producto : productosArray) {
                // En este caso, puedes obtener la fecha y hora del producto y hacer la reserva
                String fecha = producto.getFecha(); // Asumiendo que el producto tiene la fecha de reserva
                String hora = producto.getHora();   // Asumiendo que el producto tiene la hora de reserva
                int plazasReservadas = producto.getCantidad(); // Usando la cantidad como plazas reservadas

                // Llamamos al método de guardarReserva que usaste
                cursoDAO.guardarReserva(conexion, fecha, hora, nombre, email, plazasReservadas);
            }

            // Log para registrar cada producto comprado en success.log
            PaymentLog.logClienteSuccess(nombre, apellido, direccion, telefono, email, idStripe);

            // Enviar email de confirmación
            try {
                EmailSender.enviarCorreoConfirmacion(email, nombre, Arrays.asList(productosArray));
            } catch (Exception e) {
                System.err.println("Error al enviar el correo de confirmación: " + e.getMessage());
            }

            // Redirigir a la vista de éxito
            response.sendRedirect("/Ashya-Art/jsp/vistas/success.jsp");

            // Aquí ya puedes hacer el resto: guardar cliente, redirigir, etc.
        } catch (StripeException e) {
            e.printStackTrace();
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(SuccessServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
