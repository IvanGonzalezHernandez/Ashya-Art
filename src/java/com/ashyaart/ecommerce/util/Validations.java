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

    public static boolean esFormularioCheckoutValido(String nombre, String apellido, String correo, String telefono, String direccion, boolean politicaAceptada) {
        if (nombre == null || nombre.trim().isEmpty()) {
            return false;
        }
        if (apellido == null || apellido.trim().isEmpty()) {
            return false;
        }
        if (correo == null || correo.trim().isEmpty() || !esEmailValido(correo)) {
            return false;
        }
        if (telefono == null || telefono.trim().isEmpty()) {
            return false;
        }
        if (direccion == null || direccion.trim().isEmpty()) {
            return false;
        }
        if (!politicaAceptada) {
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
