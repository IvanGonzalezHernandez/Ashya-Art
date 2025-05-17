package com.ashyaart.ecommerce.modelo;

import java.util.Date;

public class Reserva {
    private int idReserva;
    private int idCurso;
    private String nombreCliente;
    private String correoCliente;
    private Date fechaReserva;
    private int plazasReservadas;
    private Date fechaCurso;
    private String horaCurso;
    private String nombreCurso;

    // Constructor
    public Reserva(int idReserva, int idCurso, String nombreCliente, String correoCliente, Date fechaReserva, 
                   int plazasReservadas, Date fechaCurso, String horaCurso, String nombreCurso) {
        this.idReserva = idReserva;
        this.idCurso = idCurso;
        this.nombreCliente = nombreCliente;
        this.correoCliente = correoCliente;
        this.fechaReserva = fechaReserva;
        this.plazasReservadas = plazasReservadas;
        this.fechaCurso = fechaCurso;
        this.horaCurso = horaCurso;
        this.nombreCurso = nombreCurso;
    }

    // Getters y setters
    public int getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getCorreoCliente() {
        return correoCliente;
    }

    public void setCorreoCliente(String correoCliente) {
        this.correoCliente = correoCliente;
    }

    public Date getFechaReserva() {
        return fechaReserva;
    }

    public void setFechaReserva(Date fechaReserva) {
        this.fechaReserva = fechaReserva;
    }


    public int getPlazasReservadas() {
        return plazasReservadas;
    }

    public void setPlazasReservadas(int plazasReservadas) {
        this.plazasReservadas = plazasReservadas;
    }

    public Date getFechaCurso() {
        return fechaCurso;
    }

    public void setFechaCurso(Date fechaCurso) {
        this.fechaCurso = fechaCurso;
    }

    public String getHoraCurso() {
        return horaCurso;
    }

    public void setHoraCurso(String horaCurso) {
        this.horaCurso = horaCurso;
    }
    
    public String getNombreCurso(){
        return nombreCurso;
    }
    
    public void setNombreCurso(String nombreCurso){
        this.nombreCurso = nombreCurso;
    }
}
