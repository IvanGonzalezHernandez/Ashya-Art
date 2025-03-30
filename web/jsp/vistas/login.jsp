<%-- 
    Document   : login
    Created on : 14 mar 2025, 15:21:29
    Author     : ivang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Ashya</title>
    </head>
    <body>

        <%
            // Obtener el mensaje de error si existe
            String mensajeError = (String) request.getAttribute("mensajeError");
            if (mensajeError != null) {
        %>
        <!-- Mostrar el mensaje de error -->
        <div style="color: red; font-weight: bold;">
            <%= mensajeError%>
        </div>
        <%
            }
        %>

        <form action="../../LoginServlet" method="post">
            <label for="email">Correo Electrónico</label>
            <input type="email" id="email" name="email" placeholder="Introduce tu correo" required>
            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" placeholder="Introduce tu contraseña" required>
            <button id="button" name="button" value="login" type="submit">Iniciar Sesión</button>
        </form>

    </body>
</html>
