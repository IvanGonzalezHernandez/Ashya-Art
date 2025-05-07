package com.ashyaart.ecommerce.util;

import java.util.UUID;

public class CodigoAleatorio {

    // Método estático para generar un código único aleatorio
    public static String generarCodigoAleatorio() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);  // Genera un código aleatorio de 10 caracteres
    }
}
