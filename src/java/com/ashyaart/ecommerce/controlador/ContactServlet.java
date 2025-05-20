package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.util.EmailSender;
import com.ashyaart.ecommerce.util.Validations;
import java.io.IOException;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("name");
        String email = request.getParameter("email");
        String mensaje = request.getParameter("message");
        String referer = request.getHeader("Referer");

        // Validación de campos
        if (!Validations.esFormularioContactoValido(nombre, email, mensaje)) {
            if (referer != null) {
                response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "error=Por+favor+rellena+todos+los+campos+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=Por+favor+rellena+todos+los+campos+correctamente");
            }
            return;
        }

        try {
            EmailSender.enviarMensajeContacto(nombre, email, mensaje);

            if (referer != null) {
                response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "exito=Mensaje+enviado+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?exito=Mensaje+enviado+correctamente");
            }

        } catch (MessagingException e) {
            e.printStackTrace();

            if (referer != null) {
                response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "error=No+se+pudo+enviar+el+mensaje");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=No+se+pudo+enviar+el+mensaje");
            }
        }
    }
}
