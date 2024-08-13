package mx.edu.utez.centromedico.models.citas;

import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoCita {
    private Connection conn;
    private PreparedStatement pstm;

    public boolean confirmarCita(int idPaciente, int idMedico, Date fechaCita) {
        boolean isConfirmed = false;
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO Citas (idPaciente, idMedico, FechaCita) VALUES (?, ?, ?)";
            pstm = conn.prepareStatement(query);
            pstm.setInt(1, idPaciente);
            pstm.setInt(2, idMedico);
            pstm.setDate(3, fechaCita);

            int rowsAffected = pstm.executeUpdate();
            isConfirmed = rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoCita.class.getName()).log(Level.SEVERE, "Error al confirmar cita: " + e.getMessage(), e);
        } finally {
            closeResources();
        }
        return isConfirmed;
    }

    private void closeResources() {
        try {
            if (pstm != null) pstm.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoCita.class.getName()).log(Level.SEVERE, "Error al cerrar recursos: " + e.getMessage(), e);
        }
    }
}
