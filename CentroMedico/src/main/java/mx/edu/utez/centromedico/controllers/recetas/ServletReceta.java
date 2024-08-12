package mx.edu.utez.centromedico.controllers.recetas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.centromedico.models.receta.BeanReceta;
import mx.edu.utez.centromedico.models.receta.DaoReceta;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "receta", urlPatterns = {
        "/receta/save-receta",
        "/receta/view",
        "/receta/update",
        "/receta/delete"
})

public class ServletReceta extends HttpServlet {

    private String action;
    private String redirect = "/receta/view";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/receta/view":
                List<BeanReceta> recetas = new DaoReceta().findAllReceta();
                req.setAttribute("recetas", recetas);
                redirect = "/views/admins/recetas-views.jsp";
                break;
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action) {
            case "/receta/save-receta":
                int idPaciente = Integer.parseInt(req.getParameter("idPaciente"));
                int idMedico = Integer.parseInt(req.getParameter("idMedico"));
                String fecha = req.getParameter("fecha");
                String medicamentos = req.getParameter("medicamentos");
                String dosis = req.getParameter("dosis");
                String instrucciones = req.getParameter("instrucciones");

                BeanReceta receta = new BeanReceta();
                receta.setIdPaciente(idPaciente);
                receta.setIdMedico(idMedico);
                receta.setFecha(Date.valueOf(fecha));
                receta.setMedicamentos(medicamentos);
                receta.setDosis(dosis);
                receta.setInstrucciones(instrucciones);

                boolean isSaved = new DaoReceta().saveReceta(receta);

                if (isSaved) {
                    String successMessage = URLEncoder.encode("Receta guardada exitosamente", StandardCharsets.UTF_8.toString());
                    redirect = "/receta/view?message=" + successMessage;
                } else {
                    String errorMessage = URLEncoder.encode("Error al guardar la receta", StandardCharsets.UTF_8.toString());
                    redirect = "/receta/view?error=" + errorMessage;
                }
                break;

        }
        resp.sendRedirect(req.getContextPath() + redirect);
    }



}