<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Centro Médico - Admin</title>
    <style>
        body {
            background-color: #f9f8fa;
        }
        .card img {
            height: 200px;
            object-fit: contain;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header-logo {
            font-size: 1.5em;
            font-weight: bold;
        }
        .main-content {
            margin-top: 20px;
        }
        @media (max-width: 768px) {
            .card img {
                height: 150px;
            }
        }
        @media (max-width: 576px) {
            .card img {
                height: 100px;
            }
        }
    </style>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="header-logo">Centro Médico - Admin</div>
        <nav>
            <ul class="nav">
                <li class="nav-item">
                    <button id="logout-button" class="btn btn-danger text-white"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</button>
                </li>
            </ul>
        </nav>
    </div>
</header>

<main class="container main-content">
    <h1 class="text-center">Bienvenido al Panel de Administración</h1>
    <h2 class="text-center">Utilice las siguientes opciones para gestionar el centro médico:</h2>
    <div class="row justify-content-center">
        <div class="col-lg-4 col-md-6 mb-4 d-flex justify-content-center">
            <div class="card h-100 d-flex flex-column">
                <img src="assets/paciente.png" class="card-img-top" alt="Usuarios Registrados">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Pacientes Registrados</h5>
                    <p class="card-text">Ver y gestionar los pacientes registrados.</p>
                    <a href="${pageContext.request.contextPath}/pacientes/list" class="btn btn-info mt-auto"><i class="fas fa-user-injured"></i> Ir a Pacientes</a>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-6 mb-4 d-flex justify-content-center">
            <div class="card h-100 d-flex flex-column">
                <img src="assets/agregar-usuario.png" class="card-img-top" alt="Usuarios">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Agregar Usuario</h5>
                    <p class="card-text">Registrar nuevos usuarios en el sistema.</p>
                    <a href="${pageContext.request.contextPath}/registerUser.jsp" class="btn btn-info mt-auto"><i class="fas fa-user-plus"></i> Agregar Usuario</a>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-6 mb-4 d-flex justify-content-center">
            <div class="card h-100 d-flex flex-column">
                <img src="assets/registro-en-linea.png" class="card-img-top" alt="Usuarios Registrados">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Usuarios Registrados</h5>
                    <p class="card-text">Ver y administrar los usuarios registrados.</p>
                    <a href="${pageContext.request.contextPath}/users/list" class="btn btn-info mt-auto"><i class="fas fa-users"></i> Ver Usuarios</a>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Script de SweetAlert2 y evento del botón de cierre de sesión -->
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
