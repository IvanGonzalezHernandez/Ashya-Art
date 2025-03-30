/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ashyaart.ecommerce.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ivang
 */
public class AdminDAO {

    // Método para verificar si existe un administrador con el correo y la contraseña proporcionados
    public boolean verificarAdministrador(java.sql.Connection conexion, String email, String password) {
        String sql = "SELECT * FROM administrador WHERE email = ? AND password = ?";  // Consulta para verificar las credenciales

        try (PreparedStatement pstmt = conexion.prepareStatement(sql)) {
            // Establecer los parámetros de la consulta
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            // Ejecutar la consulta
            ResultSet rs = pstmt.executeQuery();

            // Si la consulta devuelve algún resultado, significa que las credenciales son correctas
            if (rs.next()) {
                return true;  // El administrador existe
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // El administrador no existe o las credenciales no coinciden
    }

}
