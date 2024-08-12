package mx.edu.utez.centromedico.controllers.users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.centromedico.models.user.DaoUser;
import mx.edu.utez.centromedico.models.user.User;


import java.io.IOException;

@WebServlet(name = "users", urlPatterns = {"/users/login", "/users/index", "/users/logout"})
public class HelloServlet extends HttpServlet {

    private String action;
    private String urlRedirect;
    HttpSession session;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        action = req.getServletPath();
        switch (action){
            case "/users/login":
                urlRedirect = "/index.jsp";
                break;
            case "/users/logout":
                session = req.getSession();
                session.invalidate();
                urlRedirect = "/index.jsp";
                break;
        }
        req.getRequestDispatcher(urlRedirect).forward(req, resp);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String correo = request.getParameter("correo");
        String contrasenia = request.getParameter("contrasenia");

        DaoUser daoUser = new DaoUser();
        User user = daoUser.loadUserByUsernameAndPassword(correo, contrasenia);

        if (user != null) {
            request.getSession().setAttribute("user", user);

            // Redirige a la página correspondiente según el rol del usuario
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

    
}
