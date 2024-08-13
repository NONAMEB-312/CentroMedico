<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="mx.edu.utez.centromedico.models.user.User" %>
<%@ page import="mx.edu.utez.centromedico.models.rol.Rol" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Usuarios Registrados</title>
    <style>
        .header-logo {
            font-size: 1.5rem;
        }
        .search-box {
            max-width: 400px;
            margin-bottom: 20px;
        }
        .table-wrapper {
            margin-top: 20px;
        }
        .table thead {
            background-color: #1a1a3d;
            color: white;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }
        .table-striped tbody tr:nth-of-type(even) {
            background-color: #f1f1f1;
        }
        .d-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
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
<div class="container mt-5">
    <div class="d-flex">
        <h1>Usuarios Registrados</h1>
        <div class="search-box">
            <input type="text" id="searchInput" class="form-control" placeholder="Buscar usuario...">
        </div>
    </div>
    <div class="table-wrapper">
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>ID</th>
                <th>Correo</th>
                <th>Rol</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody id="userTable">
            <%
                List<User> userList = (List<User>) request.getAttribute("userList");
                if (userList != null) {
                    for (User user : userList) {
            %>
            <tr>
                <td><%= user.getIdUsuario() %></td>
                <td><%= user.getCorreo() %></td>
                <td><%= user.getRol().getTipo() %></td>
                <td>
                    <button type="button" class="btn btn-danger" onclick="confirmarEliminarUsuario(<%= user.getIdUsuario() %>)">
                        <i class="fas fa-trash"></i> Eliminar
                    </button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4">No hay usuarios registrados.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-secondary">Regresar</a>
</div>

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
                window.location.href = '${pageContext.request.contextPath}/index.jsp';
            }
        });
    });

    document.getElementById('searchInput').addEventListener('keyup', function() {
        var searchValue = this.value.toLowerCase();
        var rows = document.querySelectorAll('#userTable tr');

        rows.forEach(function(row) {
            var cells = row.querySelectorAll('td');
            var match = false;

            cells.forEach(function(cell) {
                if (cell.textContent.toLowerCase().indexOf(searchValue) > -1) {
                    match = true;
                }
            });

            if (match) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>

<script>
    // Función para confirmar la eliminación del usuario con SweetAlert2
    function confirmarEliminarUsuario(id) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "No podrás revertir esto. ¿Deseas eliminar al usuario?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Enviar solicitud de eliminación al servidor
                fetch(`/CentroMedico_war/users/delete`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams({
                        'id': id
                    })
                })
                    .then(response => {
                        if (response.ok) {
                            Swal.fire(
                                'Eliminado!',
                                'El usuario ha sido eliminado.',
                                'success'
                            ).then(() => {
                                // Recargar la página o actualizar la tabla de usuarios
                                location.reload();
                            });
                        } else {
                            Swal.fire(
                                'Error!',
                                'Hubo un problema al eliminar el usuario.',
                                'error'
                            );
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        Swal.fire(
                            'Error!',
                            'Hubo un problema al eliminar el usuario.',
                            'error'
                        );
                    });
            }
        });
    }
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>
