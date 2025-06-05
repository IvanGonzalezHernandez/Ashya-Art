package com.ashyaart.ecommerce.dao;

import java.sql.*;
import java.util.*;

import com.ashyaart.ecommerce.modelo.Productos;

public class ProductosDAO {

    public void agregarProducto(Connection conexion, Productos producto) throws SQLException {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, stock, imagen, categoria) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setString(5, producto.getImagen());
            stmt.setString(6, producto.getCategoria());
            stmt.executeUpdate();
        }
    }

    public void eliminarProductoLogicamente(Connection conexion, int idProducto) throws SQLException {
        // Primero consultamos el producto actual
        String select = "SELECT nombre, descripcion, precio, stock, categoria FROM productos WHERE id_producto = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(select)) {
            stmt.setInt(1, idProducto);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Insertamos en productos_eliminados antes de eliminar
                String insert = "INSERT INTO productos_eliminados (nombre, descripcion, precio, stock, categoria) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conexion.prepareStatement(insert)) {
                    insertStmt.setString(1, rs.getString("nombre"));
                    insertStmt.setString(2, rs.getString("descripcion"));
                    insertStmt.setBigDecimal(3, rs.getBigDecimal("precio"));
                    insertStmt.setInt(4, rs.getInt("stock"));
                    insertStmt.setString(5, rs.getString("categoria"));
                    insertStmt.executeUpdate();
                }

                // Luego eliminamos el producto original
                String delete = "DELETE FROM productos WHERE id_producto = ?";
                try (PreparedStatement deleteStmt = conexion.prepareStatement(delete)) {
                    deleteStmt.setInt(1, idProducto);
                    deleteStmt.executeUpdate();
                }
            }
        }
    }

    public List<Productos> obtenerTodosProductos(Connection conexion) throws SQLException {
        List<Productos> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos ORDER BY id_producto";
        try (PreparedStatement stmt = conexion.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Productos p = new Productos();
                p.setId(rs.getInt("id_producto"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setPrecio(rs.getBigDecimal("precio"));
                p.setStock(rs.getInt("stock"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoria(rs.getString("categoria"));
                productos.add(p);
            }
        }
        return productos;
    }

    public int obtenerStockDisponible(Connection conexion, int idProducto) throws SQLException {
        String sql = "SELECT stock FROM productos WHERE id_producto = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idProducto);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("stock");
                } else {
                    return 0; // Si no se encuentra el producto, asumimos sin stock
                }
            }
        }
    }

}
