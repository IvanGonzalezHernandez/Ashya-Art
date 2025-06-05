package com.ashyaart.ecommerce.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import java.io.*;

public class PdfGenerator {

    public static byte[] generarTarjetaRegaloPdfEnMemoria(String rutaImagen, String codigo, String nombre, String email, int precio) throws Exception {
        ByteArrayOutputStream byteStream = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4, 0, 0, 0, 0);  // sin márgenes

        PdfWriter writer = PdfWriter.getInstance(document, byteStream);
        document.open();

        PdfContentByte canvas = writer.getDirectContent();

        // Imagen
        Image fondo = Image.getInstance(rutaImagen);

        // Escalamos la imagen para que tenga toda la anchura y un 85% de la altura
        float scaleHeight = PageSize.A4.getHeight() * 0.85f;
        float scaleWidth = PageSize.A4.getWidth();
        fondo.scaleToFit(scaleWidth, scaleHeight);

        // Posición vertical centrada para que deje margen arriba y abajo
        float yPos = (PageSize.A4.getHeight() - fondo.getScaledHeight()) / 2;
        fondo.setAbsolutePosition(0, yPos);

        document.add(fondo);

        // Definir medidas para los rectángulos
        float rectWidth = PageSize.A4.getWidth() - 100; // 50 margen izquierdo y derecho
        float rectHeight = 100f;
        float marginLeft = 50f;

        // Posiciones de los rectángulos (de abajo hacia arriba)
        float bottomRectY = 100f; // abajo, margen inferior 100
        float topRectY = PageSize.A4.getHeight() - rectHeight - 90f; // arriba, margen superior 150 menos 60 para subirlo

        // Dibujar rectángulo superior (datos)
        Rectangle rectTop = new Rectangle(marginLeft, topRectY, marginLeft + rectWidth, topRectY + rectHeight);
        rectTop.setBackgroundColor(BaseColor.WHITE);
        rectTop.setBorder(Rectangle.BOX);
        rectTop.setBorderWidth(1f);
        canvas.rectangle(rectTop);
        canvas.setColorFill(BaseColor.WHITE);
        canvas.fillStroke();

        // Dibujar rectángulo inferior (código)
        Rectangle rectBottom = new Rectangle(marginLeft, bottomRectY, marginLeft + rectWidth, bottomRectY + rectHeight);
        rectBottom.setBackgroundColor(BaseColor.WHITE);
        rectBottom.setBorder(Rectangle.BOX);
        rectBottom.setBorderWidth(1f);
        canvas.rectangle(rectBottom);
        canvas.setColorFill(BaseColor.WHITE);
        canvas.fillStroke();

        // Fuente única para todo el texto
        Font fontTexto = new Font(Font.FontFamily.HELVETICA, 16, Font.NORMAL, BaseColor.BLACK);

        // Texto datos (centrado en rectángulo superior), dos líneas
        float centerX = marginLeft + rectWidth / 2;
        float centerY = topRectY + rectHeight / 2 + 10;

        ColumnText.showTextAligned(
            canvas,
            Element.ALIGN_CENTER,
            new Phrase(nombre + " " + precio + " Eur", fontTexto),
            centerX,
            centerY + 10,  // línea superior
            0
        );

        ColumnText.showTextAligned(
            canvas,
            Element.ALIGN_CENTER,
            new Phrase(email, fontTexto),
            centerX,
            centerY - 10,  // línea inferior
            0
        );

        // Texto código (centrado en rectángulo inferior) con la misma fuente y tamaño
        ColumnText.showTextAligned(
            canvas,
            Element.ALIGN_CENTER,
            new Phrase("Código: " + codigo, fontTexto),
            marginLeft + rectWidth / 2,
            bottomRectY + rectHeight / 2,
            0
        );

        document.close();
        writer.close();

        return byteStream.toByteArray();
    }
}
