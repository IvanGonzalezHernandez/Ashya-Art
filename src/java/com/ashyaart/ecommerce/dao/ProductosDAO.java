package com.ashyaart.ecommerce.dao;

import java.sql.*;
import java.util.*;

import com.ashyaart.ecommerce.modelo.Productos;

public class ProductosDAO {

    public boolean insertarProducto(Connection conexion, Productos producto) {
        String sql = "INSERT INTO productos (nombre, descripcion, precio, stock, imagen, categoria) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, producto.getNombre());
            stmt.setString(2, producto.getDescripcion());
            stmt.setBigDecimal(3, producto.getPrecio());
            stmt.setInt(4, producto.getStock());
            stmt.setString(5, producto.getImagen());
            stmt.setString(6, producto.getCategoria());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarProductoLogicamente(Connection conexion, int idProducto) {
        String select = "SELECT nombre, descripcion, precio, stock, categoria FROM productos WHERE id_producto = ?";
        String insert = "INSERT INTO productos_eliminados (nombre, descripcion, precio, stock, categoria) VALUES (?, ?, ?, ?, ?)";
        String delete = "DELETE FROM productos WHERE id_producto = ?";

        try (PreparedStatement stmt = conexion.prepareStatement(select)) {
            stmt.setInt(1, idProducto);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                try (PreparedStatement insertStmt = conexion.prepareStatement(insert)) {
                    insertStmt.setString(1, rs.getString("nombre"));
                    insertStmt.setString(2, rs.getString("descripcion"));
                    insertStmt.setBigDecimal(3, rs.getBigDecimal("precio"));
                    insertStmt.setInt(4, rs.getInt("stock"));
                    insertStmt.setString(5, rs.getString("categoria"));
                    insertStmt.executeUpdate();
                }

                try (PreparedStatement deleteStmt = conexion.prepareStatement(delete)) {
                    deleteStmt.setInt(1, idProducto);
                    deleteStmt.executeUpdate();
                }

                return true; // Operación exitosa
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Algo falló
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

    public boolean actualizarProducto(Connection conexion, Productos producto) {
        String sql = "UPDATE productos SET nombre = ?, descripcion = ?, precio = ?, stock = ?, imagen = ?, categoria = ? WHERE id_producto = ?";
        try (PreparedStatement ps = conexion.prepareStatement(sql)) {
            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setBigDecimal(3, producto.getPrecio());
            ps.setInt(4, producto.getStock());
            ps.setString(5, producto.getImagen());
            ps.setString(6, producto.getCategoria());
            ps.setInt(7, producto.getId()); // Asegúrate que getId() da el valor de id_producto
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
