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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // Método para obtener un curso por su ID
    public Cursos obtenerCursoPorId(Connection conexion, int idCurso) {
        String sql = "SELECT * FROM cursos WHERE id_curso = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idCurso);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Cursos(
                            rs.getInt("id_curso"),
                            rs.getString("nombre"),
                            rs.getString("subtitulo"),
                            rs.getString("descripcion"),
                            rs.getDouble("precio"),
                            rs.getString("nivel"),
                            rs.getString("idioma"),
                            rs.getString("img") // Se recupera la imagen
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Retorna null si no se encuentra el curso
    }

    // Método para insertar un curso en la tabla de cursos eliminados
    public boolean insertarCursoEliminado(Connection conexion, Cursos curso) {
        String sql = "INSERT INTO cursos_eliminados (id, nombre, subtitulo, descripcion, precio, nivel, idioma, fecha_eliminacion)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, curso.getId());
            stmt.setString(2, curso.getNombre());
            stmt.setString(3, curso.getSubtitulo());
            stmt.setString(4, curso.getDescripcion());
            stmt.setDouble(5, curso.getPrecio());
            stmt.setString(6, curso.getNivel());
            stmt.setString(7, curso.getIdioma());

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0; // Si se insertaron filas, la operación fue exitosa
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // En caso de error, devolvemos false
    }

    // Método para eliminar un curso de la tabla cursos
    public boolean eliminarCurso(Connection conexion, int idCurso) {
        String sql = "DELETE FROM cursos WHERE id_curso = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idCurso);

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0; // Si se eliminaron filas, la operación fue exitosa
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // En caso de error, devolvemos false
    }

    // Método para actualizar un curso en la base de datos
    public boolean actualizarCurso(Connection conexion, Cursos curso) {
        String sql = "UPDATE cursos SET nombre = ?, subtitulo = ?, descripcion = ?, precio = ?, nivel = ?, idioma = ?, img = ? WHERE id_curso = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, curso.getNombre());
            stmt.setString(2, curso.getSubtitulo());
            stmt.setString(3, curso.getDescripcion());
            stmt.setDouble(4, curso.getPrecio());
            stmt.setString(5, curso.getNivel());
            stmt.setString(6, curso.getIdioma());
            stmt.setString(7, curso.getImg());
            stmt.setInt(8, curso.getId());

            int filasAfectadas = stmt.executeUpdate();
            return filasAfectadas > 0;  // Retorna true si se actualizó al menos una fila
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Retorna false si ocurrió un error
        }
    }

    public List<Cursos> obtenerCursosPorEmail(Connection conexion, String email) throws SQLException {
        List<Cursos> cursos = new ArrayList<>();

        // Consulta para obtener los cursos reservados por el usuario filtrando por email
        String query = "SELECT c.id_curso, c.nombre, c.subtitulo, c.descripcion, c.precio, c.nivel, c.idioma, c.img "
                + "FROM reserva r "
                + "JOIN curso_fecha cf ON r.id_fecha = cf.id_fecha "
                + "JOIN cursos c ON cf.id_curso = c.id_curso "
                + "WHERE r.email = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(query)) {
            stmt.setString(1, email);  // Establecer el email en la consulta
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    int idCurso = rs.getInt("id_curso");
                    String nombre = rs.getString("nombre");
                    String subtitulo = rs.getString("subtitulo");
                    String descripcion = rs.getString("descripcion");
                    double precio = rs.getDouble("precio");
                    String nivel = rs.getString("nivel");
                    String idioma = rs.getString("idioma");
                    String img = rs.getString("img");

                    // Crear el objeto Curso con los datos obtenidos
                    Cursos curso = new Cursos(idCurso, nombre, subtitulo, descripcion, precio, nivel, idioma, img);
                    cursos.add(curso);
                }
            }
        }
        return cursos;
    }

    public List<Map<String, Object>> obtenerReservasPorMes(Connection conexion) throws SQLException {
        List<Map<String, Object>> resultados = new ArrayList<>();

        String sql = "SELECT DATE_FORMAT(fecha_reserva, '%Y-%m') AS mes, SUM(plazas_reservadas) AS total "
                + "FROM reserva GROUP BY mes ORDER BY mes";

        try (PreparedStatement ps = conexion.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> fila = new HashMap<>();
                fila.put("mes", rs.getString("mes"));
                fila.put("total", rs.getInt("total"));
                resultados.add(fila);
            }
        }

        return resultados;
    }

    public int obtenerPlazasDisponibles(Connection conexion, int idCurso, String fecha, String hora) {
        int plazas = 0;
        String sql = "SELECT plazas_disponibles FROM curso_fecha WHERE id_curso = ? AND fecha = ? AND hora = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idCurso);
            stmt.setString(2, fecha);
            stmt.setString(3, hora);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                plazas = rs.getInt("plazas_disponibles");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return plazas;
    }

    public void restarPlazasDisponibles(Connection conexion, String fecha, String hora, int plazasARestar) throws SQLException {
        String sql = "UPDATE curso_fecha SET plazas_disponibles = plazas_disponibles - ? WHERE fecha = ? AND hora = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, plazasARestar);
            stmt.setString(2, fecha);
            stmt.setString(3, hora);
            stmt.executeUpdate();
        }
    }

}
