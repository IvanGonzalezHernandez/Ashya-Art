/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ashyaart.ecommerce.util;

/**
 *
 * @author ivang
 */
public class Validations {

    public static boolean esFormularioContactoValido(String nombre, String email, String mensaje) {
        if (nombre == null || nombre.trim().isEmpty()) {
            return false;
        }
        if (email == null || email.trim().isEmpty() || !esEmailValido(email)) {
            return false;
        }
        if (mensaje == null || mensaje.trim().isEmpty()) {
            return false;
        }

        return true;
    }

    public static boolean esEmailValido(String email) {
        // Expresión regular simple para validar un email
        String regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email.matches(regex);
    }

}
