package servlet;

import service.ServiceDocument;
import model.utilisateur;
import model.documents;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DocumentsUtilisateur")
public class DocumentsUtilisateur extends HttpServlet {

    private final ServiceDocument service = new ServiceDocument();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        utilisateur u = (session != null)
                ? (utilisateur) session.getAttribute("utilisateur")
                : null;

        if (u == null) {
            request.setAttribute("error",
                    "Veuillez vous connecter pour voir vos documents");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            List<documents> docs = service.getDocumentsUtilisateur(u.getId());
            request.setAttribute("documents", docs);
            request.getRequestDispatcher("documents.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Erreur lors du chargement des documents", e);
        }
    }
}
