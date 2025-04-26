package com.ashyaart.ecommerce.util;

import com.ashyaart.ecommerce.modelo.ProductoCarrito;
import java.io.UnsupportedEncodingException;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.List;
import java.util.Properties;

public class EmailSender {

    public static void enviarCorreoConfirmacion(String destinatario, String nombreCliente, List<ProductoCarrito> carrito) throws MessagingException, UnsupportedEncodingException {
        String asunto = "¡Gracias por tu compra en AshYa Art!";

        StringBuilder cuerpoHtml = new StringBuilder();
        cuerpoHtml.append("<!DOCTYPE html>");
        cuerpoHtml.append("<html lang='es'><head>");
        cuerpoHtml.append("<meta charset='UTF-8'>");
        cuerpoHtml.append("<style>");
        cuerpoHtml.append("body { font-family: 'Segoe UI', sans-serif; background-color: #EFE5DB; padding: 20px; color: #333; }");
        cuerpoHtml.append(".container { max-width: 600px; margin: auto; background: #fff9f4; border-radius: 10px; padding: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }");
        cuerpoHtml.append("h2 { color: #3A9097; }");
        cuerpoHtml.append("ul { list-style-type: none; padding: 0; }");
        cuerpoHtml.append("li { padding: 10px 0; border-bottom: 1px solid #e6d6c5; }");
        cuerpoHtml.append(".footer { margin-top: 30px; font-size: 0.9em; color: #888; }");
        cuerpoHtml.append("</style></head><body>");

        cuerpoHtml.append("<div class='container'>");
        cuerpoHtml.append("<h2>¡Hola ").append(nombreCliente).append("!</h2>");
        cuerpoHtml.append("<p>Gracias por confiar en <strong>AshYa Art</strong>. Aquí tienes el resumen de tu compra:</p>");
        cuerpoHtml.append("<ul>");

        for (ProductoCarrito producto : carrito) {
            cuerpoHtml.append("<li><strong>")
                    .append(producto.getNombre()).append("</strong>");
            if (producto.getFecha() != null && !producto.getFecha().isEmpty()) {
                cuerpoHtml.append(" — ").append(producto.getFecha()).append(" ").append(producto.getHora());
            }
            cuerpoHtml.append("<br>x").append(producto.getCantidad());
            cuerpoHtml.append(" — <strong>").append(String.format("EUR %.2f", producto.getPrecio() / 100.0)).append("</strong></li>");
        }

        cuerpoHtml.append("</ul>");
        cuerpoHtml.append("<div class='footer'>");
        cuerpoHtml.append("<p>Si tienes cualquier duda, responde a este correo y te ayudaremos encantados.</p>");
        cuerpoHtml.append("<p><em>Con cariño,</em><br>El equipo de AshYa Art 💙</p>");
        cuerpoHtml.append("</div></div>");
        cuerpoHtml.append("</body></html>");

        // Configuración para Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Cambia esto por tu correo y contraseña de aplicación
        final String usuario = "ivangonzalez.code@gmail.com";
        final String claveApp = "mjkq chsj dgdm dqya";

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuario, claveApp);
            }
        });

        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(usuario, "AshYa Art"));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensaje.setSubject(asunto);
        mensaje.setContent(cuerpoHtml.toString(), "text/html; charset=utf-8");

        Transport.send(mensaje);
    }
}
