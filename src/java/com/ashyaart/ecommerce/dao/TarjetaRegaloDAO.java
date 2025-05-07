package com.ashyaart.ecommerce.dao;

import com.ashyaart.ecommerce.modelo.TarjetaRegalo;
import com.ashyaart.ecommerce.util.CodigoAleatorio;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class TarjetaRegaloDAO {

    // Método para guardar una plantilla de tarjeta regalo
    public boolean insertarPlantillaTarjeta(Connection conexion, TarjetaRegalo tarjeta) {
        // Actualiza la consulta SQL para incluir el campo "imagen"
        String sql = "INSERT INTO tarjetas_regalo (id_cupon_stripe, precio, imagen, id_referencia) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            // Primero insertamos el id_cupon_stripe, luego el precio y la ruta de la imagen
            stmt.setString(1, tarjeta.getIdCuponStripe());  // id_cupon_stripe
            stmt.setDouble(2, tarjeta.getPrecio());         // precio
            stmt.setString(3, tarjeta.getImagen());         // ruta de la imagen
            stmt.setString(4, tarjeta.getIdReferenciaCuponStripe());

            int filas = stmt.executeUpdate();
            return filas > 0;  // Si se insertaron filas, devuelve true

        } catch (SQLException e) {
            e.printStackTrace();  // En caso de error, imprime la traza del error
            return false;  // Si ocurre un error, devuelve false
        }
    }

    public List<TarjetaRegalo> obtenerTodasLasTarjetasRegalo(Connection conexion) {
        List<TarjetaRegalo> tarjetasRegalo = new ArrayList<>();
        String sql = "SELECT * FROM tarjetas_regalo";

        try (PreparedStatement stmt = conexion.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Asegúrate de que 'id_referencia_cupon_stripe' esté en la consulta
                TarjetaRegalo tarjeta = new TarjetaRegalo(
                        rs.getInt("id"),
                        rs.getString("id_cupon_stripe"),
                        rs.getDouble("precio"),
                        rs.getTimestamp("fecha_creacion"),
                        rs.getString("imagen"),
                        rs.getString("id_referencia") // Recuperamos el nuevo campo
                );
                tarjetasRegalo.add(tarjeta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tarjetasRegalo;
    }

    public boolean guardarTarjetaRegalo(Connection conexion, String codigo, String nombreTarjeta, String emailCliente, double precio, String idReferencia) throws SQLException {
        // Obtener el id_tarjeta basado en el precio
        String idTarjeta = obtenerIdTarjetaPorPrecio(conexion, precio);  // Pasar el precio en lugar del nombre

        if (idTarjeta == null) {
            // Si no se encuentra el id, manejarlo (por ejemplo, lanzar una excepción o retornar false)
            System.err.println("Tarjeta no encontrada para el precio proporcionado.");
            return false;
        }

        // Obtener la fecha y hora actuales
        LocalDateTime now = LocalDateTime.now(); // Fecha y hora actuales
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String fechaCompra = now.format(formatter); // Convertir a String en el formato adecuado para la base de datos

        String sql = "INSERT INTO tarjeta_regalo_compra (codigo, id_tarjeta, id_cliente, canjeada, fecha_compra, fecha_canjeo, id_referencia) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {

            stmt.setString(1, codigo);               // Establecer el código generado
            stmt.setString(2, idTarjeta);            // Usar el id de la tarjeta obtenido
            stmt.setString(3, emailCliente);         // Usar el correo electrónico como id_cliente
            stmt.setInt(4, 0);                       // La tarjeta no está canjeada (valor predeterminado)
            stmt.setString(5, fechaCompra);          // Fecha de compra
            stmt.setNull(6, java.sql.Types.TIMESTAMP); // Fecha de canjeo está inicialmente en NULL
            stmt.setString(7, idReferencia);         // Insertar el id_referencia

            int filasInsertadas = stmt.executeUpdate();
            return filasInsertadas > 0;  // Retorna true si se insertó correctamente
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Si ocurre algún error, retornamos false
        }
    }

    public String obtenerIdTarjetaPorPrecio(Connection conexion, double precio) throws SQLException {
        String sql = "SELECT id FROM tarjetas_regalo WHERE precio = ?";  // Cambié la condición a precio

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setDouble(1, precio);  // Usar el precio en lugar del nombre de la tarjeta
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("id");  // Retorna el ID de la tarjeta
                } else {
                    // Si no se encuentra la tarjeta, puedes manejarlo como un error o retornar null
                    return null;
                }
            }
        }
    }

    public String obtenerIdReferenciaPorIdCupon(Connection conexion, double precio) {
        String idReferencia = null;
        String sql = "SELECT id_referencia FROM tarjetas_regalo WHERE precio = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setDouble(1, precio);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    idReferencia = rs.getString("id_referencia");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return idReferencia;
    }

    public boolean actualizarEstadoTarjeta(Connection conexion, String codigo) {
        String sql = "UPDATE tarjeta_regalo_compra SET canjeada = 1, fecha_canjeo = CURRENT_TIMESTAMP WHERE codigo = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, codigo);

            int filasActualizadas = stmt.executeUpdate();
            return filasActualizadas > 0; // Devuelve true si al menos una fila fue actualizada
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
