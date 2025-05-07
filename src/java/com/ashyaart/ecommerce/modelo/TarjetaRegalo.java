package com.ashyaart.ecommerce.modelo;

import java.sql.Timestamp;

public class TarjetaRegalo {

    private int id;
    private String idCuponStripe;
    private double precio; // Precio de la tarjeta
    private Timestamp fechaCreacion;
    private String imagen; // Nueva propiedad para la ruta de la imagen
    private String idReferenciaCuponStripe; // Nueva propiedad para el id de referencia del cupon

    // Constructor
    public TarjetaRegalo(int id, String idCuponStripe, double precio, Timestamp fechaCreacion, String imagen, String idReferenciaCuponStripe) {
        this.id = id;
        this.idCuponStripe = idCuponStripe;
        this.precio = precio;
        this.fechaCreacion = fechaCreacion;
        this.imagen = imagen;
        this.idReferenciaCuponStripe = idReferenciaCuponStripe; // Asignamos el id de referencia
    }

    // Constructor sin ID (para insertar una nueva tarjeta)
    public TarjetaRegalo(String idCuponStripe, double precio, String imagen, String idReferenciaCuponStripe) {
        this.idCuponStripe = idCuponStripe;
        this.precio = precio;
        this.imagen = imagen;
        this.idReferenciaCuponStripe = idReferenciaCuponStripe; // Asignamos el id de referencia
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIdCuponStripe() {
        return idCuponStripe;
    }

    public void setIdCuponStripe(String idCuponStripe) {
        this.idCuponStripe = idCuponStripe;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getIdReferenciaCuponStripe() {
        return idReferenciaCuponStripe;
    }

    public void setIdReferenciaCuponStripe(String idReferenciaCuponStripe) {
        this.idReferenciaCuponStripe = idReferenciaCuponStripe;
    }
}
