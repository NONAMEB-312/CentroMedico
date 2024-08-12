package mx.edu.utez.centromedico.models.pacientes;

import java.time.LocalDate;

public class BeanPacientes {
    private Long idPacientes;
    private String Nombre;
    private String Apaterno;
    private String Amaterno;
    private LocalDate FechaNacimiento;
    private String Padecimientos;
    private String Receta;

    public BeanPacientes() {
    }

    public BeanPacientes(Long idPacientes, String nombre, String apaterno, String amaterno, LocalDate fechaNacimiento, String padecimientos, String receta) {
        this.idPacientes = idPacientes;
        Nombre = nombre;
        Apaterno = apaterno;
        Amaterno = amaterno;
        FechaNacimiento = fechaNacimiento;
        Padecimientos = padecimientos;
        Receta = receta;
    }

    public Long getIdPacientes() {
        return idPacientes;
    }

    public void setIdPacientes(Long idPacientes) {
        this.idPacientes = idPacientes;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String nombre) {
        Nombre = nombre;
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

    public LocalDate getFechaNacimiento() {
        return FechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        FechaNacimiento = fechaNacimiento;
    }

    public String getPadecimientos() {
        return Padecimientos;
    }

    public void setPadecimientos(String padecimientos) {
        Padecimientos = padecimientos;
    }

    public String getReceta() {
        return Receta;
    }

    public void setReceta(String receta) {
        Receta = receta;
    }
}
