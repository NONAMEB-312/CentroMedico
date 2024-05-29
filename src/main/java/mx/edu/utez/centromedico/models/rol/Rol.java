package mx.edu.utez.centromedico.models.rol;

public class Rol {
    private Long idRol;
    private String tipo;

    public Rol() {
    }

    public Rol(Long idRol, String tipo) {
        this.idRol = idRol;
        this.tipo = tipo;
    }

    public Long getIdRol() {
        return idRol;
    }

    public void setIdRol(Long idRol) {
        this.idRol = idRol;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}