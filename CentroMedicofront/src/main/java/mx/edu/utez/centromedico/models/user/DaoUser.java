package mx.edu.utez.centromedico.models.user;
import mx.edu.utez.centromedico.models.rol.Rol;
import mx.edu.utez.centromedico.utils.MySQLConnection;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoUser {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;
    private CallableStatement cs;

    public User loadUserByUsernameAndPassword(String correo, String contrasenia) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT u.idUsuario, u.Correo, u.Contrasenia, r.idRol, r.tipo " +
                    "FROM Usuario u " +
                    "JOIN Rol r ON u.Rol_idRol = r.idRol " +
                    "WHERE u.Correo = ? AND u.Contrasenia = ?";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, correo);
            pstm.setString(2, contrasenia);
            rs = pstm.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setIdUsuario(rs.getLong("idUsuario"));
                user.setCorreo(rs.getString("Correo"));
                user.setContrasenia(rs.getString("Contrasenia"));
                user.setRolIdRol(rs.getInt("idRol"));

                Rol rol = new Rol();
                rol.setIdRol(rs.getLong("idRol"));
                rol.setTipo(rs.getString("tipo"));
                user.setRol(rol);  // Establecer el rol en el usuario

                return user;
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Credentials mismatch: " + e.getMessage(), e);
        } finally {
            close();
        }
        return null;
    }

    public int registrarUsuario(String correo, String contrasenia, String tipo, String nombre, String apaterno, String amaterno, String cedula, String especialidad, String domicilio) {

        int idUsuario = -1;

        try {

            // Establecer la conexión

            conn = new MySQLConnection().connect();

            // Preparar la llamada al procedimiento almacenado

            String sql = "{ CALL RegistrarUsuario(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }";

            cs = conn.prepareCall(sql);

            // Establecer los parámetros de entrada

            cs.setString(1, correo);

            cs.setString(2, contrasenia);

            cs.setString(3, tipo);

            cs.setString(4, nombre);

            cs.setString(5, apaterno);

            cs.setString(6, amaterno);

            cs.setString(7, cedula); // puede ser null

            cs.setString(8, especialidad); // puede ser null

            cs.setString(9, domicilio); // puede ser null

            // Registrar el parámetro de salida

            cs.registerOutParameter(10, Types.INTEGER);

            // Ejecutar el procedimiento almacenado

            cs.execute();

            // Obtener el valor del parámetro de salida

            idUsuario = cs.getInt(10);

        } catch (SQLException e) {

            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error registering user: " + e.getMessage(), e);

        } finally {

            close();

        }

        return idUsuario;

    }

    public int registrarPaciente(String nombre, String apaterno, String amaterno, java.sql.Date fechanac, String padecimientos, String receta) throws SQLException {
        int idPaciente = -1;
        try {
            conn = new MySQLConnection().connect();
            String sql = "{CALL RegistrarPaciente(?, ?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            cs.setString(1, nombre);
            cs.setString(2, apaterno);
            cs.setString(3, amaterno);
            cs.setDate(4, fechanac);
            cs.setString(5, padecimientos);
            cs.setString(6, receta);
            cs.registerOutParameter(7, java.sql.Types.INTEGER);

            cs.executeUpdate();
            idPaciente = cs.getInt(7);
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error registering patient: " + e.getMessage(), e);
        } finally {
            close();
        }

        return idPaciente;
    }

    // Método para cerrar recursos
    public void close() {
        try {
            if (rs != null) rs.close();
            if (pstm != null) pstm.close();
            if (cs != null) cs.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error closing resources: " + e.getMessage(), e);
        }
    }

    // Método de prueba para registrar un nuevo usuario
   /* public static void main(String[] args) {
        DaoUser dao = new DaoUser();
        int idUsuario = dao.registrarUsuario("doctorexem@example.com", "password123", "medico", "John", "Doe", "Smith", "123456", "Cardiology", "123 Main St");
        System.out.println("New Usuario ID: " + idUsuario);

        int idRecepcionista = dao.registrarUsuario("recepcionista15@example.com", "password1223", "recepcionista", "Jane", "Doe", "Smith", null, null, null);
        System.out.println("New Recepcionista ID: " + idRecepcionista);
    }*/

    public void eliminarUsuario(int idUsuario) throws SQLException {
        try {
            conn = new MySQLConnection().connect();
            String sql = "DELETE FROM Usuario WHERE idUsuario = ?";
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            pstm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error al eliminar usuario: " + e.getMessage(), e);
            throw e;
        } finally {
            close();
        }
    }



    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT u.idUsuario, u.Correo, u.Contrasenia, r.idRol, r.tipo " +
                    "FROM Usuario u " +
                    "JOIN Rol r ON u.Rol_idRol = r.idRol";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setIdUsuario(rs.getLong("idUsuario"));
                user.setCorreo(rs.getString("Correo"));
                user.setContrasenia(rs.getString("Contrasenia"));
                user.setRolIdRol(rs.getInt("idRol"));

                Rol rol = new Rol();
                rol.setIdRol(rs.getLong("idRol"));
                rol.setTipo(rs.getString("tipo"));
                user.setRol(rol);

                userList.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error fetching users: " + e.getMessage(), e);
        } finally {
            close();
        }
        return userList;
    }
}


