/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ashyaart.ecommerce.dao;

import com.ashyaart.ecommerce.modelo.Curso;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ivang
 */
public class CursoDAO {

    // Método para obtener todos los cursos
    public List<Curso> obtenerTodosCursos(java.sql.Connection conexion) {
        List<Curso> cursos = new ArrayList<>();
        String sql = "SELECT * FROM curso";

        try (Statement stmt = conexion.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Curso curso = new Curso(
                        rs.getInt("id_curso"),
                        rs.getString("nombre"),
                        rs.getString("descripcion"),
                        rs.getDouble("precio"),
                        rs.getString("imagen"),
                        rs.getString("subtitulo"),
                        rs.getString("nivel"),
                        rs.getString("duracion"),
                        rs.getString("piezas_creadas"),
                        rs.getString("idioma"),
                        rs.getString("localizacion")
                );
                cursos.add(curso);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cursos;
    }

}
