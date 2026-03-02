package servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.ServiceUtilisateur;
import model.utilisateur;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private ServiceUtilisateur serviceUtil = new ServiceUtilisateur();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String redirect = request.getParameter("redirect");
        
        System.out.println("=== LoginServlet ===");
        System.out.println("Email: " + email);
        System.out.println("Paramètre redirect: " + redirect);
        
        try {
            
            utilisateur user = serviceUtil.authentifier(email, password);
            
            HttpSession session = request.getSession();
            
            session.setAttribute("utilisateur", user);
            
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            
            System.out.println("Rôle trouvé: " + user.getRole());
            
            // GÉRER LA REDIRECTION
            if("administrateur".equals(user.getRole())) {
                // Admin - rediriger vers le tableau de bord
                System.out.println("Admin connecté - redirection vers tableau de bord");
                response.sendRedirect("AdminServlet");
                
            } else {
                // Utilisateur normal
                System.out.println("Utilisateur normal connecté - redirection vers accueil");
                
                if("admin".equals(redirect)) {
                    // Si l'utilisateur normal a essayé d'accéder à l'espace admin
                    response.sendRedirect("accueille.jsp?error=acces_admin_refuse");
                } else {
                    // Redirection normale vers l'accueil
                    response.sendRedirect("convert.jsp");
                }
            }
            
        } catch(Exception e) {
            // En cas d'erreur d'authentification
            System.out.println("Erreur d'authentification: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("error", e.getMessage());
            
            // Rediriger vers login.jsp en conservant le paramètre redirect
            String redirectParam = (redirect != null && !redirect.isEmpty()) ? "?redirect=" + redirect : "";
            request.getRequestDispatcher("login.jsp" + redirectParam).forward(request, response);
        }
    }
}