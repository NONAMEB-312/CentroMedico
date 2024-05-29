package mx.edu.utez.centromedico.models.user;

import mx.edu.utez.centromedico.models.rol.Rol;

public class User {
    private Long idUsuario;
    private int Rol_idRol;
    private String Correo;
    private String Contrasenia;
    private Rol rol;

    public User() {
    }

    public User(Long idUsuario, int rol_idRol, String correo, String contrasenia, Rol rol) {
        this.idUsuario = idUsuario;
        Rol_idRol = rol_idRol;
        Correo = correo;
        Contrasenia = contrasenia;
        this.rol = rol;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getRol_idRol() {
        return Rol_idRol;
    }

    public void setRol_idRol(int rol_idRol) {
        Rol_idRol = rol_idRol;
    }

    public String getCorreo() {
        return Correo;
    }

    public void setCorreo(String correo) {
        Correo = correo;
    }

    public String getContrasenia() {
        return Contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        Contrasenia = contrasenia;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
}