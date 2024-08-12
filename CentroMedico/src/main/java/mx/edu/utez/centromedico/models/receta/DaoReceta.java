package mx.edu.utez.centromedico.models.receta;

import mx.edu.utez.centromedico.models.medicos.BeanMedico;
import mx.edu.utez.centromedico.models.pacientes.BeanPacientes;
import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DaoReceta {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

    public List<BeanReceta> findAllReceta(){
        List<BeanReceta> recetas = new ArrayList<>();

        try{
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM receta";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();

            while(rs.next()){
                BeanReceta receta = new BeanReceta();
                receta.setIdReceta(rs.getLong("idReceta"));
                receta.setFecha(rs.getDate("Fecha"));
                receta.setMedicamentos(rs.getString("Medicamentos"));
                receta.setDosis(rs.getString("Dosis"));
                receta.setInstrucciones(rs.getString("Instrucciones"));
                receta.setIdPaciente(rs.getInt("idPaciente"));
                BeanPacientes paciente = new BeanPacientes();
                paciente.setNombre(rs.getString("nombre"));
                receta.setIdMedico(rs.getInt("idMedico"));
                BeanMedico medico = new BeanMedico();
                medico.setNombreMedico(rs.getString("nombreMedico"));
                recetas.add(receta);
            }
            return recetas;
        }catch (SQLException e){
            Logger.getLogger(DaoReceta.class.getName()).log(Level.SEVERE, "Error findAllRecetas " + e.getMessage());
    }finally {
        close();
        }
        return null;
        }

        public boolean saveReceta(BeanReceta receta){
        try{
            conn = new MySQLConnection().connect();
            String query = "{CALL GenerarReceta(?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setInt(1, receta.getIdPaciente());
            cs.setInt(2, receta.getIdMedico());
            cs.setDate(3, receta.getFecha());
            cs.setString(4, receta.getMedicamentos());
            cs.setString(5, receta.getDosis());
            cs.setString(6, receta.getInstrucciones());
            cs.executeUpdate();
        }catch(SQLException e){
            Logger.getLogger(DaoReceta.class.getName()).log(Level.SEVERE, "Error saveReceta " + e.getMessage());
        }finally {
            close();
        }
            return false;
        }


    public void close() {
        try {
            if (conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        } catch (SQLException e) {

        }

    }

}