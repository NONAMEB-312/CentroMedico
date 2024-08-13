<%@ page import="mx.edu.utez.centromedico.models.pacientes.Paciente" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Pacientes</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .modal-header .close {
            margin-top: -1.5rem;
        }
    </style>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">Centro Médico - Admin</div>
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
    <div class="d-flex justify-content-between align-items-center">
        <h1>Pacientes Registrados</h1>
        <button class="btn btn-success" data-toggle="modal" data-target="#addPacienteModal"><i class="fas fa-plus"></i> Agregar Paciente</button>
    </div>
    <table class="table table-bordered mt-3">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido Paterno</th>
            <th>Apellido Materno</th>
            <th>Fecha Nacimiento</th>
            <th>Padecimientos</th>
            <th>Receta</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Paciente> pacienteList = (List<Paciente>) request.getAttribute("pacienteList");
            if (pacienteList != null) {
                for (Paciente paciente : pacienteList) {
        %>
        <tr>
            <td><%= paciente.getIdPaciente() %></td>
            <td><%= paciente.getNombrePaciente() %></td>
            <td><%= paciente.getApellidoPaterno() %></td>
            <td><%= paciente.getApellidoMaterno() %></td>
            <td><%= paciente.getFechaNacimiento() %></td>
            <td><%= paciente.getPadecimientos() %></td>
            <td><%= paciente.getReceta() %></td>
            <td>
                <div class="btn-group" role="group" aria-label="Acciones">
                    <button type="button" class="btn btn-warning" onclick="abrirModalModificar(<%= paciente.getIdPaciente() %>, '<%= paciente.getNombrePaciente() %>', '<%= paciente.getApellidoPaterno() %>', '<%= paciente.getApellidoMaterno() %>',
                            '<%= paciente.getFechaNacimiento()%>','<%=paciente.getPadecimientos()%>','<%=paciente.getReceta()%>')"> <i class="fas fa-edit"></i>Modificar</button>
                    <button type="button" class="btn btn-danger" onclick="confirmarEliminarPaciente(<%= paciente.getIdPaciente() %>)"> <i class="fas fa-trash"></i>Eliminar</button>
                </div>
            </td>

        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <a href="${pageContext.request.contextPath}/admin.jsp" class="btn btn-secondary">Regresar</a>
</main>

<!-- Modal para agregar paciente -->
<div class="modal fade" id="addPacienteModal" tabindex="-1" role="dialog" aria-labelledby="addPacienteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addPacienteModalLabel">Agregar Nuevo Paciente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addPacienteForm" action="${pageContext.request.contextPath}/pacientes/register" method="post">
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
                        <textarea class="form-control" id="padecimientos" name="padecimientos" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="receta">Receta:</label>
                        <textarea class="form-control" id="receta" name="receta" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal para modificar paciente -->
<div class="modal fade" id="modalModificarPaciente" tabindex="-1" role="dialog" aria-labelledby="modalModificarPacienteLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalModificarPacienteLabel">Modificar Paciente</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/pacientes/update" method="post" id="formModificarPaciente">
                    <input type="hidden" id="modIdPaciente" name="id">
                    <div class="form-group">
                        <label for="modNombre">Nombre:</label>
                        <input type="text" class="form-control" id="modNombre" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="modApaterno">Apellido Paterno:</label>
                        <input type="text" class="form-control" id="modApaterno" name="apaterno" required>
                    </div>
                    <div class="form-group">
                        <label for="modAmaterno">Apellido Materno:</label>
                        <input type="text" class="form-control" id="modAmaterno" name="amaterno" required>
                    </div>
                    <div class="form-group">
                        <label for="modFechaNac">Fecha de Nacimiento:</label>
                        <input type="date" class="form-control" id="modFechaNac" name="fechanac" required>
                    </div>
                    <div class="form-group">
                        <label for="modPadecimientos">Padecimientos:</label>
                        <input type="text" class="form-control" id="modPadecimientos" name="padecimientos" required>
                    </div>
                    <div class="form-group">
                        <label for="modReceta">Receta:</label>
                        <input type="text" class="form-control" id="modReceta" name="receta" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-primary" onclick="confirmarModificarPaciente()">Guardar Cambios</button>
            </div>
        </div>
    </div>
</div>


<script>
    // Función para abrir el modal de modificación y llenar los campos con los datos actuales del paciente
    function abrirModalModificar(idPaciente, nombre, apaterno, amaterno, fechanac, padecimientos, receta) {
        document.getElementById('modIdPaciente').value = idPaciente;
        document.getElementById('modNombre').value = nombre;
        document.getElementById('modApaterno').value = apaterno;
        document.getElementById('modAmaterno').value = amaterno;
        document.getElementById('modFechaNac').value = fechanac;
        document.getElementById('modPadecimientos').value = padecimientos;
        document.getElementById('modReceta').value = receta;

        $('#modalModificarPaciente').modal('show');
    }

    // Función para confirmar la modificación del paciente
    function confirmarModificarPaciente() {

        if (confirm("¿Estás seguro de modificar este paciente?")) {
            // Enviar el formulario de modificación al servidor
            document.getElementById('formModificarPaciente').submit();
        }
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


    document.getElementById('addPacienteForm').addEventListener('submit', function(event) {
        event.preventDefault();
        Swal.fire({
            title: '¿Estás seguro?',
            text: "¿Deseas registrar este paciente?",
            icon: 'question',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, registrar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                this.submit();
            }
        });
    });
</script>
<script>
    // Función para abrir el modal de modificación y llenar los campos con los datos actuales del paciente
    function abrirModalModificar(idPaciente, nombre, apaterno, amaterno, fechanac, padecimientos, receta) {
        document.getElementById('modIdPaciente').value = idPaciente;
        document.getElementById('modNombre').value = nombre;
        document.getElementById('modApaterno').value = apaterno;
        document.getElementById('modAmaterno').value = amaterno;
        document.getElementById('modFechaNac').value = fechanac;
        document.getElementById('modPadecimientos').value = padecimientos;
        document.getElementById('modReceta').value = receta;

        $('#modalModificarPaciente').modal('show'); // Utilizando jQuery para abrir el modal
    }

    // Función para confirmar la modificación del paciente con SweetAlert2
    function confirmarModificarPaciente() {
        // Ejemplo de alerta de confirmación con SweetAlert2
        Swal.fire({
            title: '¿Estás seguro?',
            text: "Se modificarán los datos del paciente. ¿Deseas continuar?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, modificar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Enviar el formulario de modificación al servidor
                document.getElementById('formModificarPaciente').submit();
            }
        });
    }
</script>
<script>
    // Función para confirmar la eliminación del paciente con SweetAlert2
    function confirmarEliminarPaciente(id) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "No podrás revertir esto. ¿Deseas eliminar al paciente?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, eliminar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Enviar solicitud de eliminación al servidor
                fetch(`/CentroMedico_war/pacientes/delete`, {
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
                                'El paciente ha sido eliminado.',
                                'success'
                            ).then(() => {
                                // Recargar la página o actualizar la tabla de pacientes
                                location.reload();
                            });
                        } else {
                            Swal.fire(
                                'Error!',
                                'Hubo un problema al eliminar el paciente.',
                                'error'
                            );
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        Swal.fire(
                            'Error!',
                            'Hubo un problema al eliminar el paciente.',
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
