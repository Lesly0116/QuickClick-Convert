package servlet;

import service.ServiceUtilisateur;
import model.utilisateur;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EnregistrerCompteServlet")
public class EnregistrerCompteServlet extends HttpServlet {

    private ServiceUtilisateur service = new ServiceUtilisateur();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            service.inscrire(email, password);
            request.setAttribute("message", "Inscription réussie. Connectez-vous !");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage()); 
            request.getRequestDispatcher("enregistrercompte.jsp").forward(request, response);
        }
    }
}
