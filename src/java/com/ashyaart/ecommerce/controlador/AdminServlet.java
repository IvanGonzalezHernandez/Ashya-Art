package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.google.gson.Gson;

import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();

        ClienteDAO dao = new ClienteDAO();
        List<Cliente> listaClientes = dao.obtenerClientes(conexion);

        Gson gson = new Gson();
        String json = gson.toJson(listaClientes);
        response.getWriter().write(json);
    }
}
