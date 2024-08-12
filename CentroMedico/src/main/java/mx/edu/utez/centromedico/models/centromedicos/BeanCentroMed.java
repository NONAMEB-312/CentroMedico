package mx.edu.utez.centromedico.models.centromedicos;

public class BeanCentroMed {

    private int idCentromedico;
    private String localizacion;

    public BeanCentroMed() {
    }

    public BeanCentroMed(int idCentromedico, String localizacion) {
        this.idCentromedico = idCentromedico;
        this.localizacion = localizacion;
    }

    // Getters y Setters
    public int getIdCentromedico() {
        return idCentromedico;
    }

    public void setIdCentromedico(int idCentromedico) {
        this.idCentromedico = idCentromedico;
    }

    public String getLocalizacion() {
        return localizacion;
    }

    public void setLocalizacion(String localizacion) {
        this.localizacion = localizacion;
    }
}
