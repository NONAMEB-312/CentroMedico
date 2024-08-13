package mx.edu.utez.centromedico.controllers.users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.centromedico.models.pacientes.DaoPaciente;
import mx.edu.utez.centromedico.models.pacientes.Paciente;
import mx.edu.utez.centromedico.models.user.DaoUser;
import mx.edu.utez.centromedico.models.user.User;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "users", urlPatterns = {
        "/users/login", "/users/register",
        "/pacientes/register", "/users/list", "/pacientes/list", "/pacientes/update", "/pacientes/delete", "/users/delete"})

public class HelloServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(HelloServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/users/login":
                    handleLogin(request, response);
                    break;
                case "/users/register":
                    handleRegister(request, response);
                    break;
                case "/pacientes/register":
                    handlePacienteRegister(request, response);
                    break;
                case "/pacientes/update":
                    handleUpdatePaciente(request, response);
                    break;
                case "/pacientes/delete":
                    handleDeletePaciente(request, response);
                    break;
                case "/users/delete":
                    handleDeleteUser(request, response);

                default:
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    break;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in doPost: ", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/users/list":
                    handleListUsers(request, response);
                    break;
                case "/pacientes/list":
                    handleListPacientes(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    break;
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error in doGet: ", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }

    private void handleListUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DaoUser daoUser = new DaoUser();
        List<User> userList = daoUser.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/usuariosRegistrados.jsp").forward(request, response);
    }

    private void handleListPacientes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DaoPaciente daoPaciente = new DaoPaciente();
        List<Paciente> pacienteList = daoPaciente.getAllPacientes();
        request.setAttribute("pacienteList", pacienteList);
        request.getRequestDispatcher("/listaPacientes.jsp").forward(request, response);
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");

        DaoUser daoUser = new DaoUser();
        User user = daoUser.loadUserByUsernameAndPassword(correo, contrasenia);

        if (user != null) {
            request.getSession().setAttribute("user", user);

            String userType = user.getRol().getTipo();
            request.getSession().setAttribute("userType", userType);

            String role = user.getRol().getTipo();
            switch (role) {
                case "Admin":
                    response.sendRedirect(request.getContextPath() + "/admin.jsp");
                    break;
                case "Medico":
                    response.sendRedirect(request.getContextPath() + "/medico.jsp");
                    break;
                case "Recepcionista":
                    response.sendRedirect(request.getContextPath() + "/recepcionista.jsp");
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    break;
            }
        } else {
            request.setAttribute("errorMessage", "Invalid credentials");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID del usuario no proporcionado.");
            return;
        }

        try {
            int idUsuario = Integer.parseInt(idParam);
            DaoUser daoUser = new DaoUser();
            daoUser.eliminarUsuario(idUsuario);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Error deleting user: ", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID del usuario inválido.");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting user: ", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al eliminar el usuario.");
        }
    }


    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");
        String tipo = request.getParameter("tipo");
        String nombre = request.getParameter("nombre");
        String apaterno = request.getParameter("apaterno");
        String amaterno = request.getParameter("amaterno");
        String cedula = request.getParameter("cedula");
        String especialidad = request.getParameter("especialidad");
        String domicilio = request.getParameter("domicilio");

        DaoUser daoUser = new DaoUser();
        int idUsuario = -1;

        try {
            idUsuario = daoUser.registrarUsuario(correo, contrasenia, tipo, nombre, apaterno, amaterno, cedula, especialidad, domicilio);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error registering user: ", e);
        }

        if (idUsuario > 0) {
            response.sendRedirect(request.getContextPath() + "/registerPaciente.jsp");
        } else {
            request.setAttribute("errorMessage", "Error al registrar el usuario.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void handlePacienteRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombrePaciente = request.getParameter("nombrePaciente");
        String apellidoPaterno = request.getParameter("apellidoPaterno");
        String apellidoMaterno = request.getParameter("apellidoMaterno");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String padecimientos = request.getParameter("padecimientos");
        String receta = request.getParameter("receta");

        DaoPaciente daoPaciente = new DaoPaciente();
        int idPaciente = -1;

        try {
            Date sqlFechaNacimiento = Date.valueOf(fechaNacimiento);
            idPaciente = daoPaciente.registrarPaciente(nombrePaciente, apellidoPaterno, apellidoMaterno, sqlFechaNacimiento, padecimientos, receta);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error registering patient: ", e);
        }

        if (idPaciente > 0) {
            response.sendRedirect(request.getContextPath() + "/pacientes/list");
        } else {
            request.setAttribute("errorMessage", "Error al registrar el paciente.");
            request.getRequestDispatcher("/listaPacientes.jsp").forward(request, response);
        }
    }

    private void handleUpdatePaciente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int idPaciente = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String apellidoPaterno = request.getParameter("apaterno");
            String apellidoMaterno = request.getParameter("amaterno");
            String fechaNacimiento = request.getParameter("fechanac");
            String padecimientos = request.getParameter("padecimientos");
            String receta = request.getParameter("receta");

            Date sqlFechaNacimiento = Date.valueOf(fechaNacimiento);

            DaoPaciente daoPaciente = new DaoPaciente();

            boolean isUpdated = daoPaciente.actualizarPaciente(idPaciente, nombre, apellidoPaterno, apellidoMaterno, sqlFechaNacimiento, padecimientos, receta);

            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/pacientes/list");
            } else {
                request.setAttribute("errorMessage", "Error al actualizar el paciente. Por favor, intente de nuevo.");
                request.getRequestDispatcher("/listaPacientes.jsp").forward(request, response);
            }
        } catch (Exception e) {
            Logger.getLogger(HelloServlet.class.getName()).log(Level.SEVERE, "Error updating patient: ", e);
            request.setAttribute("errorMessage", "Error al actualizar el paciente. Por favor, intente de nuevo.");
            request.getRequestDispatcher("/listaPacientes.jsp").forward(request, response);
        }
    }



    private void handleDeletePaciente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID del paciente no proporcionado.");
            return;
        }

        try {
            int idPaciente = Integer.parseInt(idParam);
            DaoPaciente daoPaciente = new DaoPaciente();
            daoPaciente.eliminarPaciente(idPaciente);
            response.sendRedirect(request.getContextPath() + "/pacientes/list");
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Error deleting patient: ", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID del paciente inválido.");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error deleting patient: ", e);
            request.setAttribute("errorMessage", "Error al eliminar el paciente.");
            request.getRequestDispatcher("/listaPacientes.jsp").forward(request, response);
        }
    }
}
