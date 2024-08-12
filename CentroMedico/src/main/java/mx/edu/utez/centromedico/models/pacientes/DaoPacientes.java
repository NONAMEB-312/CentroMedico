package mx.edu.utez.centromedico.models.pacientes;



        import mx.edu.utez.centromedico.models.crud.DaoRepository;
        import mx.edu.utez.centromedico.models.user.DaoUser;
        import mx.edu.utez.centromedico.models.user.User;
        import mx.edu.utez.centromedico.utils.MySQLConnection;

        import java.sql.*;
        import java.time.LocalDate;
        import java.util.ArrayList;
        import java.util.List;
        import java.util.logging.Level;
        import java.util.logging.Logger;


public class DaoPacientes implements DaoRepository<BeanPacientes> {
    private Connection conn;//Coneccion

    private PreparedStatement pstm; //Es domnde nosotros preparamos la sentencia sql y se pueda leer del lado del sql

    private ResultSet rs;

    @Override
    public List<BeanPacientes> findAll() {
        List<BeanPacientes> pacientes = null;
        try {
            pacientes = new ArrayList<>();
            conn = new MySQLConnection().connect(); // Coneccion a la base de datos
            String query = "select * from pacientes;";//Cosulta que se manda a la base de datos
            pstm = conn.prepareStatement(query);//Prepara la consulta para mandar el query
            rs = pstm.executeQuery();//Trae la consulta y ejecuta el query
            while (rs.next())//Verifica si hay datos
            {
                BeanPacientes paciente = new BeanPacientes();
                paciente.setIdPacientes(rs.getLong("idPacientes"));
                paciente.setNombre(rs.getString("Nombre"));
                paciente.setApaterno(rs.getString("Apaterno"));
                paciente.setAmaterno(rs.getString("Amaterno"));
                paciente.setPadecimientos(rs.getString("Padecimientos"));
                paciente.setFechaNacimiento(rs.getDate("Fechanac").toLocalDate());
                pacientes.add(paciente);

            }
        } catch (SQLException e) {
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE, "Error findAll" + e.getMessage());
        }finally {
            close();
        }

        return pacientes;
    }

    @Override
    public List<User> searchRole() {
        return null;
    }

    @Override
    public BeanPacientes finOne(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from pacientes p where p.idPacientes =?";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1 , id);
            rs = pstm.executeQuery();

            if (rs.next())
            {
                BeanPacientes paciente = new BeanPacientes();
                paciente.setIdPacientes(rs.getLong("idPacientes"));
                paciente.setNombre(rs.getString("Nombre"));
                paciente.setApaterno(rs.getString("Apaterno"));
                paciente.setAmaterno(rs.getString("Amaterno"));
                paciente.setPadecimientos(rs.getString("Padecimientos"));
                paciente.setFechaNacimiento(rs.getDate("Fechanac").toLocalDate());
                return paciente;
            }
        }
        catch (SQLException e) {
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE,"Error findOne" + e.getMessage());
        }finally {
            close();
        }

        return null;
    }

    @Override
    public boolean save(BeanPacientes object) {
        try {
            conn = new MySQLConnection().connect();
            String query = " call RegistrarPaciente(?,?,?,?,?)";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getNombre());
            pstm.setString(2,object.getApaterno());
            pstm.setString(3,object.getAmaterno());
            pstm.setDate(4, Date.valueOf(object.getFechaNacimiento()));
            pstm.setString(5,object.getPadecimientos());



            return  pstm.executeUpdate() == 0 ; //1
        }catch (SQLException e) {
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE,"Error findOne" + e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    @Override
    public boolean update(BeanPacientes object) throws SQLException {
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
            Logger.getLogger(DaoPacientes.class.getName())
                    .log(Level.SEVERE,"Error findAll" + e.getMessage());
        }
    }
    public static void main(String[] args) {
        DaoPacientes dao = new DaoPacientes();
        //dao.delete(2L);
        /*
        BeanPacientes p = new BeanPacientes();
        p.setNombre("Franco");
        p.setApaterno("Escamilla");
        p.setAmaterno("Lopez");
        p.setReceta("NO tiene");
        p.setPadecimientos("NO tiene padecimientos");
        p.setFechaNacimiento(new Date(12321313).toLocalDate());

        dao.save(p);
        */

        dao.findAll().forEach(BeanPacientes -> {
            System.out.println("ForEch   id : " + BeanPacientes.getIdPacientes() + "  nombnre : " + BeanPacientes.getNombre() + " Paterno : " + BeanPacientes.getApaterno() + " Padecimineto : " + BeanPacientes.getPadecimientos() );
        });

        BeanPacientes BeanPacientes = dao.finOne(1L);
        System.out.println("ONE   id : " + BeanPacientes.getIdPacientes() + "  nombnre : " + BeanPacientes.getNombre() + " Paterno : " + BeanPacientes.getApaterno() + " Padecimineto : " + BeanPacientes.getPadecimientos() );


    }
}

