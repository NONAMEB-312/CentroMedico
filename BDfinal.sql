create database centromedico;
use centromedico;
drop database centromedico;
-- -----------------------------------------------------
-- Table Rol
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Rol (
  idRol INT PRIMARY KEY,
  tipo VARCHAR(45) NULL
);

-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Usuario (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT,
  Rol_idRol INT NOT NULL,
  Correo VARCHAR(45) NOT NULL,
  Contrasenia VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Usuario_Rol
    FOREIGN KEY (Rol_idRol)
    REFERENCES Rol (idRol)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table Medicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Medicos (
  idMedicos INT PRIMARY KEY AUTO_INCREMENT,
  Usuario_idUsuario INT NOT NULL,
  NombreMedico VARCHAR(45) NOT NULL,
    Apaterno VARCHAR(45) NOT NULL,
    Amaterno VARCHAR(45) NOT NULL,
  Cedula VARCHAR(45) NOT NULL,
  Especialidad VARCHAR(45) NOT NULL,
  Domicilio VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Medicos_Usuario
    FOREIGN KEY (Usuario_idUsuario)
    REFERENCES Usuario (idUsuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table `Receta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Receta (
  idReceta INT PRIMARY KEY AUTO_INCREMENT,
  idPaciente INT NOT NULL,
  idMedico INT NOT NULL,
  Fecha DATE NOT NULL,
  Medicamentos VARCHAR(255) NOT NULL,
  Dosis VARCHAR(255) NOT NULL,
  Instrucciones VARCHAR(255) NOT NULL,
  FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPacientes),
  FOREIGN KEY (idMedico) REFERENCES Medicos(idMedicos)
);

-- -----------------------------------------------------
-- Table Recepcionista
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Recepcionista (
  idRecepcion INT PRIMARY KEY AUTO_INCREMENT,
  Usuario_idUsuario INT NOT NULL,
  NombreRecep VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Recepcionista_Usuario
    FOREIGN KEY (Usuario_idUsuario)
    REFERENCES Usuario (idUsuario)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table Consulta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Consulta (
  idConsulta INT PRIMARY KEY AUTO_INCREMENT,
  Paciente_idPaciente INT NOT NULL,
  Medico_idMedico INT NOT NULL,
  Recepcionista_idRecepcion INT NOT NULL,
  Fecha DATE NOT NULL,
  NombrePaciente VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Consulta_Paciente
    FOREIGN KEY (Paciente_idPaciente)
    REFERENCES Pacientes (idPacientes)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Consulta_Medico
    FOREIGN KEY (Medico_idMedico)
    REFERENCES Medicos (idMedicos)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Consulta_Recepcionista
    FOREIGN KEY (Recepcionista_idRecepcion)
    REFERENCES Recepcionista (idRecepcion)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table Pacientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pacientes (
  idPacientes INT PRIMARY KEY AUTO_INCREMENT,
  Nombre VARCHAR(45) NOT NULL,
  Apaterno VARCHAR(45) NOT NULL,
  Amaterno VARCHAR(45) NOT NULL,
  Fechanac DATE NOT NULL,
  Padecimientos VARCHAR(100) NOT NULL
);

-- -----------------------------------------------------
-- Table Centromedico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Centromedico (
  idCentromedico INT PRIMARY KEY AUTO_INCREMENT,
  Localizacion VARCHAR(45) NOT NULL
);

-- -----------------------------------------------------
-- Table Citas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Citas (
  idCitas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Recepcion_idRecepcion INT NOT NULL,
  Medicos_idMedicos INT NOT NULL,
  Pacientes_idPacientes INT NOT NULL,
  Centromedico_idCentromedico INT NOT NULL,
  Dia VARCHAR(15) NOT NULL,
  Hora TIME NOT NULL,
  CONSTRAINT fk_Citas_Recepcion
    FOREIGN KEY (Recepcion_idRecepcion)
    REFERENCES Recepcionista (idRecepcion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Citas_Medicos
    FOREIGN KEY (Medicos_idMedicos)
    REFERENCES Medicos (idMedicos)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Citas_Pacientes
    FOREIGN KEY (Pacientes_idPacientes)
    REFERENCES Pacientes (idPacientes)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Citas_Centromedico
    FOREIGN KEY (Centromedico_idCentromedico)
    REFERENCES Centromedico (idCentromedico)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table Dr_asignado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Dr_asignado (
  idtable1 INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Recepcionista_idRecepcion INT NOT NULL,
  Medicos_idMedicos INT NOT NULL,
  CONSTRAINT fk_Dr_asignado_Recepcionista
    FOREIGN KEY (Recepcionista_idRecepcion)
    REFERENCES Recepcionista (idRecepcion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Dr_asignado_Medicos
    FOREIGN KEY (Medicos_idMedicos)
    REFERENCES Medicos (idMedicos)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table Historial_medico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Historial_medico (
  idHistorial_medico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Pacientes_idPacientes INT NOT NULL,
  Citas_idCitas INT NOT NULL,
  CONSTRAINT fk_Historial_medico_Pacientes
    FOREIGN KEY (Pacientes_idPacientes)
    REFERENCES Pacientes (idPacientes)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Historial_medico_Citas
    FOREIGN KEY (Citas_idCitas)
    REFERENCES Citas (idCitas)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Inserciones
INSERT INTO Rol (idRol, tipo) VALUES
(1, 'Admin'),
(2, 'Medico'),
(3, 'Recepcionista');

select * from Rol;

INSERT INTO Usuario (Rol_idRol, Correo, Contrasenia) VALUES
(1, 'admin@example.com', 'adminpass'),
(2, 'medico1@example.com', 'medicopass1'),
(2, 'medico2@example.com', 'medicopass2'),
(3, 'recepcionista1@example.com', 'receppass1'),
(3, 'recepcionista2@example.com', 'receppass2');

select * from Usuario;

INSERT INTO Medicos (Usuario_idUsuario, NombreMedico, Apaterno, Amaterno,Cedula, Especialidad, Domicilio) VALUES
(2, 'Juan', 'Perez', 'Lopez','12345', 'Cardiología', 'Calle 1, Ciudad'),
(3, '67890', 'Pediatría', 'Calle 2, Ciudad', 'Ana', 'Martinez', 'Garcia');

INSERT INTO Recepcionista (Usuario_idUsuario, NombreRecep) VALUES
(4, 'Juan Perez'),
(5, 'Ana Garcia');

INSERT INTO Pacientes (Nombre, Apaterno, Amaterno, Fechanac, Padecimientos) VALUES
('Carlos', 'Sanchez', 'Lopez', '1980-05-20', 'Diabetes'),
('Laura', 'Gomez', 'Martinez', '1992-08-15', 'Hipertensión');

INSERT INTO Consulta (Paciente_idPaciente, Medico_idMedico, Recepcionista_idRecepcion, Fecha, NombrePaciente) VALUES
(1, 1, 1, '2024-06-01', 'Carlos Sanchez'),
(2, 2, 2, '2024-06-02', 'Laura Gomez');

INSERT INTO Centromedico (Localizacion) VALUES
('Centro Medico ABC'),
('Hospital XYZ');

INSERT INTO Citas (Recepcion_idRecepcion, Medicos_idMedicos, Pacientes_idPacientes, Centromedico_idCentromedico, Dia, Hora) VALUES
(1, 1, 1, 1, '2024-06-01', '10:00:00'),
(2, 2, 2, 2, '2024-06-02', '11:00:00');

INSERT INTO Dr_asignado (Recepcionista_idRecepcion, Medicos_idMedicos) VALUES
(1, 1),
(2, 2);

INSERT INTO Historial_medico (Pacientes_idPacientes, Citas_idCitas) VALUES
(1, 1),
(2, 2);


SELECT * FROM Usuario;
SELECT * FROM Medicos;
SELECT * FROM Recepcionista;
SELECT * FROM Pacientes;
SELECT * FROM Centromedico;
SELECT * FROM Citas;
SELECT * FROM Dr_asignado;
SELECT * FROM Historial_medico;
SELECT * FROM Consulta;
SELECT * FROM Citas WHERE Medicos_idMedicos = 1;
SELECT * FROM Citas WHERE Pacientes_idPacientes = 1;
SELECT * FROM Historial_medico WHERE Pacientes_idPacientes = 1;
SELECT * FROM Historial_medico WHERE Citas_idCitas = 1;

-- Procedimientos almacenados

drop procedure ValidarUsuario;

-- validar usuario
    DELIMITER //

CREATE PROCEDURE ValidarUsuario(
    IN p_correo VARCHAR(45),
    IN p_contrasenia VARCHAR(45),
    IN p_tipo VARCHAR(45),
    OUT p_valido BOOLEAN,
    OUT p_idUsuario INT
)
BEGIN
    DECLARE v_idRol INT;

    -- Initialize the output variables
    SET p_valido = FALSE;
    SET p_idUsuario = NULL;

    -- Get the idRol for the given tipo
    SELECT idRol INTO v_idRol
    FROM Rol
    WHERE tipo = p_tipo;

    -- Validate user credentials based on correo, contrasenia and Rol_idRol
    SELECT idUsuario INTO p_idUsuario
    FROM Usuario
    WHERE Correo = p_correo
    AND Contrasenia = p_contrasenia
    AND Rol_idRol = v_idRol;

    -- If a user is found, set p_valido to TRUE
    IF p_idUsuario IS NOT NULL THEN
        SET p_valido = TRUE;
    END IF;
END //

DELIMITER ;

SET @valido = FALSE;
SET @idUsuario = NULL;

CALL ValidarUsuario('medico1@example.com', 'medicopass1', 'Medico', @valido, @idUsuario);

SELECT @valido AS EsValido, @idUsuario AS IdUsuario;

-- procedminiento para registrar un medico

drop procedure RegistrarUsuario;
DELIMITER //

CREATE PROCEDURE RegistrarUsuario(
    IN p_correo VARCHAR(45),
    IN p_contrasenia VARCHAR(45),
    IN p_tipo VARCHAR(45),
    IN p_nombre VARCHAR(45),
    IN p_apaterno VARCHAR(45),
    IN p_amaterno VARCHAR(45),
    IN p_cedula VARCHAR(45),
    IN p_especialidad VARCHAR(45),
    IN p_domicilio VARCHAR(45),
    OUT p_idUsuario INT
)
BEGIN
    DECLARE v_idRol INT;
    DECLARE v_idUsuario INT;

    -- Initialize the output variable
    SET p_idUsuario = NULL;

    -- Get the idRol for the given tipo
    SELECT idRol INTO v_idRol
    FROM Rol
    WHERE tipo = p_tipo;

    -- Insert the new user into the Usuario table
    INSERT INTO Usuario (Rol_idRol, Correo, Contrasenia)
    VALUES (v_idRol, p_correo, p_contrasenia);

    -- Get the idUsuario of the newly inserted user
    SET v_idUsuario = LAST_INSERT_ID();

    -- Depending on the role, insert into the corresponding table
    IF p_tipo = 'medico' THEN
        INSERT INTO Medicos (Usuario_idUsuario, NombreMedico, Apaterno, Amaterno, Cedula, Especialidad, Domicilio)
        VALUES (v_idUsuario, p_nombre, p_apaterno, p_amaterno, p_cedula, p_especialidad, p_domicilio);
    ELSEIF p_tipo = 'recepcionista' THEN
        INSERT INTO Recepcionista (Usuario_idUsuario, NombreRecep)
        VALUES (v_idUsuario, CONCAT(p_nombre, ' '));
    END IF;

    -- Set the output variable
    SET p_idUsuario = v_idUsuario;
END //

DELIMITER ;

-- procedimiento para actualizar un usuario

drop procedure ActualizarUsuario;

DELIMITER //

CREATE PROCEDURE ActualizarUsuario(
    IN p_idUsuario INT,
    IN p_correo VARCHAR(45),
    IN p_contrasenia VARCHAR(45),
    IN p_nombre VARCHAR(45),
    IN p_apaterno VARCHAR(45),
    IN p_amaterno VARCHAR(45),
    IN p_cedula VARCHAR(45),
    IN p_especialidad VARCHAR(45),
    IN p_domicilio VARCHAR(45)
)
BEGIN
    -- Update the user in the Usuario table
    UPDATE Usuario
    SET Correo = p_correo,
        Contrasenia = p_contrasenia
    WHERE idUsuario = p_idUsuario;

    -- Update the user in the corresponding table based on the role
    IF EXISTS (SELECT 1 FROM Medicos WHERE Usuario_idUsuario = p_idUsuario) THEN
        UPDATE Medicos
        SET NombreMedico = p_nombre,
            Apaterno = p_apaterno,
            Amaterno = p_amaterno,
            Cedula = p_cedula,
            Especialidad = p_especialidad,
            Domicilio = p_domicilio
        WHERE Usuario_idUsuario = p_idUsuario;
    ELSE
        UPDATE Recepcionista
        SET NombreRecep = CONCAT(p_nombre, ' ', p_apaterno, ' ', p_amaterno)
        WHERE Usuario_idUsuario = p_idUsuario;
    END IF;
END //

DELIMITER ;



DESCRIBE Usuario;
DESCRIBE Medicos;
DESCRIBE Recepcionista;
select * from usuario;
select * from Recepcionista;
select * from medicos;



-- fin

-- Eliminar usuario
DELIMITER //

CREATE PROCEDURE EliminarUsuario(
    IN p_idUsuario INT
)
BEGIN
    -- Eliminar el usuario de la tabla Usuario
    DELETE FROM Usuario WHERE idUsuario = p_idUsuario;
END //

DELIMITER ;

-- fin

DELIMITER //

CREATE PROCEDURE AsignarMedicoARecepcionista(
    IN p_recepcionista_id INT,
    IN p_medico_id INT
)
BEGIN
    INSERT INTO Dr_asignado (Recepcionista_idRecepcion, Medicos_idMedicos)
    VALUES (p_recepcionista_id, p_medico_id);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE CrearCita(
    IN p_recepcion_id INT,
    IN p_medicos_id INT,
    IN p_pacientes_id INT,
    IN p_centromedico_id INT,
    IN p_dia VARCHAR(15),
    IN p_hora TIME,
    OUT p_idCita INT
)
BEGIN
    -- Initialize the output variable
    SET p_idCita = NULL;

    -- Insert the new cita into the Citas table
    INSERT INTO Citas (Recepcion_idRecepcion, Medicos_idMedicos, Pacientes_idPacientes, Centromedico_idCentromedico, Dia, Hora)
    VALUES (p_recepcion_id, p_medicos_id, p_pacientes_id, p_centromedico_id, p_dia, p_hora);

    -- Get the idCitas of the newly inserted cita
    SET p_idCita = LAST_INSERT_ID();
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RegistrarPaciente(
    IN p_nombre VARCHAR(45),
    IN p_apaterno VARCHAR(45),
    IN p_amaterno VARCHAR(45),
    IN p_fechanac DATE,
    IN p_padecimientos VARCHAR(100),
    OUT p_idPaciente INT
)
BEGIN
    -- Initialize the output variable
    SET p_idPaciente = NULL;

    -- Insert the new patient into the Pacientes table
    INSERT INTO Pacientes (Nombre, Apaterno, Amaterno, Fechanac, Padecimientos)
    VALUES (p_nombre, p_apaterno, p_amaterno, p_fechanac, p_padecimientos);

    -- Get the idPacientes of the newly inserted patient
    SET p_idPaciente = LAST_INSERT_ID();
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE ObtenerHistorialMedico(
    IN p_pacientes_id INT
)
BEGIN
    SELECT hm.idHistorial_medico, hm.Citas_idCitas, c.Dia, c.Hora,
           m.NombreMedico AS Nombre, m.Apaterno, m.Amaterno,
           p.Padecimientos
    FROM Historial_medico hm
    JOIN Citas c ON hm.Citas_idCitas = c.idCitas
    JOIN Medicos m ON c.Medicos_idMedicos = m.idMedicos
    JOIN Pacientes p ON hm.Pacientes_idPacientes = p.idPacientes
    WHERE hm.Pacientes_idPacientes = p_pacientes_id;
END //

DELIMITER ;

-- SP para crear la consulta

DELIMITER //

CREATE PROCEDURE CrearConsulta(
    IN p_Paciente_idPaciente INT,
    IN p_NombrePaciente VARCHAR(45),
    IN p_Fecha DATE,
    IN p_Hora TIME,
    IN p_Medico_idMedico INT,
    IN p_Recepcionista_idRecepcion INT,
    OUT p_Result VARCHAR(255)
)
BEGIN
    DECLARE v_count INT;

    -- Verificar la disponibilidad del médico
    SELECT COUNT(*) INTO v_count
    FROM Citas
    WHERE Medicos_idMedicos = p_Medico_idMedico
    AND Dia = p_Fecha
    AND Hora = p_Hora;

    -- Si el médico no está disponible, devolver un mensaje de error
    IF v_count > 0 THEN
        SET p_Result = 'El médico no está disponible en esa fecha y hora';
    ELSE
        -- Insertar la nueva consulta
        INSERT INTO Consulta (Paciente_idPaciente, Medico_idMedico, Recepcionista_idRecepcion, Fecha, NombrePaciente)
        VALUES (p_Paciente_idPaciente, p_Medico_idMedico, p_Recepcionista_idRecepcion, p_Fecha, p_NombrePaciente);

        -- Insertar la nueva cita
        INSERT INTO Citas (Recepcion_idRecepcion, Medicos_idMedicos, Pacientes_idPacientes, Centromedico_idCentromedico, Dia, Hora)
        VALUES (p_Recepcionista_idRecepcion, p_Medico_idMedico, p_Paciente_idPaciente, 1, p_Fecha, p_Hora);

        SET p_Result = 'Consulta creada exitosamente';
    END IF;
END //

DELIMITER ;

-- generar receta
DELIMITER //

CREATE PROCEDURE GenerarReceta(
    IN p_idPaciente INT,
    IN p_idMedico INT,
    IN p_fecha DATE,
    IN p_medicamentos VARCHAR(255),
    IN p_dosis VARCHAR(255),
    IN p_instrucciones VARCHAR(255),
    OUT p_idReceta INT
)
BEGIN
    -- Insertar la nueva receta
    INSERT INTO Receta (idPaciente, idMedico, Fecha, Medicamentos, Dosis, Instrucciones)
    VALUES (p_idPaciente, p_idMedico, p_fecha, p_medicamentos, p_dosis, p_instrucciones);

    -- Obtener el idReceta de la receta recién insertada
    SET p_idReceta = LAST_INSERT_ID();
END //

DELIMITER ;

CALL GenerarReceta(1, 1, '2024-06-03', 'Medicamento X 1 comprimido cada 8 horas', '1 comprimido', 'Tome con las comidas', @idReceta);

SELECT @idReceta;

SET @result = '';

CALL CrearConsulta(1, 'Carlos Sanchez', '2024-06-03', '10:00:00', 1, 1, @result);

SELECT @result;
