package servlet;

import service.ServiceDocument;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import model.utilisateur;
import jakarta.servlet.http.*;
import java.io.IOException;

@MultipartConfig
@WebServlet("/ConvertServlet")
public class ConvertServlet extends HttpServlet {

    private ServiceDocument service = new ServiceDocument();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Part fichier = request.getPart("fichier");
        String typeConversion = request.getParameter("typeConversion");

        utilisateur user = (utilisateur) session.getAttribute("utilisateur");
        
        boolean estConnecte = (user != null);
       
        Boolean conversionInviteEffectuee = (Boolean) session.getAttribute("conversionInviteEffectuee");
        
        if (!estConnecte && conversionInviteEffectuee != null && conversionInviteEffectuee) {
            
            request.setAttribute("error", "Vous avez déjà effectué une conversion. Veuillez créer ou vous connecter un compte pour continuer.");
            request.getRequestDispatcher("accueille.jsp").forward(request, response);
             return;
        }

        try {
            
            service.convertir( session, fichier, typeConversion, user);

            request.setAttribute("message", "Conversion effectuée avec succès !");

           
            if (!estConnecte) { 
                
                session.setAttribute("conversionInviteEffectuee", true);
                
            }

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

       
        if (estConnecte) {
            request.getRequestDispatcher("convert.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("accueille.jsp").forward(request, response);
        }
    }
}
