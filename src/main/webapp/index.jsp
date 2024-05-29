<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inicio de Sesión</title>
</head>
<body>
<h1>Iniciar Sesión</h1>
<form action="${pageContext.request.contextPath}/users/login" method="post">
    <label for="correo">Correo:</label>
    <input type="text" id="correo" name="correo" required><br><br>
    <label for="contrasenia">Contraseña:</label>
    <input type="password" id="contrasenia" name="contrasenia" required><br><br>
    <input type="submit" value="Iniciar Sesión">
</form>
<c:if test="${not empty errorMessage}">
    <p style="color: red;">${errorMessage}</p>
</c:if>
</body>
</html>
