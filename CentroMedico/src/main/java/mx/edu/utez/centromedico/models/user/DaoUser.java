package mx.edu.utez.centromedico.models.user;

import mx.edu.utez.centromedico.models.medicos.DaoMedicos;
import mx.edu.utez.centromedico.models.rol.Rol;
import mx.edu.utez.centromedico.utils.MySQLConnection;

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
                user.setRol_idRol(rs.getInt("idRol"));

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
            e.printStackTrace();
            return idUsuario;

        } finally {
            // Cerrar recursos
            if (cs != null) {
                try {
                    cs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return idUsuario;
    }
        //este es para hacer la prueba de registrar un nuevo usuario
    public static void main(String[] args) {
        DaoUser dao = new DaoUser();
        //int idUsuario = dao.registrarUsuario("Bebeto@example.com", "pass321", "medico", "Bebeto", "Doe", "Smith", "245345", "Pediatria", "321 Main St");
        //System.out.println("New Usuario ID: " + idUsuario);

        /*int idRecepcionista = dao.registrarUsuario("recepcionista@example.com", "password123", "recepcionista", "Jane", "Doe", "Smith", null, null, null);
        System.out.println("New Recepcionista ID: " + idRecepcionista);*/
    }

    public void close() {
        try {
            if (conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error closing resources: " + e.getMessage(), e);
        }
    }
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "call EliminarUsuario(?)";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1 , id);
            return  pstm.executeUpdate()==0;
        }catch ( SQLException e)
        {
            Logger.getLogger(DaoMedicos.class.getName())
                    .log(Level.SEVERE,"Error findAll" + e.getMessage());

        }finally {
            close();
        }
        return false;
    }

}