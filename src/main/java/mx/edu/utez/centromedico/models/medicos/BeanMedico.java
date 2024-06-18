package mx.edu.utez.centromedico.models.medicos;

public class BeanMedico {
    private Long idMedico;
    private int Usuario_idUsuario;
    private String NombreMedico;
    private String Apaterno;
    private String Amaterno;
    private String Cedula;
    private String Especialidad;
    private String Domicilio;

    public BeanMedico() {
    }

    public BeanMedico(Long idMedico, int usuario_idUsuario, String nombreMedico, String apaterno, String amaterno, String cedula, String especialidad, String domicilio) {
        this.idMedico = idMedico;
        Usuario_idUsuario = usuario_idUsuario;
        NombreMedico = nombreMedico;
        Apaterno = apaterno;
        Amaterno = amaterno;
        Cedula = cedula;
        Especialidad = especialidad;
        Domicilio = domicilio;
    }

    public Long getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(Long idMedico) {
        this.idMedico = idMedico;
    }

    public int getUsuario_idUsuario() {
        return Usuario_idUsuario;
    }

    public void setUsuario_idUsuario(int usuario_idUsuario) {
        Usuario_idUsuario = usuario_idUsuario;
    }

    public String getNombreMedico() {
        return NombreMedico;
    }

    public void setNombreMedico(String nombreMedico) {
        NombreMedico = nombreMedico;
    }

    public String getApaterno() {
        return Apaterno;
    }

    public void setApaterno(String apaterno) {
        Apaterno = apaterno;
    }

    public String getAmaterno() {
        return Amaterno;
    }

    public void setAmaterno(String amaterno) {
        Amaterno = amaterno;
    }

    public String getCedula() {
        return Cedula;
    }

    public void setCedula(String cedula) {
        Cedula = cedula;
    }

    public String getEspecialidad() {
        return Especialidad;
    }

    public void setEspecialidad(String especialidad) {
        Especialidad = especialidad;
    }

    public String getDomicilio() {
        return Domicilio;
    }

    public void setDomicilio(String domicilio) {
        Domicilio = domicilio;
    }
}