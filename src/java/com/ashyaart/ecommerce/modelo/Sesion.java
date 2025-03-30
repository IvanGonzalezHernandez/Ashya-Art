package com.ashyaart.ecommerce.modelo;

public class Sesion {

    private int idSesion;
    private String fecha;
    private String hora;
    private int plazasDisponibles;

    // Constructor
    public Sesion(int idSesion, String fecha, String hora, int plazasDisponibles) {
        this.idSesion = idSesion;
        this.fecha = fecha;
        this.hora = hora;
        this.plazasDisponibles = plazasDisponibles;
    }

    // Getters y Setters
    public int getIdSesion() {
        return idSesion;
    }

    public void setIdSesion(int idSesion) {
        this.idSesion = idSesion;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public int getPlazasDisponibles() {
        return plazasDisponibles;
    }

    public void setPlazasDisponibles(int plazasDisponibles) {
        this.plazasDisponibles = plazasDisponibles;
    }


}
