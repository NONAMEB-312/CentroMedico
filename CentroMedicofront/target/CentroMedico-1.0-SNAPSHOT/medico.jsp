<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Centro Médico - Médico</title>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">
            <h2><i class="fas fa-user-md"></i> Centro Médico - Médico</h2>
        </div>
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

    <div class="jumbotron text-center">
        <h1 class="display-4">¡Bienvenido, Doctor!</h1>
        <p class="lead">En este panel puede gestionar sus consultas y pacientes.</p>
    </div>

    <!-- Gestión de Médicos -->
    <div class="card mb-4">
        <div class="card-header bg-info text-white d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#cardMedicos" aria-expanded="false" aria-controls="cardMedicos" style="cursor: pointer;">
            <h3><i class="fas fa-user-md"></i> Gestionar Médicos</h3>
            <i class="fas fa-chevron-down"></i>
        </div>
        <div id="cardMedicos" class="collapse">
            <div class="card-body">
                <!-- Formulario para crear un nuevo médico -->
                <form action="${pageContext.request.contextPath}/medicos" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="form-group">
                        <label for="nombre">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="cedula">Cédula:</label>
                        <input type="text" class="form-control" id="cedula" name="cedula" required>
                    </div>
                    <div class="form-group">
                        <label for="especialidad">Especialidad:</label>
                        <input type="text" class="form-control" id="especialidad" name="especialidad" required>
                    </div>
                    <div class="form-group">
                        <label for="domicilio">Domicilio:</label>
                        <input type="text" class="form-control" id="domicilio" name="domicilio" required>
                    </div>
                    <div class="form-group">
                        <label for="horarios">Horarios de Atención:</label>
                        <input type="text" class="form-control" id="horarios" name="horarios" required>
                    </div>
                    <div class="form-group">
                        <label for="coordenadas">Coordenadas:</label>
                        <input type="text" class="form-control" id="coordenadas" name="coordenadas" required>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Guardar Médico</button>
                </form>

                <!-- Tabla para listar médicos registrados -->
                <hr>
                <h4 class="mt-4">Médicos Registrados</h4>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Cédula</th>
                        <th>Especialidad</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="medico" items="${medicosList}">
                        <tr>
                            <td>${medico.nombre}</td>
                            <td>${medico.cedula}</td>
                            <td>${medico.especialidad}</td>
                            <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalGestionarMedico" data-id="${medico.id}" data-nombre="${medico.nombre}" data-cedula="${medico.cedula}" data-especialidad="${medico.especialidad}" data-domicilio="${medico.domicilio}" data-horarios="${medico.horarios}" data-coordenadas="${medico.coordenadas}">
                                    <i class="fas fa-edit"></i> Editar
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Confirmar y Registrar Cita -->
    <div class="card mb-4">
        <div class="card-header bg-info text-white d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#cardCitas" aria-expanded="false" aria-controls="cardCitas" style="cursor: pointer;">
            <h3><i class="fas fa-calendar-check"></i> Confirmar y Registrar Cita</h3>
            <i class="fas fa-chevron-down"></i>
        </div>
        <div id="cardCitas" class="collapse">
            <div class="card-body">
                <!-- Historial de Pacientes -->
                <h4>Historial de Pacientes</h4>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Confirmada</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Aquí va el loop para listar las citas del paciente -->
                    <c:forEach var="cita" items="${citasList}">
                        <tr>
                            <td>${cita.nombre}</td>
                            <td>${cita.fecha}</td>
                            <td>${cita.hora}</td>
                            <td>${cita.confirmada}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Formulario para confirmar y registrar cita -->
                <form action="${pageContext.request.contextPath}/citas" method="POST">
                    <input type="hidden" name="action" value="confirmarRegistrar">
                    <div class="form-group">
                        <label for="nombreCita">Nombre:</label>
                        <input type="text" class="form-control" id="nombreCita" name="nombreCita" required>
                    </div>
                    <div class="form-group">
                        <label for="fecha">Fecha:</label>
                        <input type="date" class="form-control" id="fecha" name="fecha" required>
                    </div>
                    <div class="form-group">
                        <label for="hora">Hora:</label>
                        <input type="time" class="form-control" id="hora" name="hora" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmada">Confirmada:</label>
                        <select class="form-control" id="confirmada" name="confirmada" required>
                            <option value="Sí">Sí</option>
                            <option value="No">No</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="fas fa-check"></i> Confirmar y Registrar Cita</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Atender Paciente -->
    <div class="card mb-4">
        <div class="card-header bg-info text-white d-flex justify-content-between align-items-center" data-toggle="collapse" data-target="#cardPacientes" aria-expanded="false" aria-controls="cardPacientes" style="cursor: pointer;">
            <h3><i class="fas fa-notes-medical"></i> Atender Paciente</h3>
            <i class="fas fa-chevron-down"></i>
        </div>
        <div id="cardPacientes" class="collapse">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/consultas" method="POST">
                    <input type="hidden" name="action" value="atenderPaciente">

                    <!-- Campos adicionales -->
                    <div class="form-group">
                        <label for="nombrePaciente">Nombre del Paciente:</label>
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

                    <!-- Información adicional de la consulta -->
                    <div class="form-group">
                        <label for="sintomas">Síntomas:</label>
                        <textarea class="form-control" id="sintomas" name="sintomas" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="diagnostico">Diagnóstico:</label>
                        <textarea class="form-control" id="diagnostico" name="diagnostico" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="medicamentos">Medicamentos y Dosis:</label>
                        <textarea class="form-control" id="medicamentos" name="medicamentos" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="recomendaciones">Recomendaciones:</label>
                        <textarea class="form-control" id="recomendaciones" name="recomendaciones" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Guardar Consulta</button>
                </form>
            </div>
        </div>
    </div>
</main>

<!-- Modal para gestionar médico -->
<div class="modal fade" id="modalGestionarMedico" tabindex="-1" role="dialog" aria-labelledby="modalGestionarMedicoLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalGestionarMedicoLabel">Editar Médico</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="formEditarMedico" action="${pageContext.request.contextPath}/medicos" method="POST">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" id="medicoId" name="id">
                    <div class="form-group">
                        <label for="editNombre">Nombre:</label>
                        <input type="text" class="form-control" id="editNombre" name="nombre" required>
                    </div>
                    <div class="form-group">
                        <label for="editCedula">Cédula:</label>
                        <input type="text" class="form-control" id="editCedula" name="cedula" required>
                    </div>
                    <div class="form-group">
                        <label for="editEspecialidad">Especialidad:</label>
                        <input type="text" class="form-control" id="editEspecialidad" name="especialidad" required>
                    </div>
                    <div class="form-group">
                        <label for="editDomicilio">Domicilio:</label>
                        <input type="text" class="form-control" id="editDomicilio" name="domicilio" required>
                    </div>
                    <div class="form-group">
                        <label for="editHorarios">Horarios de Atención:</label>
                        <input type="text" class="form-control" id="editHorarios" name="horarios" required>
                    </div>
                    <div class="form-group">
                        <label for="editCoordenadas">Coordenadas:</label>
                        <input type="text" class="form-control" id="editCoordenadas" name="coordenadas" required>
                    </div>
                    <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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

    $('#modalGestionarMedico').on('show.bs.modal', function(event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');
        var nombre = button.data('nombre');
        var cedula = button.data('cedula');
        var especialidad = button.data('especialidad');
        var domicilio = button.data('domicilio');
        var horarios = button.data('horarios');
        var coordenadas = button.data('coordenadas');

        var modal = $(this);
        modal.find('#medicoId').val(id);
        modal.find('#editNombre').val(nombre);
        modal.find('#editCedula').val(cedula);
        modal.find('#editEspecialidad').val(especialidad);
        modal.find('#editDomicilio').val(domicilio);
        modal.find('#editHorarios').val(horarios);
        modal.find('#editCoordenadas').val(coordenadas);
    });
</script>

</body>
</html>
