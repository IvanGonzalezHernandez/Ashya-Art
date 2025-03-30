package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.CursoDAO;
import com.ashyaart.ecommerce.modelo.Curso;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ivang
 */
public class WorkshopsServicesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
// Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        // Crear objetos DAO
        CursoDAO cursoDAO = new CursoDAO();


        // Obtener todos los cursos de la base de datos
        List<Curso> cursos = cursoDAO.obtenerTodosCursos(conexion);



        // Almacenar los cursos y las sesiones en el contexto de la aplicación
        getServletContext().setAttribute("cursos", cursos);


        // Redirigir a la JSP que va a mostrar los cursos y las sesiones
        RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/vistas/workshops-services.jsp");
        dispatcher.forward(request, response);

        // Cerrar la conexión a la base de datos
        try {
            if (conexion != null) {
                conexion.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
