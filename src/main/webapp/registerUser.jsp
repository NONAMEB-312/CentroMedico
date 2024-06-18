<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Registro de Usuario</title>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">Centro Médico - Admin</div>
        <nav>
            <ul class="nav">
                <li class="nav-item">
                    <button id="logout-button" class="btn btn-danger text-white">Cerrar sesión</button>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main class="container my-5">
    <h1>Registrar Usuario</h1>
    <form action="${pageContext.request.contextPath}/users/register" method="POST">
        <div class="form-group">
            <label for="tipo">Rol:</label>
            <select class="form-control" id="tipo" name="tipo" onchange="toggleFields()">
                <option value="Medico">Médico</option>
                <option value="Recepcionista">Recepcionista</option>
            </select>
        </div>
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>
        <div class="form-group">
            <label for="apaterno">Apellido Paterno:</label>
            <input type="text" class="form-control" id="apaterno" name="apaterno" required>
        </div>
        <div class="form-group">
            <label for="amaterno">Apellido Materno:</label>
            <input type="text" class="form-control" id="amaterno" name="amaterno" required>
        </div>
        <div class="form-group">
            <label for="correo">Correo:</label>
            <input type="email" class="form-control" id="correo" name="correo" required>
        </div>
        <div class="form-group">
            <label for="contrasenia">Contraseña:</label>
            <input type="password" class="form-control" id="contrasenia" name="contrasenia" required>
        </div>

        <!-- Campos adicionales para Médico -->
        <div id="medicoFields" style="display: none;">
            <div class="form-group">
                <label for="cedula">Cédula Profesional:</label>
                <input type="text" class="form-control" id="cedula" name="cedula">
            </div>
            <div class="form-group">
                <label for="especialidad">Especialidad:</label>
                <input type="text" class="form-control" id="especialidad" name="especialidad">
            </div>
            <div class="form-group">
                <label for="domicilio">Domicilio:</label>
                <input type="text" class="form-control" id="domicilio" name="domicilio">
            </div>
        </div>

        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-secondary">Regresar</a>
    </form>

    <script>
        function toggleFields() {
            var rol = document.getElementById("tipo").value;
            document.getElementById("medicoFields").style.display = rol === "Medico" ? "block" : "none";
        }
    </script>

    <!-- Script de SweetAlert2 y evento del botón de cierre de sesión -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.getElementById('logout-button').addEventListener('click', function(event) {
            event.preventDefault();
            Swal.fire({
                title: '¿Estás seguro?',
                text: "¡No podrás revertir esto!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, cerrar sesión',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'index.jsp';
                }
            });
        });
    </script>
</main>
</body>
</html>
