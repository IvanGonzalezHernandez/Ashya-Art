package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.dao.ProductosDAO;
import com.ashyaart.ecommerce.dao.TarjetaRegaloDAO;
import com.ashyaart.ecommerce.modelo.Cursos;
import com.ashyaart.ecommerce.modelo.Productos;
import com.ashyaart.ecommerce.modelo.TarjetaRegalo;
import com.ashyaart.ecommerce.util.ConectorBD;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ivang
 */
public class ResetCursosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean actualizado = false;

        try {
            // Crear conexión
            ConectorBD conector = new ConectorBD();
            Connection conexion = conector.getConexion();

            if (conexion != null) {

                CursosDAO cursosDAO = new CursosDAO();
                List<Cursos> cursos = cursosDAO.obtenerTodosLosCursos(conexion);
                getServletContext().setAttribute("listaCursos", cursos);

                // Obtener todas las plantillas de tarjetas regalo
                TarjetaRegaloDAO tarjetaRegaloDAO = new TarjetaRegaloDAO();
                List<TarjetaRegalo> tarjetasRegalo = tarjetaRegaloDAO.obtenerTodasLasTarjetasRegalo(conexion);
                getServletContext().setAttribute("listaTarjetasRegalo", tarjetasRegalo);
                
                // Obtener todos los productos de cerámica
                ProductosDAO productosDAO = new ProductosDAO();
                List<Productos> productos = productosDAO.obtenerTodosProductos(conexion);
                getServletContext().setAttribute("listaProductos", productos);

                actualizado = true;
                conexion.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            actualizado = false;
        }

        // Redirigir según el resultado
        if (actualizado) {
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Listas+de+cursos+y+tarjetas+actualizadas+correctamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudieron+actualizar+las+listas+de+cursos+y+tarjetas");
        }
    }

}
