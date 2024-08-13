package mx.edu.utez.centromedico.models.recepcionistas;

public class BeanRecepcionista {
    private Long idRecepcion;
    private int Usuario_idUsuario;
    private String NombreRecep;

    public BeanRecepcionista() {
    }

    public BeanRecepcionista(Long idRecepcion, int usuario_idUsuario, String nombreRecep) {
        this.idRecepcion = idRecepcion;
        Usuario_idUsuario = usuario_idUsuario;
        NombreRecep = nombreRecep;
    }

    public Long getIdRecepcion() {
        return idRecepcion;
    }

    public void setIdRecepcion(Long idRecepcion) {
        this.idRecepcion = idRecepcion;
    }

    public int getUsuario_idUsuario() {
        return Usuario_idUsuario;
    }

    public void setUsuario_idUsuario(int usuario_idUsuario) {
        Usuario_idUsuario = usuario_idUsuario;
    }

    public String getNombreRecep() {
        return NombreRecep;
    }

    public void setNombreRecep(String nombreRecep) {
        NombreRecep = nombreRecep;
    }
}