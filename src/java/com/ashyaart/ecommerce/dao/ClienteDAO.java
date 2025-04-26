package com.ashyaart.ecommerce.dao;

import com.ashyaart.ecommerce.modelo.Cliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    // Método para guardar un cliente
    public boolean guardarCliente(Connection conexion, Cliente cliente) {
        String sql = "INSERT IGNORE INTO clientes (nombre, apellido, direccion, telefono, email, idStripe) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, cliente.getNombre());  // Asignar nombre
            stmt.setString(2, cliente.getApellido()); // Asignar apellido
            stmt.setString(3, cliente.getDireccion()); // Asignar dirección
            stmt.setString(4, cliente.getTelefono()); // Asignar teléfono
            stmt.setString(5, cliente.getEmail()); // Asignar email
            stmt.setString(6, cliente.getIdStripe()); // Asignar ID de Stripe

            int filas = stmt.executeUpdate(); // Ejecutar la inserción
            return filas > 0; // Retornar true si la inserción fue exitosa

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Retornar false en caso de error
        }
    }

    public List<Cliente> obtenerClientes(Connection conexion) {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes";

        try (PreparedStatement stmt = conexion.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setEmail(rs.getString("email"));
                cliente.setIdStripe(rs.getString("idStripe"));
                lista.add(cliente);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
}
