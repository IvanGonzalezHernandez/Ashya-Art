package com.ashyaart.ecommerce.controlador;

import com.ashyaart.ecommerce.dao.ClienteDAO;
import com.ashyaart.ecommerce.dao.CursosDAO;
import com.ashyaart.ecommerce.dao.TarjetaRegaloDAO;
import com.ashyaart.ecommerce.modelo.Cliente;
import com.ashyaart.ecommerce.modelo.ProductoCarrito;
import static com.ashyaart.ecommerce.util.CodigoAleatorio.generarCodigoAleatorio;
import com.ashyaart.ecommerce.util.ConectorBD;
import com.ashyaart.ecommerce.util.EmailSender;
import com.ashyaart.ecommerce.util.PaymentLog;
import com.ashyaart.ecommerce.util.PdfGenerator;
import com.google.gson.Gson;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.Coupon;
import com.stripe.model.PromotionCode;
import com.stripe.model.checkout.Session;
import com.stripe.model.checkout.Session.Discount;
import com.stripe.param.PromotionCodeCreateParams;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class SuccessServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ConectorBD conector = new ConectorBD();
        Connection conexion = conector.getConexion();

        Stripe.apiKey = System.getenv("STRIPE_TEST_KEY");

        String sessionId = request.getParameter("session_id");

        if (sessionId == null || sessionId.isEmpty()) {
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
            return;
        }

        try {
            // Obtener la sesión de Stripe
            Session session = Session.retrieve(sessionId);
            String productosJson = session.getMetadata().get("productos");

            // Verificar que productosJson no sea nulo
            if (productosJson == null || productosJson.isEmpty()) {
                throw new ServletException("No se encontraron productos en la sesión.");
            }

            // Deserializar productos
            Gson gson = new Gson();
            ProductoCarrito[] productosArray = gson.fromJson(productosJson, ProductoCarrito[].class);

            // Obtener datos del cliente
            String nombre = session.getMetadata().get("nombre");
            String apellido = session.getMetadata().get("apellido");
            String direccion = session.getMetadata().get("direccion");
            String telefono = session.getMetadata().get("telefono");
            String email = session.getMetadata().get("email");
            String idStripe = sessionId;

            // Crear cliente y guardarlo
            Cliente cliente = new Cliente(nombre, apellido, direccion, telefono, email, idStripe);
            ClienteDAO clienteDAO = new ClienteDAO();
            clienteDAO.guardarCliente(conexion, cliente);

            // Crear instancias de DAO
            TarjetaRegaloDAO tarjetaRegaloDAO = new TarjetaRegaloDAO();
            CursosDAO cursoDAO = new CursosDAO();

            // Lista para almacenar PDFs generados de tarjetas regalo
            List<byte[]> pdfsTarjetas = new ArrayList<>();

            // Procesar productos en el carrito
            for (ProductoCarrito producto : productosArray) {
                if ("curso".equalsIgnoreCase(producto.getTipo())) {
                    // Si es un curso, guardar la reserva
                    String fecha = producto.getFecha();
                    String hora = producto.getHora();
                    int plazasReservadas = producto.getCantidad();
                    cursoDAO.guardarReserva(conexion, fecha, hora, nombre, email, plazasReservadas);
                    cursoDAO.restarPlazasDisponibles(conexion, fecha, hora, plazasReservadas);
                } else if ("tarjeta".equalsIgnoreCase(producto.getTipo())) {
                    for (int i = 0; i < producto.getCantidad(); i++) {
                        // Crear una nueva tarjeta para cada cantidad
                        String idReferencia = tarjetaRegaloDAO.obtenerIdReferenciaPorIdCupon(conexion, producto.getPrecio());
                        PromotionCode promoCode = crearPromotionCode(idReferencia);

                        // Guardar la tarjeta regalo en la base de datos
                        tarjetaRegaloDAO.guardarTarjetaRegalo(conexion, promoCode.getCode(), producto.getNombre(), email, producto.getPrecio(), idReferencia);

                        try {
                            // Generar PDF de la tarjeta regalo
                            String rutaImagen = getServletContext().getRealPath("/resources/imagenes/workshops-services/cards/50_giftCard.png");
                            byte[] pdfTarjeta = PdfGenerator.generarTarjetaRegaloPdfEnMemoria(rutaImagen, promoCode.getCode(), producto.getNombre(), email);
                            if (pdfTarjeta != null) {
                                pdfsTarjetas.add(pdfTarjeta); // Añadir el PDF a la lista
                            }
                        } catch (Exception e) {
                            System.err.println("Error al generar el PDF de la tarjeta regalo: " + e.getMessage());
                        }
                    }
                }
            }

            // Comprobar si se usó una tarjeta regalo
            if (session.getDiscounts() != null && !session.getDiscounts().isEmpty()) {
                Discount discount = session.getDiscounts().get(0);
                if (discount.getPromotionCode() != null) {
                    String promoCodeId = discount.getPromotionCode();
                    PromotionCode promoCode = PromotionCode.retrieve(promoCodeId);
                    String codigoUsado = promoCode.getCode();

                    Coupon expandableCoupon = promoCode.getCoupon();
                    String couponId = expandableCoupon.getId();
                    Coupon coupon = Coupon.retrieve(couponId);

                    Long amountOff = coupon.getAmountOff();
                    if (amountOff != null) {
                        System.out.println("Descuento fijo aplicado: " + (amountOff / 100.0) + " EUR");
                    }

                    // Actualizar estado de la tarjeta
                    tarjetaRegaloDAO.actualizarEstadoTarjeta(conexion, codigoUsado);
                }
            }

            // Log de éxito
            PaymentLog.logClienteSuccess(nombre, apellido, direccion, telefono, email, idStripe);

            
            // Enviar correo con los productos (cursos o tarjetas regalo)
            try {
                // También incluir productos de tipo "curso" en el correo
                List<ProductoCarrito> productosList = Arrays.asList(productosArray);
                if (!productosList.isEmpty()) {
                    EmailSender.enviarCorreoConfirmacion(
                            email,
                            nombre,
                            productosList, // Incluir todos los productos (cursos y tarjetas)
                            pdfsTarjetas // Aunque no haya tarjetas, puedes pasar la lista vacía
                    );
                }
            } catch (Exception e) {
                System.err.println("Error al enviar el correo de confirmación: " + e.getMessage());
            }

            // Redirigir a la página de éxito
            response.sendRedirect("/Ashya-Art/jsp/vistas/success.jsp");

        } catch (StripeException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/Ashya-Art/jsp/vistas/cancel.jsp");
        }
    }

    private PromotionCode crearPromotionCode(String idReferencia) throws StripeException {
        // Crear un código de promoción para la tarjeta regalo
        PromotionCodeCreateParams promoParams = PromotionCodeCreateParams.builder()
                .setCoupon(idReferencia)
                .setCode("ASHYA-" + generarCodigoAleatorio())
                .setMaxRedemptions(1L)
                .build();

        return PromotionCode.create(promoParams);
    }
}
