package com.ashyaart.ecommerce.util;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public class AdminLog {

    // Ruta absoluta del archivo donde se guardarán los accesos del administrador.
    private static final String LOG_FILE = "C:/xampp/tomcat/logs/admin_access.log";

    // Método estático para registrar el acceso del admin.
    public static void logAccess(String username, String ipAddress) {
        try (FileWriter writer = new FileWriter(LOG_FILE, true)) {
            // Se crea un log con la fecha/hora actual, usuario e IP.
            String log = String.format("[%s] Acceso de admin: %s desde IP: %s%n",
                    LocalDateTime.now(), username, ipAddress);

            // Se escribe la línea en el archivo (modo append).
            writer.write(log);
        } catch (IOException e) {
            // En caso de error al escribir, se imprime la traza del error.
            e.printStackTrace();
        }
    }
}
