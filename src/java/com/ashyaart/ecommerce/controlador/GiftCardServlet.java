package com.ashyaart.ecommerce.controlador;

import com.stripe.Stripe;
import com.stripe.model.Coupon;
import com.stripe.param.CouponCreateParams;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GiftCardServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Configurar la clave de API de Stripe
        Stripe.apiKey = "sk_test_51R1AfzQsK7W2R2yG8WVaLsvv1BRvqO4LKG8RAtZXhUYhgijhzjcETNftYFhFafv67fYfMTKJNkGEyMHRd2qxEajp00j2cVA5bx";

        // Recibir parámetros del formulario (puedes obtenerlos del request)
        String monto = request.getParameter("precioTarjeta"); // En euros, por ejemplo 70
        String idCupon = request.getParameter("idCupon"); // El ID del cupón, por ejemplo "tarjeta_regalo_70"

        try {
            // Crear el cupón
            CouponCreateParams params = CouponCreateParams.builder()
                    .setAmountOff(Long.parseLong(monto) * 100) // Convertir a centavos
                    .setCurrency("eur")
                    .setId(idCupon) // Usar el ID proporcionado
                    .setDuration(CouponCreateParams.Duration.ONCE) // Cupón de un solo uso
                    .build();

            // Crear el cupón en Stripe
            Coupon coupon = Coupon.create(params);

            // Redirigir a dashboard.jsp con mensaje de éxito
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?mensaje=Cupon+creado+correctamente");
        } catch (Exception e) {
            // Manejar errores
            e.printStackTrace();
            // Redirigir a dashboard.jsp con mensaje de error
            response.sendRedirect(request.getContextPath() + "/jsp/vistas/dashboard.jsp?error=No+se+pudo+crear+el+cupon");
        }
    }
}
