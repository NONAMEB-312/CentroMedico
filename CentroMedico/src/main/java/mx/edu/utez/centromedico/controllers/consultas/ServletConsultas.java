package mx.edu.utez.centromedico.controllers.consultas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "consulta" , urlPatterns = {
        "/consulta/save-consulta",
        "/consulta/view",
        "/consulta/update",
        "/consulta/delete"
})

public class ServletConsultas extends HttpServlet{
        
            private String redirect = "/user/session";
            private String action;
            private String valor;
        
            protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           req.setCharacterEncoding("UTF-8");
           action = req.getServletPath();
           switch (action) {
                  case "/consulta/save-consulta":
                 redirect = "/views/consultas/save-consulta.jsp";
                 break;
                  case "/consulta/view":
                 redirect = "/views/consultas/view-consulta.jsp";
                 break;
                  case "/consulta/update":
                 redirect = "/views/consultas/update-consulta.jsp";
                 break;
                  case "/consulta/delete":
                 redirect = "/views/consultas/delete-consulta.jsp";
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