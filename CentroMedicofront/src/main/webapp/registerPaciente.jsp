<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Registro Exitoso</title>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">Centro Médico</div>
    </div>
</header>
<main class="container my-5">
    <h1>Registro Exitoso</h1>
    <%

        String userType = (String) session.getAttribute("userType");
        String message;
        String buttonText;
        String redirectURL = request.getContextPath() + "/registerUser.jsp";

        if (userType == null) {
            userType = ""; // Evitar valores nulos
        }

        switch (userType) {
            case "Medico":
                message = "El Médico ha sido registrado correctamente.";
                buttonText = "Registrar otro Médico";
                break;
            case "Recepcionista":
                message = "El Recepcionista ha sido registrado correctamente.";
                buttonText = "Registrar otro Recepcionista";
                break;
            default:
                message = "El usuario ha sido registrado correctamente.";
                buttonText = "Registrar otro Usuario";
                break;
        }
    %>
    <p><%= message %></p>
    <a href="<%= redirectURL %>" class="btn btn-primary"><%= buttonText %></a>
</main>
</body>
</html>
