<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.centromedico.models.user.User" %>
<%@ page import="mx.edu.utez.centromedico.models.rol.Rol" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Usuarios Registrados</title>
</head>
<body>
<div class="container mt-5">
    <h1>Usuarios Registrados</h1>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Correo</th>
            <th>Rol</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<User> userList = (List<User>) request.getAttribute("userList");
            if (userList != null) {
                for (User user : userList) {
        %>
        <tr>
            <td><%= user.getIdUsuario() %></td>
            <td><%= user.getCorreo() %></td>
            <td><%= user.getRol().getTipo() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="3">No hay usuarios registrados.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
