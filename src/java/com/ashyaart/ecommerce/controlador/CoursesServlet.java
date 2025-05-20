package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.modelo.CursoFecha;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CoursesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD();
        Connection conexion = conector.getConexion();

        // Obtener los cursos agrupados por fecha
        CursosDAO cursoDAO = new CursosDAO();
        List<CursoFecha> cursosPorFecha = cursoDAO.obtenerCursosConFecha(conexion);

        try (PrintWriter out = response.getWriter()) {
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{");

            // Iterar sobre los cursos y agregarlos al JSON
            for (CursoFecha dto : cursosPorFecha) {
                Cursos curso = dto.getCurso();
                String fecha = dto.getFecha();
                String hora = dto.getHora();

                // Escapar comillas en los campos de texto
                String nombreCurso = curso.getNombre().replace("\"", "\\\"");
                String descripcionCurso = curso.getDescripcion().replace("\"", "\\\"");

                jsonResponse.append("\"").append(fecha).append(" ").append(hora).append("\": {")
                        .append("\"id\": ").append(curso.getId()).append(", ")
                        .append("\"img\": \"").append(curso.getImg().replace("\n", "").replace("\r", "")).append("\", ")
                        .append("\"title\": \"").append(curso.getNombre()).append("\", ")
                        .append("\"desc\": \"").append(curso.getDescripcion()).append("\", ")
                        .append("\"price\": ").append(curso.getPrecio()).append(", ")
                        .append("\"time\": \"").append(hora).append("\", ")
                        .append("\"spots\": ").append(dto.getPlazasDisponibles()).append(", ")
                        .append("\"link\": \"/Ashya-Art/workshops\", ")
                        .append("\"date\": \"").append(fecha).append("\"")
                        .append("}, ");

            }

            // Eliminar la última coma extra
            if (jsonResponse.length() > 1) {
                jsonResponse.setLength(jsonResponse.length() - 2);
            }

            jsonResponse.append("}");

            // Enviar la respuesta JSON
            out.print(jsonResponse.toString());
        } finally {
            // Asegurarse de cerrar la conexión después de usarla
            try {
                if (conexion != null) {
                    conexion.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
