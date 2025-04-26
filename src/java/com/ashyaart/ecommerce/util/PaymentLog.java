package com.ashyaart.ecommerce.util;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public class PaymentLog {
    
    // Ruta absoluta del archivo donde se guardarán los accesos del administrador.
    private static final String LOG_FILE_SUCCESS = "C:/xampp/tomcat/logs/success.log";
    
        // Ruta absoluta del archivo donde se guardarán los accesos del administrador.
    private static final String LOG_FILE_CANCEL = "C:/xampp/tomcat/logs/cancel.log";
    
    // Método para registrar los datos del cliente
    public static void logClienteSuccess(String nombre, String apellido, String direccion, String telefono, String email, String idStripe) {
        try (FileWriter writer = new FileWriter(LOG_FILE_SUCCESS, true)) {
            String log = String.format("[%s] CLIENTE PAGÓ: Nombre: %s %s, Dirección: %s, Teléfono: %s, Email: %s, ID Stripe: %s%n",
                    LocalDateTime.now(), nombre, apellido, direccion, telefono, email, idStripe);
            writer.write(log);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
        // Método para registrar los datos del cliente
    public static void logClienteCancel(String nombre, String apellido, String direccion, String telefono, String email, String idStripe) {
        try (FileWriter writer = new FileWriter(LOG_FILE_CANCEL, true)) {
            String log = String.format("[%s] CLIENTE NO PAGÓ: Nombre: %s %s, Dirección: %s, Teléfono: %s, Email: %s, ID Stripe: %s%n",
                    LocalDateTime.now(), nombre, apellido, direccion, telefono, email, idStripe);
            writer.write(log);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
}
