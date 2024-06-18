<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <title>Registrar Paciente</title>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">Centro Médico - Recepcionista</div>
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
    <h1>Registrar Paciente</h1>
    <form action="${pageContext.request.contextPath}/pacientes/register" method="POST">
        <div class="form-group">
            <label for="nombrePaciente">Nombre:</label>
            <input type="text" class="form-control" id="nombrePaciente" name="nombrePaciente" required>
        </div>
        <div class="form-group">
            <label for="apellidoPaterno">Apellido Paterno:</label>
            <input type="text" class="form-control" id="apellidoPaterno" name="apellidoPaterno" required>
        </div>
        <div class="form-group">
            <label for="apellidoMaterno">Apellido Materno:</label>
            <input type="text" class="form-control" id="apellidoMaterno" name="apellidoMaterno" required>
        </div>
        <div class="form-group">
            <label for="fechaNacimiento">Fecha de Nacimiento:</label>
            <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required>
        </div>
        <div class="form-group">
            <label for="padecimientos">Padecimientos:</label>
            <textarea class="form-control" id="padecimientos" name="padecimientos" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label for="receta">Receta:</label>
            <textarea class="form-control" id="receta" name="receta" rows="3" required></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Registrar Paciente</button>
    </form>

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
