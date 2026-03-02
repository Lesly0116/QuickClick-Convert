package servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.ServiceUtilisateur;
import dto.DocumentDTO;

@WebServlet("/ListeDocumentsServlet")
public class ListeDocumentsServlet extends HttpServlet {
    
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
        
        try {
            if(!"administrateur".equals(role)) {
                response.sendRedirect("accueille.jsp");
                return;
            }
            
            // Récupérer tous les documents
            List<DocumentDTO> documents = service.consulterTousDocuments(email);
            
            // Ajouter à la requête
            request.setAttribute("documents", documents);
            
            // Rediriger vers la JSP
            request.getRequestDispatcher("listedocuments.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("listedocuments.jsp").forward(request, response);
        }
    }
}