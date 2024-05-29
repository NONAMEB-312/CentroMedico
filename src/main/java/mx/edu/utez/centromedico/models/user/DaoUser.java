package mx.edu.utez.centromedico.models.user;

import mx.edu.utez.centromedico.models.rol.Rol;
import mx.edu.utez.centromedico.utils.MySQLConnection;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoUser {
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

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

    public void close() {
        try {
            if (conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error closing resources: " + e.getMessage(), e);
        }
    }
}