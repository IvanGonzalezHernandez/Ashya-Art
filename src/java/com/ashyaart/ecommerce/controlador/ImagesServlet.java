package com.ashyaart.ecommerce.controlador;

import com.google.gson.Gson;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ImagesServlet extends HttpServlet {

    private static final String IMAGES_PATH = "/resources/imagenes/workshops-services/courses";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtenemos el parámetro 'carpeta' para poder cargar imágenes de distintas carpetas
        String carpetaParam = request.getParameter("carpeta");
        String carpeta = (carpetaParam == null || carpetaParam.isEmpty()) ? IMAGES_PATH : carpetaParam;

        // Convertimos la ruta relativa a ruta física
        String realPath = getServletContext().getRealPath(carpeta);
        File folder = new File(realPath);
        File[] files = folder.listFiles();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (files == null || files.length == 0) {
            out.print("[]");
            return;
        }

        // Filtramos solo las imágenes con extensiones jpg, jpeg, png o gif
        java.util.List<String> imageList = new java.util.ArrayList<>();
        for (File file : files) {
            if (file.isFile() && file.getName().matches(".*\\.(jpg|jpeg|png|gif)$")) {
                // Construimos la URL accesible para el cliente (con contextPath)
                imageList.add(request.getContextPath() + carpeta + "/" + file.getName());
            }
        }

        out.print(new Gson().toJson(imageList));
    }
}
