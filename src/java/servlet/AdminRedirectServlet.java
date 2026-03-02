package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminRedirectServlet")
public class AdminRedirectServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // DEBUG
        System.out.println("=== AdminRedirectServlet ===");
        
        if(session != null && session.getAttribute("email") != null) {
            System.out.println("Session ID: " + session.getId());
            System.out.println("Email: " + session.getAttribute("email"));
            System.out.println("Rôle: " + session.getAttribute("role"));
            
            String role = (String) session.getAttribute("role");
            
            if("administrateur".equals(role)) {
                System.out.println("Admin détecté - Redirection vers tableau de bord");
                response.sendRedirect("tableaudebordadmin.jsp");
                return;
            } else {
                System.out.println("Utilisateur normal - Redirection vers accueil");
                response.sendRedirect("accueille.jsp");
                return;
            }
        } else {
            System.out.println("Pas de session - Redirection vers login avec paramètre redirect=admin");
            // ICI ON AJOUTE LE PARAMÈTRE redirect=admin
            response.sendRedirect("login.jsp?redirect=admin");
            return;
        }
    }
}