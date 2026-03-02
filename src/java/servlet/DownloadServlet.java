package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {

    private final String uploadDir = "C:/ConvertDocs/uploads/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");
        String action = request.getParameter("action");
        
        if (fileName == null || fileName.isEmpty()) {
            response.getWriter().println("Fichier non spécifié !");
            return;
        }

        File file = new File(uploadDir, fileName);
        if (!file.exists()) {
            response.getWriter().println("Fichier introuvable !");
            return;
        }
        
        // ✅ 1. DÉTERMINER LE TYPE MIME
        String mimeType = getServletContext().getMimeType(file.getName());
        
        if (mimeType == null) {
            String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            
            switch (extension) {
                case "pdf":
                    mimeType = "application/pdf";
                    break;
                case "docx":
                    mimeType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
                    break;
                case "xlsx":
                    mimeType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    break;
                case "pptx":
                    mimeType = "application/vnd.openxmlformats-officedocument.presentationml.presentation";
                    break;
                case "jpg":
                case "jpeg":
                    mimeType = "image/jpeg";
                    break;
                case "png":
                    mimeType = "image/png";
                    break;
                case "gif":
                    mimeType = "image/gif";
                    break;
                case "bmp":
                    mimeType = "image/bmp";
                    break;
                case "webp":
                    mimeType = "image/webp";
                    break;
                case "txt":
                case "html":
                case "htm":
                case "css":
                case "js":
                case "xml":
                case "json":
                    mimeType = "text/plain";
                    break;
                default:
                    mimeType = "application/octet-stream";
            }
        }
        
        response.setContentType(mimeType);
        
       
        if ("preview".equals(action)) {
            // 🔍 APERÇU DIRECT
            response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
            
            // Envoyer le fichier
            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        } 
        else if ("preview-force".equals(action)) {
            // 🔍 APERÇU FORCÉ (pour Google Docs Viewer et iframes)
            response.setHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
            
            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        }
        else {
            // 📥 TÉLÉCHARGEMENT
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            
            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        }
    }
}