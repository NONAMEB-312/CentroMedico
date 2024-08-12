package mx.edu.utez.centromedico.models.service;

import mx.edu.utez.centromedico.models.user.DaoUser;
import mx.edu.utez.centromedico.models.user.User;

public class Service{
    DaoUser user = new DaoUser();
    public User login(String correo, String contrasenia){
        return user.loadUserByUsernameAndPassword(correo, contrasenia);
    }
}