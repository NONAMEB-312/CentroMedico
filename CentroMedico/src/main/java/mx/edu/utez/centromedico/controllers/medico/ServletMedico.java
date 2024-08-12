package mx.edu.utez.centromedico.controllers.medico;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.centromedico.models.medicos.BeanMedico;
import mx.edu.utez.centromedico.models.medicos.DaoMedicos;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletMedico", urlPatterns = {"/ServletMedico"})

public class ServletMedico extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        DaoMedicos daoMedicos = new DaoMedicos();
        
        if (action == null || action.isEmpty()) {
            List<BeanMedico> medicos = daoMedicos.findAll();
            request.setAttribute("medicos", medicos);
            request.getRequestDispatcher("/views/medico/medico.jsp").forward(request, response);
        } else if (action.equals("view")) {
            int id = Integer.parseInt(request.getParameter("id"));
            BeanMedico medico = daoMedicos.findById(id);
            request.setAttribute("medico", medico);
            request.getRequestDispatcher("/views/medico/viewMedico.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        DaoMedicos daoMedicos = new DaoMedicos();
        
        if (action != null && action.equals("create")) {
            String name = request.getParameter("name");
            String specialty = request.getParameter("specialty");
            BeanMedico medico = new BeanMedico();
            medico.setNombreMedico(name);
            medico.setEspecialidad(specialty);
            daoMedicos.save(medico);
            response.sendRedirect("ServletMedico");
        } else if (action != null && action.equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String specialty = request.getParameter("specialty");
            BeanMedico medico = DaoMedicos.finOne(Long.valueOf(id));
            medico.setNombreMedico(name);
            medico.setEspecialidad(specialty);
            DaoMedicos.update(medico);
            response.sendRedirect("ServletMedico");
        } else {
            doGet(request, response);
        }
    }
}
