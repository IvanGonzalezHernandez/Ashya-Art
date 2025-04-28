package com.ashyaart.ecommerce.controlador;


import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Listener que carga los cursos al iniciar la aplicación.
 */
@WebListener
public class ContextInit implements ServletContextListener {
    
    //ACORDARSE QUE PARA QUE SE ACTUALICEN LOS CURSOS EL ADMIN TIENE QUE TENER UN BOTON O ALGO QUE SOBREESCRIBA LA LISTA DE CURSOS         getServletContext().setAttribute("cursos", cursos);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Crear la conexión a la base de datos
        ConectorBD conector = new ConectorBD("localhost", "ashya_art", "root", "");
        Connection conexion = conector.getConexion();
        
        //Obtener todos los cursos(bueno)
        CursosDAO cursosDAO = new CursosDAO();
        List<Cursos> cursoss = cursosDAO.obtenerTodosLosCursos(conexion);
        sce.getServletContext().setAttribute("listaCursos", cursoss);
        

        
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Opcional: Limpiar recursos al apagar el servidor
    }
}
