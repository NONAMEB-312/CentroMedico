<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inicio de Sesión</title>
</head>
<body>
<h1>Iniciar Sesión</h1>
<form id="user-form" action="${pageContext.request.contextPath}/users/login" method="post">
    <label for="correo">Correo:</label>
    <input type="text" id="correo" name="correo" required><br><br>
    <label for="contrasenia">Contraseña:</label>
    <input type="password" id="contrasenia" name="contrasenia" required><br><br>
    <div>
        <button id="login" type="submit">Iniciar Sesión</button>
    </div>
</form>

<script>
    window.addEventListener("DOMContentLoaded", () => {
        const form = document.getElementById("user-form");
        const btn = document.getElementById("login");

        form.addEventListener("submit", function (event){
            btn.innerHTML = `<div class="d-flex justify-content-center">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
            btn.classList.add("disabled");
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                btn.classList.remove("disabled");
                btn.innerHTML = 'INICIAR SESIÓN';
            }
            form.classList.add("was-validated");
        }, false);
        const urlParams = new URLSearchParams(window.location.search);
        const result = urlParams.get('result');
        const mensaje = urlParams.get('message');
        if (result === 'true') {
            Swal.fire('¡Éxito!', mensaje, 'success');
        }
    }, false);
</script>

</body>
</html>
