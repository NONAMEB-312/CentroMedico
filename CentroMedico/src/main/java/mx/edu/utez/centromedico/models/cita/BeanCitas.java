package mx.edu.utez.centromedico.models.cita;

import java.time.LocalDate;

public class BeanCitas {

    private int idCitas;
    private int recepcionIdRecepcion;
    private int medicosIdMedicos;
    private int pacientesIdPacientes;
    private int centromedicoIdCentromedico;
    private String dia;
    private LocalDate hora;

    public BeanCitas() {
    }

    public BeanCitas(int idCitas, int recepcionIdRecepcion, int medicosIdMedicos, int pacientesIdPacientes, int centromedicoIdCentromedico, String dia, LocalDate hora) {
        this.idCitas = idCitas;
        this.recepcionIdRecepcion = recepcionIdRecepcion;
        this.medicosIdMedicos = medicosIdMedicos;
        this.pacientesIdPacientes = pacientesIdPacientes;
        this.centromedicoIdCentromedico = centromedicoIdCentromedico;
        this.dia = dia;
        this.hora = hora;
    }

    public int getIdCitas() {
        return idCitas;
    }

    public void setIdCitas(int idCitas) {
        this.idCitas = idCitas;
    }

    public int getRecepcionIdRecepcion() {
        return recepcionIdRecepcion;
    }

    public void setRecepcionIdRecepcion(int recepcionIdRecepcion) {
        this.recepcionIdRecepcion = recepcionIdRecepcion;
    }

    public int getMedicosIdMedicos() {
        return medicosIdMedicos;
    }

    public void setMedicosIdMedicos(int medicosIdMedicos) {
        this.medicosIdMedicos = medicosIdMedicos;
    }

    public int getPacientesIdPacientes() {
        return pacientesIdPacientes;
    }

    public void setPacientesIdPacientes(int pacientesIdPacientes) {
        this.pacientesIdPacientes = pacientesIdPacientes;
    }

    public int getCentromedicoIdCentromedico() {
        return centromedicoIdCentromedico;
    }

    public void setCentromedicoIdCentromedico(int centromedicoIdCentromedico) {
        this.centromedicoIdCentromedico = centromedicoIdCentromedico;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public LocalDate getHora() {
        return hora;
    }

    public void setHora(LocalDate hora) {
        this.hora = hora;
    }
}
