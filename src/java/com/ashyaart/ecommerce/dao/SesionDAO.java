package com.ashyaart.ecommerce.dao;

import com.ashyaart.ecommerce.modelo.Sesion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SesionDAO {

    // Método para obtener todas las sesiones
    public List<Sesion> obtenerTodasSesiones(java.sql.Connection conexion) {
        List<Sesion> sesiones = new ArrayList<>();
        String sql = "SELECT * FROM sesiones"; // Asume que la tabla se llama 'sesiones'

        try (Statement stmt = conexion.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Sesion sesion = new Sesion(
                        rs.getInt("id_sesion"),
                        rs.getString("fecha"),
                        rs.getString("hora"),
                        rs.getInt("plazas_disponibles")
                );
                sesiones.add(sesion);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sesiones;
    }
}
