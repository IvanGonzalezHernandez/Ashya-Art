package com.ashyaart.ecommerce.modelo;

public class ProductoCarrito {

    private int id;
    private String nombre;
    private int precio;       // En centavos
    private int cantidad;
    private String fecha;     // Como string si viene de Stripe
    private String hora;      // También como string
    private String tipo;

    public ProductoCarrito() {
    }

    public ProductoCarrito(int id, String nombre, int precio, int cantidad, String fecha, String hora, String tipo) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.cantidad = cantidad;
        this.fecha = fecha;
        this.hora = hora;
        this.tipo = tipo;
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
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

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
