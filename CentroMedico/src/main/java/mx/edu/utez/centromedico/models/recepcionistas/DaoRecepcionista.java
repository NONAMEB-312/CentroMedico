package mx.edu.utez.centromedico.models.recepcionistas;

import mx.edu.utez.centromedico.models.crud.DaoRepository;
import mx.edu.utez.centromedico.models.pacientes.DaoPacientes;
import mx.edu.utez.centromedico.models.user.User;
import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoRecepcionista implements DaoRepository<BeanRecepcionista> {
    private Connection conn;//Coneccion

    private PreparedStatement pstm; //Es domnde nosotros preparamos la sentencia sql y se pueda leer del lado del sql

    private ResultSet rs;

    @Override
    public List<BeanRecepcionista> findAll() {
        List<BeanRecepcionista> recepcionistas = null;
        try {
            recepcionistas = new ArrayList<>();
            conn = new MySQLConnection().connect(); // Coneccion a la base de datos
            String query = "select * from recepcionista;";//Cosulta que se manda a la base de datos
            pstm = conn.prepareStatement(query);//Prepara la consulta para mandar el query
            rs = pstm.executeQuery();//Trae la consulta y ejecuta el query
            while (rs.next())//Verifica si hay datos
            {
                BeanRecepcionista recepcionista = new BeanRecepcionista();
                recepcionista.setIdRecepcion(rs.getLong("idRecepcion"));
                recepcionista.setNombreRecep(rs.getString("NombreRecep"));
                recepcionista.setUsuario_idUsuario(rs.getInt("Usuario_idUsuario"));
                recepcionistas.add(recepcionista);

            }
        } catch (SQLException e) {
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE, "Error findAll" + e.getMessage());
        }finally {
            close();
        }

        return recepcionistas;
    }

    @Override
    public List<User> searchRole() {
        return null;
    }

    @Override
    public BeanRecepcionista finOne(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from recepcionista r where r.idRecepcion =?";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1 , id);
            rs = pstm.executeQuery();

            if (rs.next())
            {
                BeanRecepcionista recepcionista = new BeanRecepcionista();
                recepcionista.setIdRecepcion(rs.getLong("idRecepcion"));
                recepcionista.setNombreRecep(rs.getString("NombreRecep"));
                recepcionista.setUsuario_idUsuario(rs.getInt("Usuario_idUsuario"));
                return recepcionista;
            }
        }
        catch (SQLException e) {
            Logger.getLogger(DaoRecepcionista.class.getName())
                    .log(Level.SEVERE,"Error findOne" + e.getMessage());
        }finally {
            close();
        }

        return null;
    }

    @Override
    public boolean save(BeanRecepcionista object) {
        return false;
    }

    @Override
    public boolean update(BeanRecepcionista object) throws SQLException {
        return false;
    }

    @Override
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM  p WHERE p.idPacientes = ?";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1 , id);
            return  pstm.executeUpdate()==0;
        }catch ( SQLException e)
        {
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE,"Error findAll" + e.getMessage());

        }finally {
            close();
        }
        return false;
    }
    public void close(){
        try{
            if(conn != null ) conn.close();
            if(pstm != null ) conn.close();
            if(rs != null ) conn.close();


        }catch(SQLException e)
        {
            Logger.getLogger(DaoRecepcionista.class.getName())
                    .log(Level.SEVERE,"Error findAll" + e.getMessage());
        }
    }
    public static void main(String[] args) {
        DaoRecepcionista dao = new DaoRecepcionista();
        //dao.delete(2L);


        dao.findAll().forEach(BeanRecepcionista -> {
            System.out.println("ForEch   id : " + BeanRecepcionista.getIdRecepcion() + "  nombnre : " + BeanRecepcionista.getNombreRecep() + " Paterno : " + BeanRecepcionista.getUsuario_idUsuario()  );
        });

        BeanRecepcionista BeanRecepcionista = dao.finOne(1L);
        System.out.println("ONE   id : " + BeanRecepcionista.getIdRecepcion() + "  nombnre : " + BeanRecepcionista.getNombreRecep() + " Paterno : " + BeanRecepcionista.getUsuario_idUsuario()  );


    }
}


