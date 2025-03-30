/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ashyaart.ecommerce.modelo;

/**
 *
 * @author ivang
 */
public class Admin {

    // Atributos de la clase Admin
    private int id_admin;
    private String nombre;
    private String email;
    private String password;

    // Constructor de la clase Admin
    public Admin(int id, String nombre, String email, String password) {
        this.id_admin = id;
        this.nombre = nombre;
        this.email = email;
        this.password = password;
    }

    // Métodos getter y setter para los atributos
    public int getId() {
        return id_admin;
    }

    public void setId(int id) {
        this.id_admin = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
