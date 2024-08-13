<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/locale/es.js"></script> <!-- Importación de idioma español -->
    <title>Centro Médico - Recepcionista</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-bottom: 20px;
        }
        .logo h2 {
            font-size: 20px;
            margin: 0;
        }
        .nav-button {
            border: none;
            background: none;
            font-size: 16px;
            color: white;
        }
        .modal-content {
            border-radius: 8px;
        }
        .btn {
            border-radius: 4px;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-warning {
            background-color: #ffc107;
            border: none;
        }
        .btn-info {
            background-color: #17a2b8;
            border: none;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
    </style>
</head>
<body>
<header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
        <div class="logo">
            <h2><i class="fas fa-user-md"></i> Centro Médico - Recepcionista</h2>
        </div>
        <nav>
            <ul class="nav">
                <li class="nav-item">
                    <button id="logout-button" class="nav-button"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</button>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main class="container my-5">
    <h1 class="text-center mb-4">Centro Médico - Recepción</h1>

    <!-- Modal para Recibir Paciente -->
    <div class="modal fade" id="recibirPacienteModal" tabindex="-1" role="dialog" aria-labelledby="recibirPacienteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="recibirPacienteModalLabel">Recibir Paciente</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/pacientes/recibir" method="POST">
                        <div class="form-group">
                            <label for="presionArterial">Presión Arterial:</label>
                            <input type="text" class="form-control" id="presionArterial" name="presionArterial" required>
                        </div>
                        <div class="form-group">
                            <label for="temperatura">Temperatura:</label>
                            <input type="text" class="form-control" id="temperatura" name="temperatura" required>
                        </div>
                        <div class="form-group">
                            <label for="edad">Edad:</label>
                            <input type="number" class="form-control" id="edad" name="edad" required>
                        </div>
                        <div class="form-group">
                            <label for="altura">Altura:</label>
                            <input type="text" class="form-control" id="altura" name="altura" required>
                        </div>
                        <div class="form-group">
                            <label for="peso">Peso:</label>
                            <input type="text" class="form-control" id="peso" name="peso" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Registrar Signos Vitales</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Listado de Médicos Asignados -->
    <section id="listado-medicos">
        <h2 class="mt-4 mb-3">Médicos Asignados <i class="fas fa-user-md"></i></h2>
        <div class="card">
            <div class="card-body">
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dr. Juan Pérez
                        <div>
                            <button class="btn btn-warning btn-sm mr-2">Cambiar</button>
                            <button class="btn btn-info btn-sm">Editar</button>
                        </div>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dra. María López
                        <div>
                            <button class="btn btn-warning btn-sm mr-2">Cambiar</button>
                            <button class="btn btn-info btn-sm">Editar</button>
                        </div>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        Dr. Carlos Fernández
                        <div>
                            <button class="btn btn-warning btn-sm mr-2">Cambiar</button>
                            <button class="btn btn-info btn-sm">Editar</button>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <!-- Consultar Calendario de Disponibilidad del Médico -->
    <section id="consultar-calendario" class="mt-5">
        <h2 class="mb-3">Consultar Calendario de Disponibilidad <i class="fas fa-calendar-alt"></i></h2>
        <div class="card">
            <div class="card-body">
                <div id="calendar"></div>
            </div>
        </div>
    </section>

    <!-- Administración de Citas -->
    <section id="administracion-citas" class="mt-5">
        <h2 class="mb-3">Administración de Citas <i class="fas fa-calendar-check"></i></h2>
        <div class="card bg-warning text-white text-center" style="cursor: pointer;" data-toggle="modal" data-target="#citasModal">
            <div class="card-body">
                <h5 class="card-title">Gestionar Citas</h5>
                <p class="card-text">Haz clic aquí para administrar las citas.</p>
            </div>
        </div>
    </section>

    <!-- Modal para Administrar Citas -->
    <div class="modal fade" id="citasModal" tabindex="-1" role="dialog" aria-labelledby="citasModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="citasModalLabel">Administrar Citas</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/citas/confirmar" method="POST">
                        <div class="form-group">
                            <label for="nombrePaciente">Nombre:</label>
                            <input type="text" class="form-control" id="nombrePaciente" name="nombrePaciente" required>
                        </div>
                        <div class="form-group">
                            <label for="fechaCita">Fecha:</label>
                            <input type="date" class="form-control" id="fechaCita" name="fechaCita" required>
                        </div>
                        <div class="form-group">
                            <label for="horaCita">Hora:</label>
                            <input type="time" class="form-control" id="horaCita" name="horaCita" required>
                        </div>
                        <div class="form-group">
                            <label for="confirmada">Confirmada:</label>
                            <select class="form-control" id="confirmada" name="confirmada" required>
                                <option value="true">Sí</option>
                                <option value="false">No</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Confirmar y Registrar Cita</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script de SweetAlert2 y evento del botón de cierre de sesión -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(document).ready(function() {
            // Inicializar el calendario en español
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                editable: true,
                locale: 'es', // Cambia el calendario a español
                events: [
                    // Ejemplo de eventos
                    {
                        title: 'Cita con Dr. Juan Pérez',
                        start: '2024-08-15T10:30:00',
                        end: '2024-08-15T11:30:00'
                    },
                    {
                        title: 'Cita con Dra. María López',
                        start: '2024-08-16T12:00:00',
                        end: '2024-08-16T13:00:00'
                    }
                ]
            });

            $('#logout-button').click(function() {
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: "¡Cerrarás la sesión!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí, cerrar sesión'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = '${pageContext.request.contextPath}/index.jsp';
                    }
                });
            });
        });
    </script>
</main>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
