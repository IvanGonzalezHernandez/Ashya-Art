package com.ashyaart.ecommerce.dao;

import com.ashyaart.ecommerce.modelo.CursoFecha;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.modelo.Reserva;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CursosDAO {

    // Método para insertar un nuevo curso
    public boolean insertarCurso(Connection conexion, Cursos curso) {
        String sql = "INSERT INTO cursos (nombre, subtitulo, descripcion, precio, nivel, idioma, img) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            pstmt.setString(1, curso.getNombre());
            pstmt.setString(2, curso.getSubtitulo());
            pstmt.setString(3, curso.getDescripcion());
            pstmt.setDouble(4, curso.getPrecio());
            pstmt.setString(5, curso.getNivel());
            pstmt.setString(6, curso.getIdioma());
            pstmt.setString(7, curso.getImg()); // Se añade la imagen

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Método para obtener todos los cursos
    public List<Cursos> obtenerTodosLosCursos(Connection conexion) {
        List<Cursos> listaCursos = new ArrayList<>();
        String sql = "SELECT * FROM cursos";

        try (PreparedStatement pstmt = conexion.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Cursos curso = new Cursos(
                        rs.getInt("id_curso"),
                        rs.getString("nombre"),
                        rs.getString("subtitulo"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getString("nivel"),
                        rs.getString("idioma"),
                        rs.getString("img") // Se recupera la imagen
                );
                listaCursos.add(curso);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listaCursos;
    }

    // Método para asignar una fecha a un curso
    public boolean asignarFechaCurso(Connection conexion, int idCurso, Date fecha, String hora, int plazasDisponibles) {
        String sql = "INSERT INTO curso_fecha (id_curso, fecha, hora, plazas_disponibles) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idCurso);
            stmt.setDate(2, new java.sql.Date(fecha.getTime()));
            stmt.setString(3, hora);
            stmt.setInt(4, plazasDisponibles);

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Método para obtener los cursos con fechas asignadas
    public List<CursoFecha> obtenerCursosConFecha(Connection conexion) {
        List<CursoFecha> lista = new ArrayList<>();

        String sql = "SELECT c.id_curso, c.nombre, c.subtitulo, c.descripcion, c.precio, c.nivel, c.idioma, c.img, "
                + "f.fecha, f.hora, f.plazas_disponibles "
                + "FROM cursos c JOIN curso_fecha f ON c.id_curso = f.id_curso";

        try (PreparedStatement pstmt = conexion.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Cursos curso = new Cursos(
                        rs.getInt("id_curso"),
                        rs.getString("nombre"),
                        rs.getString("subtitulo"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getString("nivel"),
                        rs.getString("idioma"),
                        rs.getString("img") // Se recupera la imagen
                );

                String fecha = rs.getDate("fecha").toString();
                String hora = rs.getString("hora");
                int plazas = rs.getInt("plazas_disponibles");

                lista.add(new CursoFecha(fecha, hora, curso, plazas));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public void guardarReserva(Connection conexion, String fecha, String hora, String nombre, String email, int plazasReservadas) throws SQLException {
        // Consulta para obtener el idFecha según la fecha y la hora del curso
        String sqlObtenerIdFecha = "SELECT id_fecha FROM curso_fecha WHERE fecha = ? AND hora = ?";

        int idFecha = -1; // Variable para almacenar el idFecha recuperado

        // Obtener el idFecha
        try (PreparedStatement ps = conexion.prepareStatement(sqlObtenerIdFecha)) {
            ps.setString(1, fecha);  // Establecer la fecha
            ps.setString(2, hora);    // Establecer la hora

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idFecha = rs.getInt("id_fecha");
                }
            }
        }

        // Verificar si se encontró el idFecha
        if (idFecha == -1) {
            throw new SQLException("No se encontró la fecha y hora especificadas en la tabla curso_fecha.");
        }

        // Consulta para insertar la reserva en la tabla reservas
        String sqlInsertarReserva = "INSERT INTO reserva (id_fecha, nombre_usuario, email, plazas_reservadas, fecha_reserva) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP())";

        // Insertar la reserva
        try (PreparedStatement ps = conexion.prepareStatement(sqlInsertarReserva)) {
            ps.setInt(1, idFecha);            // id_fecha: el ID de la fecha obtenida
            ps.setString(2, nombre);          // nombre_usuario: nombre del usuario
            ps.setString(3, email);           // email: email del usuario
            ps.setInt(4, plazasReservadas);   // plazas_reservadas: el número de plazas reservadas
            ps.executeUpdate();               // Ejecutar la consulta
        }
    }

// Obtener todas las reservas
    public List<Reserva> obtenerReservas(Connection conexion) throws SQLException {
        List<Reserva> reservas = new ArrayList<>();
        // Asegúrate de que la consulta obtiene id_curso también
        String query = "SELECT r.id_reserva, cf.id_curso, r.nombre_usuario, r.email, r.plazas_reservadas, r.fecha_reserva, cf.fecha, cf.hora, c.nombre "
                + "FROM reserva r "
                + "JOIN curso_fecha cf ON r.id_fecha = cf.id_fecha "
                + "JOIN cursos c ON cf.id_curso = c.id_curso";

        try (PreparedStatement stmt = conexion.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                int idReserva = rs.getInt("id_reserva");
                int idCurso = rs.getInt("id_curso");
                String nombreUsuario = rs.getString("nombre_usuario");
                String email = rs.getString("email");
                int plazasReservadas = rs.getInt("plazas_reservadas");
                Timestamp fechaReserva = rs.getTimestamp("fecha_reserva");
                Date fechaCurso = rs.getDate("fecha");
                String horaCurso = rs.getString("hora");
                String nombreCurso = rs.getString("nombre"); // Obtener el nombre del curso

                // Crear la reserva con los datos obtenidos
                Reserva reserva = new Reserva(idReserva, idCurso, nombreUsuario, email, fechaReserva, plazasReservadas, fechaCurso, horaCurso, nombreCurso);
                reservas.add(reserva);
            }
        }
        return reservas;
    }

}
