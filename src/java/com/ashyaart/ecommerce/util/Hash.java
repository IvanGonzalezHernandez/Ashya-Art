/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ashyaart.ecommerce.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author ivang
 */
public class Hash {

    // Método para hacer hash de la contraseña
    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(password.getBytes());

        // Convertimos el hash a una cadena hexadecimal
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            hexString.append(String.format("%02x", b));
        }

        return hexString.toString();
    }

}
