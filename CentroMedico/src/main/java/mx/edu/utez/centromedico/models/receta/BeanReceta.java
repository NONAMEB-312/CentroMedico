package mx.edu.utez.centromedico.models.receta;

import java.sql.Date;

public class BeanReceta {
    private Long idReceta;
    private int idPaciente;
    private int idMedico;
    private Date Fecha;
    private String Medicamentos;
    private String Dosis;
    private String Instrucciones;

    public BeanReceta() {
    }

    public BeanReceta(int idPaciente, int idMedico, Date Fecha, String Medicamentos, String Dosis, String Instrucciones) {
        this.idPaciente = idPaciente;
        this.idMedico = idMedico;
        this.Fecha = Fecha;
        this.Medicamentos = Medicamentos;
        this.Dosis = Dosis;
        this.Instrucciones = Instrucciones;
    }

    public Long getIdReceta() {
        return idReceta;
    }

    public void setIdReceta(Long idReceta) {
        this.idReceta = idReceta;
    }

    public int getIdPaciente() {
        return idPaciente;
    }

    public void setIdPaciente(int idPaciente) {
        this.idPaciente = idPaciente;
    }

    public int getIdMedico() {
        return idMedico;
    }

    public void setIdMedico(int idMedico) {
        this.idMedico = idMedico;
    }

    public Date getFecha() {
        return Fecha;
    }

    public void setFecha(Date fecha) {
        Fecha = fecha;
    }

    public String getMedicamentos() {
        return Medicamentos;
    }

    public void setMedicamentos(String medicamentos) {
        Medicamentos = medicamentos;
    }

    public String getDosis() {
        return Dosis;
    }

    public void setDosis(String dosis) {
        Dosis = dosis;
    }

    public String getInstrucciones() {
        return Instrucciones;
    }

    public void setInstrucciones(String instrucciones) {
        Instrucciones = instrucciones;
    }
}