package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.dao.ProductosDAO;
import com.ashyaart.ecommerce.dao.TarjetaRegaloDAO;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.modelo.Productos;
import com.ashyaart.ecommerce.modelo.TarjetaRegalo;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Listener que carga los cursos al iniciar la aplicación.
 */
@WebListener
public class ContextInit implements ServletContextListener {

    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            // Crear la conexión a la base de datos
            ConectorBD conector = new ConectorBD();
            Connection conexion = conector.getConexion();
            
            //Obtener todos los cursos(bueno)
            CursosDAO cursosDAO = new CursosDAO();
            List<Cursos> cursos = cursosDAO.obtenerTodosLosCursos(conexion);
            sce.getServletContext().setAttribute("listaCursos", cursos);
            
            // Obtener todas las plantillas de tarjetas regalo
            TarjetaRegaloDAO tarjetaRegaloDAO = new TarjetaRegaloDAO();
            List<TarjetaRegalo> tarjetasRegalo = tarjetaRegaloDAO.obtenerTodasLasTarjetasRegalo(conexion);
            sce.getServletContext().setAttribute("listaTarjetasRegalo", tarjetasRegalo);
            
            // Obtener todos los productos de cerámica
            ProductosDAO productosDAO = new ProductosDAO();
            List<Productos> productos = productosDAO.obtenerTodosProductos(conexion);
            sce.getServletContext().setAttribute("listaProductos", productos);
            
        } catch (SQLException ex) {
            Logger.getLogger(ContextInit.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Opcional: Limpiar recursos al apagar el servidor
    }
}
