package servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.ServiceUtilisateur;
import dto.DocumentDTO;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    
    private ServiceUtilisateur service = new ServiceUtilisateur();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if(session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp?redirect=admin");
            return;
        }
        
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");
        
        System.out.println("=== AdminServlet ===");
        System.out.println("Email: " + email);
        System.out.println("Rôle: " + role);
        
        try {
            if(!"administrateur".equals(role)) {
                request.setAttribute("error", "Accès non autorisé");
                request.getRequestDispatcher("accueille.jsp").forward(request, response);
                return;
            }
            
            // Récupérer tous les documents
            List<DocumentDTO> documents = service.consulterTousDocuments(email);
            
            System.out.println("Documents récupérés: " + (documents != null ? documents.size() : 0));
            
            // Ajouter à la requête
            request.setAttribute("documents", documents);
            
            // Rediriger vers la JSP
            request.getRequestDispatcher("tableaudebordadmin.jsp").forward(request, response);
            
        } catch(Exception e) {
            System.out.println("ERREUR: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("tableaudebordadmin.jsp").forward(request, response);
        }
    }
}