package com.ashyaart.ecommerce.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.*;

public class PdfGenerator {

 public static byte[] generarTarjetaRegaloPdfEnMemoria(String rutaImagen, String codigo, String nombre, String email) throws Exception {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
        Document document = new Document();

        PdfWriter writer = PdfWriter.getInstance(document, byteStream);
        document.open();

        // Fondo
        Image fondo = Image.getInstance(rutaImagen);
        fondo.setAbsolutePosition(0, 0);
        fondo.scaleToFit(PageSize.A4.getWidth(), PageSize.A4.getHeight());
        document.add(fondo);

        // Texto
        Font font = new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.BLACK);
        Paragraph titulo = new Paragraph("¡Has recibido una Tarjeta Regalo!", font);
        titulo.setAlignment(Element.ALIGN_CENTER);
        titulo.setSpacingBefore(150);
        document.add(titulo);

        Paragraph detalles = new Paragraph("Código: " + codigo + "\nNombre: " + nombre + "\nEmail: " + email, font);
        detalles.setAlignment(Element.ALIGN_CENTER);
        detalles.setSpacingBefore(50);
        document.add(detalles);

        document.close();
        writer.close();

        return byteStream.toByteArray();
    }
}
