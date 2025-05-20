package com.ashyaart.ecommerce.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectorBD {

    private Connection conexion = null;
    private String url;

    // Cambia esto para elegir el entorno: "azure" o "local"
    private final String entorno = "local"; // <-- cambiar a "azure" para conectar a azure

    public ConectorBD() {
        try {
            if (entorno.equalsIgnoreCase("azure")) {
                // Configuración para Azure SQL
                String servidor = "ashyaart.database.windows.net";
                String database = "ashya-art";
                String usuario = "ivanAdmin@ashyaart";
                String password = "FDWJ3@Zp@xF7QRp";

                url = "jdbc:sqlserver://" + servidor + ":1433;"
                        + "database=" + database + ";"
                        + "user=" + usuario + ";"
                        + "password=" + password + ";"
                        + "encrypt=true;"
                        + "trustServerCertificate=false;"
                        + "hostNameInCertificate=*.database.windows.net;"
                        + "loginTimeout=30;";

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conexion = DriverManager.getConnection(url);

            } else {
                // Configuración para MySQL local con driver 5
                String servidor = "localhost";
                String database = "ashya_art";
                String usuario = "root";
                String password = "";

                url = "jdbc:mysql://" + servidor + ":3306/" + database + "?useSSL=false";

                Class.forName("com.mysql.jdbc.Driver");
                conexion = DriverManager.getConnection(url, usuario, password);
            }

            System.out.println("Conexión establecida con éxito a: " + entorno);

        } catch (SQLException ex) {
            System.out.println("Error SQL: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            System.out.println("Error Driver: " + ex.getMessage());
        }
    }

    public Connection getConexion() {
        return conexion;
    }

    public void cerrarConexion() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
                System.out.println("Conexión cerrada correctamente.");
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar la conexión: " + ex.getMessage());
        }
    }
}
