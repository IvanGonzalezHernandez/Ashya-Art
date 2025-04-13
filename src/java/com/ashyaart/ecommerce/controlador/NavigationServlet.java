package com.ashyaart.ecommerce.controlador;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NavigationServlet extends HttpServlet {

    // Método doGet que maneja las peticiones GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page"); // Obtiene el parámetro 'page' de la URL.
        String destino = "index.jsp"; // Página por defecto, en caso de que 'page' no se pase o sea incorrecto.

        if (page != null) {  // Si el parámetro 'page' no es nulo, se evalúa.
            switch (page) {  // Dependiendo del valor de 'page', se asigna un destino diferente.
                case "home":
                    destino = "jsp/vistas/home.jsp";  // Si 'page' es 'home', se redirige a la página de inicio.
                    break;
                case "workshops":
                    destino = "jsp/vistas/workshops-services.jsp";  // Si 'page' es 'workshops', se redirige a la página de talleres y servicios.
                    break;
                case "calendar":
                    destino = "jsp/vistas/calendar.jsp";  // Si 'page' es 'calendar', se redirige a la página de calendarios generales.
                    break;
                case "shop":
                    destino = "jsp/vistas/shop.jsp";  // Si 'page' es 'shop', se redirige a la página de la tienda.
                    break;
                case "about":
                    destino = "jsp/vistas/about-ashya.jsp";  // Si 'page' es 'about', se redirige a la página de "sobre Ashya".
                    break;
                case "studio":
                    destino = "jsp/vistas/studio-membership.jsp";  // Si 'page' es 'studio', se redirige a la página del estudio y membresía.
                    break;
            }
        }

        // Redirige a la página correspondiente usando RequestDispatcher
        request.getRequestDispatcher(destino).forward(request, response);
    }

    // Método doPost que redirige todas las solicitudes POST al mismo comportamiento que doGet
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);  // Llama al método doGet en caso de ser una solicitud POST.
    }
}
