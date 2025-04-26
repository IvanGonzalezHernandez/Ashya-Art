package com.ashyaart.ecommerce.modelo;

public class CursoFecha {
    private String fecha;
    private String hora;
    private Cursos curso;
    private int plazasDisponibles;

    public CursoFecha(String fecha, String hora, Cursos curso, int plazasDisponibles) {
        this.fecha = fecha;
        this.hora = hora;
        this.curso = curso;
        this.plazasDisponibles = plazasDisponibles;
    }

    public String getFecha() {
        return fecha;
    }

    public String getHora() {
        return hora;
    }

    public Cursos getCurso() {
        return curso;
    }

    public int getPlazasDisponibles() {
        return plazasDisponibles;
    }
}
