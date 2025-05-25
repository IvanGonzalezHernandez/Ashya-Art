package com.ashyaart.ecommerce.util;

import com.ashyaart.ecommerce.modelo.ProductoCarrito;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

public class EmailSender {

    public static void enviarCorreoConfirmacion(String destinatario, String nombreCliente, List<ProductoCarrito> carrito, List<byte[]> pdfsAdjuntos) throws MessagingException, UnsupportedEncodingException {
        String asunto = "¡Gracias por tu compra en Ashya Art!";

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
        cuerpoHtml.append("<p>Gracias por confiar en <strong>Ashya Art</strong>. Aquí tienes el resumen de tu compra:</p>");
        cuerpoHtml.append("<ul>");

        for (ProductoCarrito producto : carrito) {
            cuerpoHtml.append("<li><strong>")
                    .append(producto.getNombre()).append("</strong>");

            if (producto.getFecha() != null && !producto.getFecha().isEmpty()) {
                cuerpoHtml.append(" — ").append(producto.getFecha()).append(" ").append(producto.getHora());
            }

            cuerpoHtml.append("<br>x").append(producto.getCantidad());
            int precio = producto.getPrecio();
            cuerpoHtml.append(" — <strong>").append(String.format("EUR %.2f", (double) precio)).append("</strong>");
            cuerpoHtml.append("</li>");
        }

        cuerpoHtml.append("</ul>");
        cuerpoHtml.append("<div class='footer'>");
        cuerpoHtml.append("<p>Si tienes cualquier duda, responde a este correo y te ayudaremos encantados.</p>");
        cuerpoHtml.append("<p><em>Con cariño,</em><br>El equipo de Ashya Art 💙</p>");
        cuerpoHtml.append("</div></div>");
        cuerpoHtml.append("</body></html>");

        // Configuración SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        final String usuario = System.getenv("SMTP_USER"); 
        final String claveApp = System.getenv("SMTP_PASS");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuario, claveApp);
            }
        });

        // Crear mensaje
        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(usuario, "Ashya Art"));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensaje.setSubject(asunto);

        // Cuerpo HTML
        MimeBodyPart cuerpoHtmlPart = new MimeBodyPart();
        cuerpoHtmlPart.setContent(cuerpoHtml.toString(), "text/html; charset=utf-8");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(cuerpoHtmlPart);

        // Adjuntar PDFs
        if (pdfsAdjuntos != null && !pdfsAdjuntos.isEmpty()) {
            int contador = 1;
            for (byte[] pdf : pdfsAdjuntos) {
                MimeBodyPart adjuntoPdf = new MimeBodyPart();
                DataSource fuente = new ByteArrayDataSource(pdf, "application/pdf");
                adjuntoPdf.setDataHandler(new DataHandler(fuente));
                adjuntoPdf.setFileName("tarjeta_regalo_" + contador + ".pdf");  // Aseguramos que el nombre sea único
                multipart.addBodyPart(adjuntoPdf);
                contador++;  // Incrementamos el contador para que cada archivo tenga un nombre único
            }
        }

        mensaje.setContent(multipart);
        Transport.send(mensaje);
    }

    public static void enviarMensajeContacto(String nombre, String email, String mensajeUsuario) throws MessagingException, UnsupportedEncodingException {
        String asunto = "Nuevo mensaje desde el formulario de contacto";

        StringBuilder cuerpoHtml = new StringBuilder();
        cuerpoHtml.append("<!DOCTYPE html>");
        cuerpoHtml.append("<html lang='es'><head><meta charset='UTF-8'>");
        cuerpoHtml.append("<style>");
        cuerpoHtml.append("body { font-family: 'Segoe UI', sans-serif; background-color: #EFE5DB; padding: 20px; color: #333; }");
        cuerpoHtml.append(".container { max-width: 600px; margin: auto; background: #fff9f4; border-radius: 10px; padding: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }");
        cuerpoHtml.append("h2 { color: #3A9097; }");
        cuerpoHtml.append("</style></head><body>");

        cuerpoHtml.append("<div class='container'>");
        cuerpoHtml.append("<h2>Nuevo mensaje de contacto</h2>");
        cuerpoHtml.append("<p><strong>Nombre:</strong> ").append(nombre).append("</p>");
        cuerpoHtml.append("<p><strong>Email:</strong> ").append(email).append("</p>");
        cuerpoHtml.append("<p><strong>Mensaje:</strong><br>").append(mensajeUsuario.replace("\n", "<br>")).append("</p>");
        cuerpoHtml.append("</div></body></html>");

        // Configuración SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        final String usuario = System.getenv("SMTP_USER");
        final String claveApp = System.getenv("SMTP_PASS");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(usuario, claveApp);
            }
        });

        // Crear mensaje
        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(usuario, "Formulario Ashya Art"));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(usuario)); // te llega a ti mismo
        mensaje.setSubject(asunto);

        MimeBodyPart cuerpoHtmlPart = new MimeBodyPart();
        cuerpoHtmlPart.setContent(cuerpoHtml.toString(), "text/html; charset=utf-8");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(cuerpoHtmlPart);

        mensaje.setContent(multipart);
        Transport.send(mensaje);
    }
}
