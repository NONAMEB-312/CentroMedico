<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Registro de Usuario</title>
    <style>
        body {
            background-color: #f2f2f2;
        }
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .logo i {
            margin-right: 10px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            font-weight: bold;
            margin-bottom: 8px;
        }
        .form-group input, .form-group select {
            border-radius: 5px;
            padding: 10px 15px;
        }
        .btn {
            border-radius: 5px;
            padding: 10px 25px;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004a9e;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
            border-color: #4e555b;
        }
    </style>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo"><i class="fas fa-hospital"></i>Centro Médico - Admin</div>
        <nav>
            <ul class="nav">
                <li class="nav-item">
                    <button id="logout-button" class="btn btn-danger text-white"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</button>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main class="container my-5">
    <div class="form-container">
        <div class="logo"><i class="fas fa-user-plus"></i>Registrar Usuario</div>
        <form id="registrationForm" action="${pageContext.request.contextPath}/users/register" method="POST" onsubmit="return validateForm(event)">
            <div class="form-group">
                <label for="tipo"><i class="fas fa-user-tag"></i> Rol:</label>
                <select class="form-control" id="tipo" name="tipo" onchange="toggleFields()">
                    <option value="Medico">Médico</option>
                    <option value="Recepcionista">Recepcionista</option>
                </select>
            </div>
            <div class="form-group">
                <label for="nombre"><i class="fas fa-user"></i> Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="form-group">
                <label for="apaterno"><i class="fas fa-user"></i> Apellido Paterno:</label>
                <input type="text" class="form-control" id="apaterno" name="apaterno" required>
            </div>
            <div class="form-group">
                <label for="amaterno"><i class="fas fa-user"></i> Apellido Materno:</label>
                <input type="text" class="form-control" id="amaterno" name="amaterno" required>
            </div>
            <div class="form-group">
                <label for="correo"><i class="fas fa-envelope"></i> Correo:</label>
                <input type="email" class="form-control" id="correo" name="correo" required>
            </div>
            <div class="form-group">
                <label for="contrasenia"><i class="fas fa-lock"></i> Contraseña:</label>
                <input type="password" class="form-control" id="contrasenia" name="contrasenia" required>
            </div>

            <!-- Campos adicionales para Médico -->
            <div id="medicoFields" style="display: none;">
                <div class="form-group">
                    <label for="cedula"><i class="fas fa-id-card"></i> Cédula Profesional:</label>
                    <input type="text" class="form-control" id="cedula" name="cedula">
                </div>
                <div class="form-group">
                    <label for="especialidad"><i class="fas fa-stethoscope"></i> Especialidad:</label>
                    <input type="text" class="form-control" id="especialidad" name="especialidad">
                </div>
                <div class="form-group">
                    <label for="domicilio"><i class="fas fa-map-marker-alt"></i> Domicilio:</label>
                    <input type="text" class="form-control" id="domicilio" name="domicilio">
                </div>
            </div>

            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Guardar</button>
            <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Regresar</a>
        </form>
    </div>
</main>

<script>
    function toggleFields() {
        var rol = document.getElementById("tipo").value;
        var medicoFields = document.getElementById("medicoFields");
        var inputs = medicoFields.getElementsByTagName("input");

        if (rol === "Medico") {
            medicoFields.style.display = "block";
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].required = true;
            }
        } else {
            medicoFields.style.display = "none";
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].required = false;
            }
        }
    }

    function validateForm(event) {
        event.preventDefault(); // Prevenir el envío automático del formulario

        var rol = document.getElementById("tipo").value;
        if (rol === "Medico") {
            var cedula = document.getElementById("cedula").value;
            if (!/^\d{8}$/.test(cedula)) {
                alert("Por favor, ingrese una cédula profesional válida de 8 dígitos.");
                return false;
            }
        }

        Swal.fire({
            title: '¿Estás seguro?',
            text: "¿Quieres registrar este usuario?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#007bff',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, registrar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '¡Usuario guardado con éxito!',
                    text: "El usuario ha sido registrado correctamente.",
                    icon: 'success',
                    confirmButtonColor: '#007bff',
                }).then(() => {
                    document.getElementById("registrationForm").submit(); // Enviar el formulario
                });
            }
        });

        return false; // Prevenir el envío inmediato del formulario
    }
</script>

<script>
    document.getElementById('logout-button').addEventListener('click', function(event) {
        event.preventDefault();
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¡No podrás revertir esto!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#007bff',
            cancelButtonColor: '#6c757d',
            confirmButtonText: 'Sí, cerrar sesión',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'index.jsp';
            }
        });
    });
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
