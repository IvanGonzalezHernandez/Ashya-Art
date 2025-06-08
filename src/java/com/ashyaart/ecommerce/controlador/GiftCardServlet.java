package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.TarjetaRegaloDAO;
import com.ashyaart.ecommerce.modelo.TarjetaRegalo;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Coupon;
import com.stripe.param.CouponCreateParams;
import java.io.IOException;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GiftCardServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar la clave secreta de Stripe
        Stripe.apiKey = System.getenv("STRIPE_TEST_KEY");

        // Conexión a la base de datos
        ConectorBD conector = new ConectorBD();
        Connection conexion = conector.getConexion();

        // Obtener parámetros del formulario
        String precio = request.getParameter("precioTarjeta"); // El precio que el admin asigna a la tarjeta
        String idCupon = request.getParameter("idCupon"); // El id del cupón de Stripe
        String imagen = request.getParameter("imagen-tarjeta"); // La ruta de la imagen proporcionada por el admin

        double precioDouble = Double.parseDouble(precio); // si viene como String
        long precioCentimos = Math.round(precioDouble * 100);

        Coupon coupon = null;

        try {
            // Crear cupón de Stripe
            CouponCreateParams params = CouponCreateParams.builder()
                    .setAmountOff(precioCentimos) // Precio en céntimos
                    .setCurrency("eur")
                    .setDuration(CouponCreateParams.Duration.ONCE) // Sólo se puede usar una vez
                    .setName(idCupon)
                    .build();

            coupon = Coupon.create(params); // Creamos el cupón

        } catch (StripeException ex) {
            Logger.getLogger(GiftCardServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=Error+al+crear+el+cupón");
            return;
        }

        // Crear objeto de tarjeta regalo (plantilla) con el ID del cupón
        TarjetaRegalo tarjeta = new TarjetaRegalo(idCupon, Double.parseDouble(precio), imagen, coupon.getId());

        // Guardar en la base de datos
        TarjetaRegaloDAO dao = new TarjetaRegaloDAO();
        boolean guardada = dao.insertarPlantillaTarjeta(conexion, tarjeta);

        if (guardada) {
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Plantilla+de+tarjeta+creada+correctamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=Error+al+crear+plantilla+de+tarjeta");
        }
    }
}
