package com.ashyaart.ecommerce.modelo;

public class Cursos {
    private int id;
    private String nombre;
    private String subtitulo;
    private String descripcion;
    private double precio;
    private String nivel;
    private String idioma;
    private String img; // Nueva propiedad para la imagen del curso

    // Constructor vacío
    public Cursos() {}

    // Constructor parcial
    public Cursos(String nombre, String subtitulo, String descripcion, double precio, String nivel, String idioma, String img) {
        this.nombre = nombre;
        this.subtitulo = subtitulo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.nivel = nivel;
        this.idioma = idioma;
        this.img = img;
    }

    // Constructor completo
    public Cursos(int id, String nombre, String subtitulo, String descripcion, double precio, String nivel, String idioma, String img) {
        this.id = id;
        this.nombre = nombre;
        this.subtitulo = subtitulo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.nivel = nivel;
        this.idioma = idioma;
        this.img = img;
    }

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getSubtitulo() { return subtitulo; }
    public void setSubtitulo(String subtitulo) { this.subtitulo = subtitulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public String getNivel() { return nivel; }
    public void setNivel(String nivel) { this.nivel = nivel; }

    public String getIdioma() { return idioma; }
    public void setIdioma(String idioma) { this.idioma = idioma; }

    public String getImg() { return img; }
    public void setImg(String img) { this.img = img; }
}
