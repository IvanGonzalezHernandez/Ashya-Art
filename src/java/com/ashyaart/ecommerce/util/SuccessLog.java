package com.ashyaart.ecommerce.util;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;

public class SuccessLog {
    
    // Ruta absoluta del archivo donde se guardarán los accesos del administrador.
    private static final String LOG_FILE = "C:/xampp/tomcat/logs/success.log";
    
    // Método estático para registrar la compra de un producto.
    public static void logPurchase(String productName, int price, int quantity) {
        try (FileWriter writer = new FileWriter(LOG_FILE, true)) {
            // Se crea un log con la fecha/hora actual, nombre del producto, precio y cantidad.
            String log = String.format("[%s] Producto comprado: %s, Precio: %d, Cantidad: %d%n",
                    LocalDateTime.now(), productName, price, quantity);

            // Se escribe la línea en el archivo (modo append).
            writer.write(log);
        } catch (IOException e) {
            // En caso de error al escribir, se imprime la traza del error.
            e.printStackTrace();
        }
    }
    
}
