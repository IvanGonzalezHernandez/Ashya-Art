package com.ashyaart.ecommerce.modelo;

public class Curso {

    private int id_curso;
    private String nombre;
    private String descripcion;
    private double precio;
    private String imagen;
    private String subtitulo;
    private String nivel;
    private String duracion;
    private String piezas_creadas;
    private String idioma;
    private String localizacion;

    // Constructor con parámetros
    public Curso(int id_curso, String nombre, String descripcion, double precio, String imagen, String subtitulo,
            String nivel, String duracion, String piezas_creadas, String idioma, String localizacion) {
        this.id_curso = id_curso;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.imagen = imagen;
        this.subtitulo = subtitulo;
        this.nivel = nivel;
        this.duracion = duracion;
        this.piezas_creadas = piezas_creadas;
        this.idioma = idioma;
        this.localizacion = localizacion;
    }

    // Getters y Setters
    public int getId_curso() {
        return id_curso;
    }

    public void setId_curso(int id_curso) {
        this.id_curso = id_curso;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getSubtitulo() {
        return subtitulo;
    }

    public void setSubtitulo(String subtitulo) {
        this.subtitulo = subtitulo;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    public String getPiezas_creadas() {
        return piezas_creadas;
    }

    public void setPiezas_creadas(String piezas_creadas) {
        this.piezas_creadas = piezas_creadas;
    }

    public String getIdioma() {
        return idioma;
    }

    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    public String getLocalizacion() {
        return localizacion;
    }

    public void setLocalizacion(String localizacion) {
        this.localizacion = localizacion;
    }
}
