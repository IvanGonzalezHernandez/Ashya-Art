package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.Validations;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewsletterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("correo");
        String referer = request.getHeader("Referer");
        
        // Validar email
        if (email == null || email.isEmpty() || !Validations.esEmailValido(email)) {
            if (referer != null) {
                response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "error=Por+favor+introduce+un+email+válido");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=Por+favor+introduce+un+email+válido");
            }
            return;
        }
        
        ConectorBD conector = new ConectorBD();
        try (Connection conexion = conector.getConexion()) {
            ClienteDAO clienteDAO = new ClienteDAO();
            boolean exito = clienteDAO.insertarEmail(conexion, email); // suponiendo que tienes ese método
            
            if (exito) {
                if (referer != null) {
                    response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "exito=Email+registrado+correctamente");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?exito=Email+registrado+correctamente");
                }
            } else {
                if (referer != null) {
                    response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "error=Error+al+guardar+el+email");
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=Error+al+guardar+el+email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (referer != null) {
                response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "error=Error+de+base+de+datos");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=Error+de+base+de+datos");
            }
        }
    }
}
