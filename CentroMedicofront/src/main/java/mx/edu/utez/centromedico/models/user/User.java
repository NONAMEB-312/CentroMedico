package mx.edu.utez.centromedico.models.user;

import mx.edu.utez.centromedico.models.rol.Rol;

public class User {
    private Long idUsuario;
    private int rolIdRol;  // Cambio de nombre
    private String correo;  // Cambio de nombre
    private String contrasenia;  // Cambio de nombre
    private String nombre;  // Cambio de nombre
    private Rol rol;

    // Constructor sin argumentos
    public User() {
    }

    // Constructor con argumentos
    public User(Long idUsuario, int rolIdRol, String correo, String contrasenia, String nombre, Rol rol) {
        this.idUsuario = idUsuario;
        this.rolIdRol = rolIdRol;
        this.correo = correo;
        this.contrasenia = contrasenia;
        this.nombre = nombre;
        this.rol = rol;
    }

    // Getters y setters


    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getRolIdRol() {
        return rolIdRol;
    }

    public void setRolIdRol(int rolIdRol) {
        this.rolIdRol = rolIdRol;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Rol getRol() {
        return rol;
    }

    public void setRol(Rol rol) {
        this.rol = rol;
    }
}
