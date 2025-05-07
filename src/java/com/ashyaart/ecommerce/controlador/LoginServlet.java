package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.AdminDAO;
import com.ashyaart.ecommerce.util.AdminLog;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.Hash;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String boton = request.getParameter("button");

        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        HttpSession session = request.getSession(false);

        switch (boton) {
            case "login":
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                String hashedPassword = null;
                try {
                    hashedPassword = Hash.hashPassword(password);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("mensajeError", "Error al procesar la contraseña.");
                    request.getRequestDispatcher("jsp/vistas/login.jsp").forward(request, response);
                    return;
                }

                AdminDAO admin = new AdminDAO();
                boolean esValido = admin.verificarAdministrador(conexion, email, hashedPassword);

                if (esValido) {
                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("adminEmail", email);

                    String ipAddress = request.getRemoteAddr();
                    AdminLog.logAccess(email, ipAddress);

                    response.sendRedirect("jsp/vistas/dashboard.jsp");
                } else {
                    request.setAttribute("mensajeError", "Correo o contraseña incorrectos.");
                    request.getRequestDispatcher("jsp/vistas/login.jsp").forward(request, response);
                }
                break;

            case "logout":
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("jsp/vistas/login.jsp");
                break;
        }
    }
}
