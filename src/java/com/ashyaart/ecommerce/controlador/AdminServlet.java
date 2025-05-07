package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.AdminDAO;
import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.dao.TarjetaRegaloDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.modelo.Reserva;
import com.ashyaart.ecommerce.modelo.TarjetaRegalo;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.Hash;
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

        } else if ("cursosCliente".equals(tipo)) {
            String email = request.getParameter("email");

            CursosDAO cursosDAO = new CursosDAO();
            List<Cursos> cursosCliente = null;
            try {
                cursosCliente = cursosDAO.obtenerCursosPorEmail(conexion, email);
            } catch (SQLException ex) {
                Logger.getLogger(AdminServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Gson gson = new Gson();
            String json = gson.toJson(cursosCliente);

            response.setContentType("application/json");
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
        } else if ("tarjetas".equals(tipo)) {
            // Obtener la lista de tarjetas regalo
            TarjetaRegaloDAO tarjetaDAO = new TarjetaRegaloDAO();
            List<TarjetaRegalo> listaTarjetas = tarjetaDAO.obtenerTodasLasTarjetasRegalo(conexion);

            // Convertir la lista a JSON
            Gson gson = new Gson();
            String json = gson.toJson(listaTarjetas);

            // Enviar la respuesta
            response.getWriter().write(json);
        } else {
            // Si el parámetro tipo no es válido, enviar un error
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Tipo de datos no válido\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        // Recoger la acción del formulario
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

            // Crear el objeto Curso
            Cursos curso = new Cursos(nombre, subtitulo, descripcion, precio, nivel, idioma, img);
            CursosDAO cursosDAO = new CursosDAO();
            boolean insertado = cursosDAO.insertarCurso(conexion, curso);

            // Redirigir según el resultado
            if (insertado) {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Curso+creado+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudo+crear+el+curso");
            }

        } else if ("insertarFechaCurso".equals(action)) {
            // Recoger parámetros para asignar fecha
            int idCurso = Integer.parseInt(request.getParameter("id_curso"));
            Date fecha = Date.valueOf(request.getParameter("fecha"));
            int plazasDisponibles = Integer.parseInt(request.getParameter("plazas_disponibles"));
            String hora = request.getParameter("hora");

            CursosDAO cursosDAO = new CursosDAO();
            boolean fechaAsignada = cursosDAO.asignarFechaCurso(conexion, idCurso, fecha, hora, plazasDisponibles);

            if (fechaAsignada) {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Fecha+asignada+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudo+asignar+la+fecha");
            }

        } else if ("eliminarCurso".equals(action)) {
            // Recoger el ID del curso a eliminar
            int idCurso = Integer.parseInt(request.getParameter("id"));

            CursosDAO cursosDAO = new CursosDAO();
            Cursos cursoEliminado = cursosDAO.obtenerCursoPorId(conexion, idCurso);
            cursosDAO.insertarCursoEliminado(conexion, cursoEliminado);
            boolean eliminado = cursosDAO.eliminarCurso(conexion, idCurso);

            if (eliminado) {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Curso+eliminado+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudo+eliminar+el+curso");
            }

        } else if ("cambiarContrasena".equals(action)) {

            String email = request.getParameter("email");
            String nuevaPassword = request.getParameter("nuevaPassword");
            String confirmarPassword = request.getParameter("confirmarPassword");

            if (nuevaPassword != null && nuevaPassword.equals(confirmarPassword)) {
                try {
                    String hashedPassword = Hash.hashPassword(nuevaPassword); // << Aquí haces el hash

                    AdminDAO adminDAO = new AdminDAO();
                    boolean actualizado = adminDAO.actualizarPasswordPorEmail(conexion, email, hashedPassword); // << Usas el hash

                    if (actualizado) {
                        response.sendRedirect("jsp/vistas/dashboard.jsp?mensaje=Contraseña+actualizada+correctamente");
                    } else {
                        response.sendRedirect("jsp/vistas/dashboard.jsp?error=No+se+pudo+actualizar+la+contraseña");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("jsp/vistas/dashboard.jsp?error=Error+al+hashear+la+contraseña");
                }
            } else {
                response.sendRedirect("jsp/vistas/dashboard.jsp?error=Las+contraseñas+no+coinciden");
            }
        } else if ("editarCurso".equals(action)) {
            // Recoger los parámetros del formulario para editar el curso
            int idCurso = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String subtitulo = request.getParameter("subtitulo");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String nivel = request.getParameter("nivel");
            String idioma = request.getParameter("idioma");
            String img = request.getParameter("img");

            // Crear el objeto Curso con los datos del formulario
            Cursos curso = new Cursos(idCurso, nombre, subtitulo, descripcion, precio, nivel, idioma, img);
            CursosDAO cursosDAO = new CursosDAO();
            boolean actualizado = cursosDAO.actualizarCurso(conexion, curso);

            // Redirigir según el resultado
            if (actualizado) {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Curso+actualizado+correctamente");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudo+actualizar+el+curso");
            }
        } else {
            // Acción no válida
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=Accion+no+valida");
        }
    }

}
