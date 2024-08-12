package mx.edu.utez.centromedico.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.centromedico.models.medicos.BeanMedico;
import mx.edu.utez.centromedico.models.medicos.DaoMedicos;
import mx.edu.utez.centromedico.models.recepcionistas.BeanRecepcionista;
import mx.edu.utez.centromedico.models.recepcionistas.DaoRecepcionista;
import mx.edu.utez.centromedico.models.user.DaoUser;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "admin", urlPatterns = {
        "/admin/*",
})
public class ControllerAdmin extends HttpServlet {


    private String redirect = "/user/session";
    private String action;
    private HttpSession session;
    private String valor;


    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        session = req.getSession();
        action = req.getServletPath();
        switch (action) {
            /*Vistasde lso usuarios */
            case "/admin/panel/medicos":
                List<BeanMedico> medicos = new DaoMedicos().findAll();
                req.setAttribute("medicos" , medicos);
                //   redirect = "";
                break;
            case "/admin/panel/recepcionistas":
                List<BeanRecepcionista> recepcionistas = new DaoRecepcionista().findAll();
                req.setAttribute("recepcionistas" , recepcionistas);
                //   redirect = "";
                break;


        }


        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");

        action = req.getServletPath();
        switch (action) {
            case "/admin/save-user":
                if (new DaoUser().registrarUsuario(
                        req.getParameter("correo"),
                        req.getParameter("contra"),
                        req.getParameter("tipo"),
                        req.getParameter("nombre"),
                        req.getParameter("paterno"),
                        req.getParameter("materno"),
                        req.getParameter("cedula"),
                        req.getParameter("especialidad"),
                        req.getParameter("domilicio")
                ) != -1) {
                    // redirect = "";
                } else {
                    // redirect = "/?result= " + false + "&message" +
                    //       "=" + URLEncoder.encode("¡Error! Accion no relizada", StandardCharsets.UTF_8);
                }
                break;
            case "/admin/delete-user":
                if (new DaoUser().delete(
                        Long.valueOf(req.getParameter("idUser"))
                )) {
                    // redirect = "";
                } else {
                    // redirect = "?result= " + false + "&message" +
                    //       "=" + URLEncoder.encode("¡Error! Accion no relizada", StandardCharsets.UTF_8);
                }
                break;


        }
        resp.sendRedirect(req.getContextPath() + redirect);

    }
}
