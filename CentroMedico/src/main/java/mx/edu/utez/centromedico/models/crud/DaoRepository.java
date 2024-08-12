package mx.edu.utez.centromedico.models.crud;


import mx.edu.utez.centromedico.models.user.User;

import java.sql.SQLException;
import java.util.List;

public interface DaoRepository <T>{

    List<T> findAll();

    List<User> searchRole();

    T finOne(Long id);
    boolean save(T object);

    boolean update(T object) throws SQLException;
    boolean delete(Long id);


}