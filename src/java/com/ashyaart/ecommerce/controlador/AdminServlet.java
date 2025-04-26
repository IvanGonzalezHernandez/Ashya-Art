package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.modelo.Reserva;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.google.gson.Gson;

import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        // Obtener el tipo de datos solicitado, por ejemplo, "clientes", "cursos" o "reservas"
        String tipo = request.getParameter("tipo");

        // Responder dependiendo del tipo de datos solicitado
        if ("clientes".equals(tipo)) {
            // Obtener la lista de clientes
            ClienteDAO clienteDAO = new ClienteDAO();
            List<Cliente> listaClientes = clienteDAO.obtenerClientes(conexion);

            // Convertir la lista de clientes a JSON
            Gson gson = new Gson();
            String json = gson.toJson(listaClientes);

            // Enviar la respuesta con los datos de clientes en formato JSON
            response.getWriter().write(json);

        } else if ("cursos".equals(tipo)) {
            // Obtener la lista de cursos
            CursosDAO cursosDAO = new CursosDAO();
            List<Cursos> listaCursos = cursosDAO.obtenerTodosLosCursos(conexion);

            // Convertir la lista de cursos a JSON
            Gson gson = new Gson();
            String json = gson.toJson(listaCursos);

            // Enviar la respuesta con los datos de cursos en formato JSON
            response.getWriter().write(json);

        } else if ("reservas".equals(tipo)) {
            // Obtener la lista de reservas
            CursosDAO reservaDAO = new CursosDAO();
            List<Reserva> listaReservas = null;
            try {
                listaReservas = reservaDAO.obtenerReservas(conexion);
            } catch (SQLException ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            // Convertir la lista de reservas a JSON
            Gson gson = new Gson();
            String json = gson.toJson(listaReservas);

            // Enviar la respuesta con los datos de reservas en formato JSON
            response.getWriter().write(json);

        } else {
            // Si el parámetro tipo no es válido, enviar un error
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Tipo de datos no válido\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        // Lógica para manejar la acción del formulario
        String action = request.getParameter("action");

        if ("insertarCurso".equals(action)) {
            // Recoger parámetros del formulario
            String nombre = request.getParameter("nombre");
            String subtitulo = request.getParameter("subtitulo");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String nivel = request.getParameter("nivel");
            String idioma = request.getParameter("idioma");
            String img = request.getParameter("img"); // Nueva propiedad

            // Crear el objeto curso
            Cursos curso = new Cursos(nombre, subtitulo, descripcion, precio, nivel, idioma, img);
            CursosDAO cursosDAO = new CursosDAO();
            boolean insertado = cursosDAO.insertarCurso(conexion, curso);

            // Redirigir a la página correspondiente con un mensaje
            if (insertado) {
                response.sendRedirect("jsp/vistas/dashboard.jsp?mensaje=Curso+creado+correctamente");
            } else {
                response.sendRedirect("jsp/vistas/dashboard.jsp?error=No+se+pudo+crear+el+curso");
            }
            return;

        } else if ("insertarFechaCurso".equals(action)) {
            // Recoger parámetros del formulario para asignar fecha al curso
            int idCurso = Integer.parseInt(request.getParameter("id_curso"));
            Date fecha = Date.valueOf(request.getParameter("fecha"));
            int plazasDisponibles = Integer.parseInt(request.getParameter("plazas_disponibles"));
            String hora = request.getParameter("hora");

            // Crear el objeto CursoDAO
            CursosDAO cursosDAO = new CursosDAO();
            boolean fechaAsignada = cursosDAO.asignarFechaCurso(conexion, idCurso, fecha, hora, plazasDisponibles);

            // Redirigir con un mensaje dependiendo de si la fecha fue asignada correctamente
            if (fechaAsignada) {
                response.sendRedirect("jsp/vistas/dashboard.jsp?mensaje=Fecha+asignada+correctamente");
            } else {
                response.sendRedirect("jsp/vistas/dashboard.jsp?error=No+se+pudo+asignar+la+fecha");
            }
            return;
        } else {
            // Otra lógica según el tipo de acción
            response.sendRedirect("jsp/vistas/dashboard.jsp?error=Acción+no+válida");
            return;
        }
    }
}
