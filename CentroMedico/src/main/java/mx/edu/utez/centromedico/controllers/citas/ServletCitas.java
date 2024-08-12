package mx.edu.utez.centromedico.controllers.citas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "cita" , urlPatterns = {
        "/cita/save-cita",
        "/cita/view",
        "/cita/update",
        "/cita/delete"
})

public class ServletCitas extends HttpServlet{
        
            private String redirect = "/user/session";
            private String action;
            private String valor;
        
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           req.setCharacterEncoding("UTF-8");
           action = req.getServletPath();
           switch (action) {
                  case "/cita/save-cita":
                 redirect = "/views/citas/save-cita.jsp";
                 break;
                  case "/cita/view":
                 redirect = "/views/citas/view-cita.jsp";
                 break;
                  case "/cita/update":
                 redirect = "/views/citas/update-cita.jsp";
                 break;
                  case "/cita/delete":
                 redirect = "/views/citas/delete-cita.jsp";
                 break;
           }
           req.getRequestDispatcher(redirect).forward(req, resp);
            }
        
            @Override
            protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           req.setCharacterEncoding("UTF-8");
           resp.setCharacterEncoding("UTF-8");
            }
}