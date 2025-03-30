/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.AdminDAO;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ivang
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Obtener el valor del botón
        String boton = request.getParameter("button");

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        // Únicamente recojo la sesion dado que se creará si las credenciales son correctas
        HttpSession session = request.getSession(false);

        switch (boton) {
            case "login":
                // Obtener el correo y la contraseña desde el formulario
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                AdminDAO admin = new AdminDAO();

                boolean esValido = admin.verificarAdministrador(conexion, email, password);
                if (esValido) {
                    // Iniciar sesión
                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("adminEmail", email);
                    //Redirigir al DashBoard
                    response.sendRedirect("jsp/vistas/dashboard.jsp");
                } else {
                    // Si las credenciales no son correctas, mostrar un mensaje de error
                    request.setAttribute("mensajeError", "Correo o contraseña incorrectos.");
                    // Redirigir de nuevo al login con el mensaje de error
                    request.getRequestDispatcher("jsp/vistas/login.jsp").forward(request, response);
                }
                break;
            case "logout":
                session.invalidate();
                response.sendRedirect("jsp/vistas/login.jsp");
                break;
        }

    }

}
