<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login Ashya</title>
        <%@ include file="../includes/cdn.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

    </head>
    <body class="d-flex align-items-center justify-content-center">

        <div class="card card-login">
            <div class="text-center mb-3">
                <img src="../../resources/imagenes/logo/logo.png" alt="Logo Ashya" style="max-height: 80px;">
            </div>
            <h3 class="text-center mb-3">Iniciar Sesión</h3>

            <% String mensajeError = (String) request.getAttribute("mensajeError");
                if (mensajeError != null) {%>
            <div class="alert alert-danger text-center" role="alert">
                <%= mensajeError%>
            </div>
            <% }%>

            <form action="../../LoginServlet" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Introduce tu correo" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Introduce tu contraseña" required>
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-custom" name="button" value="login" type="submit">Iniciar Sesión</button>
                </div>
            </form>
        </div>

    </body>
</html>