package mx.edu.utez.centromedico.models.pacientes;

import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoPaciente {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

    public List<Paciente> getAllPacientes() {
        List<Paciente> pacienteList = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM Pacientes";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Paciente paciente = new Paciente();
                paciente.setIdPaciente(rs.getInt("idPacientes"));
                paciente.setNombrePaciente(rs.getString("Nombre"));
                paciente.setApellidoPaterno(rs.getString("Apaterno"));
                paciente.setApellidoMaterno(rs.getString("Amaterno"));
                paciente.setFechaNacimiento(rs.getDate("Fechanac"));
                paciente.setPadecimientos(rs.getString("Padecimientos"));
                paciente.setReceta(rs.getString("Receta"));
                pacienteList.add(paciente);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoPaciente.class.getName()).log(Level.SEVERE, "Error al obtener todos los pacientes: " + e.getMessage(), e);
        } finally {
            closeResources();
        }
        return pacienteList;
    }

    public int registrarPaciente(String nombre, String apellidoPaterno, String apellidoMaterno, java.sql.Date fechaNacimiento, String padecimientos, String receta) {
        int idPaciente = -1;
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO Pacientes (Nombre, Apaterno, Amaterno, Fechanac, Padecimientos, Receta) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            pstm = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

            pstm.setString(1, nombre);
            pstm.setString(2, apellidoPaterno);
            pstm.setString(3, apellidoMaterno);
            pstm.setDate(4, fechaNacimiento);
            pstm.setString(5, padecimientos);
            pstm.setString(6, receta);

            int affectedRows = pstm.executeUpdate();
            if (affectedRows > 0) {
                // Obtener el ID generado para el paciente registrado
                ResultSet generatedKeys = pstm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    idPaciente = generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoPaciente.class.getName()).log(Level.SEVERE, "Error al registrar paciente: " + e.getMessage(), e);
        } finally {
            closeResources();
        }
        return idPaciente;
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoPaciente.class.getName()).log(Level.SEVERE, "Error al cerrar recursos: " + e.getMessage(), e);
        }
    }

    public boolean actualizarPaciente(int idPaciente, String nombre, String apellidoPaterno, String apellidoMaterno, java.sql.Date fechaNacimiento, String padecimientos, String receta) {
        boolean isUpdated = false;
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE Pacientes SET Nombre=?, Apaterno=?, Amaterno=?, Fechanac=?, Padecimientos=?, Receta=? WHERE idPacientes=?";
            pstm = conn.prepareStatement(query);

            pstm.setString(1, nombre);
            pstm.setString(2, apellidoPaterno);
            pstm.setString(3, apellidoMaterno);
            pstm.setDate(4, fechaNacimiento);
            pstm.setString(5, padecimientos);
            pstm.setString(6, receta);
            pstm.setInt(7, idPaciente);

            int rowsAffected = pstm.executeUpdate();
            isUpdated = rowsAffected > 0;

        } catch (SQLException e) {
            Logger.getLogger(DaoPaciente.class.getName()).log(Level.SEVERE, "Error al actualizar paciente: " + e.getMessage(), e);
        } finally {
            closeResources();
        }
        return isUpdated;
    }




    public void eliminarPaciente(int idPaciente) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM Pacientes WHERE idPacientes=?";
            pstm = conn.prepareStatement(query);

            pstm.setInt(1, idPaciente);

            pstm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DaoPaciente.class.getName()).log(Level.SEVERE, "Error al eliminar paciente: " + e.getMessage(), e);
        } finally {
            closeResources();
        }
    }

}
