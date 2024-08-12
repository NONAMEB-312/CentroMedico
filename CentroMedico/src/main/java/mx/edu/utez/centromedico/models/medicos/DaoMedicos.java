package mx.edu.utez.centromedico.models.medicos;

import mx.edu.utez.centromedico.models.crud.DaoRepository;
import mx.edu.utez.centromedico.models.user.DaoUser;
import mx.edu.utez.centromedico.models.user.User;
import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class DaoMedicos implements DaoRepository<BeanMedico> {
    private Connection conn;//Coneccion

    private PreparedStatement pstm; //Es domnde nosotros preparamos la sentencia sql y se pueda leer del lado del sql

    private ResultSet rs;

    @Override
    public List<BeanMedico> findAll() {
        List<BeanMedico> medicos = null;
        try {
            medicos = new ArrayList<>();
            conn = new MySQLConnection().connect(); // Coneccion a la base de datos
            String query = "select * from medicos;";//Cosulta que se manda a la base de datos
            pstm = conn.prepareStatement(query);//Prepara la consulta para mandar el query
            rs = pstm.executeQuery();//Trae la consulta y ejecuta el query
            while (rs.next())//Verifica si hay datos
            {
                BeanMedico medico = new BeanMedico();
                medico.setIdMedico(rs.getLong("idMedicos"));
                medico.setUsuario_idUsuario(rs.getInt("Usuario_idUsuario"));
                medico.setNombreMedico(rs.getString("NombreMedico"));
                medico.setApaterno(rs.getString("Apaterno"));
                medico.setAmaterno(rs.getString("Amaterno"));
                medico.setCedula(rs.getString("Cedula"));
                medico.setEspecialidad(rs.getString("Especialidad"));
                medico.setDomicilio(rs.getString("Domicilio"));

                medicos.add(medico);

            }
        } catch (SQLException e) {
            Logger.getLogger(DaoMedicos.class.getName())
                    .log(Level.SEVERE, "Error findAll" + e.getMessage());
        }finally {
            close();
        }

        return medicos;
    }

    @Override
    public List<User> searchRole() {
        return null;
    }

    @Override
    public BeanMedico finOne(Long id) {
        try {
        conn = new MySQLConnection().connect();
        String query = "SELECT * from Medicos m where m.idMedicos =?";
        pstm = conn.prepareStatement(query);
        pstm.setLong(1 , id);
        rs = pstm.executeQuery();

        if (rs.next())
        {
            BeanMedico medico = new BeanMedico();
            medico.setIdMedico(rs.getLong("idMedicos"));
            medico.setUsuario_idUsuario(rs.getInt("Usuario_idUsuario"));
            medico.setNombreMedico(rs.getString("NombreMedico"));
            medico.setApaterno(rs.getString("Apaterno"));
            medico.setAmaterno(rs.getString("Amaterno"));
            medico.setCedula(rs.getString("Cedula"));
            medico.setEspecialidad(rs.getString("Especialidad"));
            medico.setDomicilio(rs.getString("Domicilio"));
            return medico;
        }
    }
        catch (SQLException e) {
        Logger.getLogger(DaoMedicos.class.getName())
                .log(Level.SEVERE,"Error findOne" + e.getMessage());
    }finally {
        close();
    }

        return null;
    }

    @Override
    public boolean save(BeanMedico object) {
        return false;
    }

    @Override
    public boolean update(BeanMedico object) throws SQLException {
        return false;
    }

    @Override
    public boolean delete(Long id) {
        return false;
    }
    public void close(){
        try{
            if(conn != null ) conn.close();
            if(pstm != null ) conn.close();
            if(rs != null ) conn.close();


        }catch(SQLException e)
        {
            Logger.getLogger(DaoMedicos.class.getName())
                    .log(Level.SEVERE,"Error findAll" + e.getMessage());
        }
    }
    public static void main(String[] args) {
        DaoMedicos dao = new DaoMedicos();
        //dao.delete(9L);
        dao.findAll().forEach(beanMedico -> {
            System.out.println("id : " + beanMedico.getIdMedico() + "  nombre : " + beanMedico.getNombreMedico() + " Domicilio : " + beanMedico.getDomicilio() + " Especialidad : " + beanMedico.getEspecialidad() );
        });

         BeanMedico beanMedico = dao.finOne(4L);
        System.out.println("ONE   id : " + beanMedico.getIdMedico() + "  nombre : " + beanMedico.getNombreMedico() + " Domicilio : " + beanMedico.getDomicilio() + " Especialidad : " + beanMedico.getEspecialidad() );


    }
}

