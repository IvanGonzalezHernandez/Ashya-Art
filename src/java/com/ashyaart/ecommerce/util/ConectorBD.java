package com.ashyaart.ecommerce.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectorBD {

    private Connection conexion = null;
    private String servidor = "localhost"; // Dirección del servidor de MySQL
    private String database = "ashya_art"; // Nombre de la base de datos
    private String usuario = "root"; // Nombre de usuario de la base de datos
    private String password = ""; // Contraseña del usuario de la base de datos
    private String url = "jdbc:mysql://" + servidor + "/" + database; // URL de conexión

    public ConectorBD(String servidor, String database, String usuario, String password) {
        try {
            this.servidor = servidor;
            this.database = database;
            this.url = "jdbc:mysql://" + servidor + "/" + database;
            Class.forName("com.mysql.jdbc.Driver"); // Cargar el driver de MySQL
            conexion = DriverManager.getConnection(url, usuario, password); // Establecer la conexión
            System.out.println("Conexion a Base de Datos " + url + " ... Ok"); // Imprimir mensaje de éxito
        } catch (SQLException ex) {
            System.out.println(ex); // Imprimir errores de SQL
        } catch (ClassNotFoundException ex) {
            System.out.println(ex); // Imprimir errores si no se encuentra la clase del driver
        }
    }

    public Connection getConexion() {
        return conexion; // Devuelve el objeto Connection
    }

    public void cerrarConexion() {
        try {
            conexion.close(); // Cierra la conexión
            System.out.println("Cerrando conexion a " + url + " ... Ok"); // Imprimir mensaje de éxito
        } catch (SQLException ex) {
            System.out.println(ex); // Imprimir errores de SQL
        }
    }
}