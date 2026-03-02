<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Aperçu du fichier - QuickClick Convert</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bleu-marin: #1e3a5f;
            --bleu-ciel: #e6f3ff;
            --jaune-abricot: #fbc4ab;
            --blanc: #ffffff;
        }
        
        html {
            font-size: 16px;
            -webkit-text-size-adjust: 100%;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: var(--bleu-ciel);
            margin: 0;
            padding: clamp(10px, 3vw, 20px);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            overflow-x: hidden;
        }
        
        .preview-container {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            background: var(--blanc);
            border-radius: clamp(16px, 4vw, 24px);
            padding: clamp(20px, 4vw, 32px);
            box-shadow: 0 15px 35px -10px rgba(30, 58, 95, 0.15);
        }
        
        .preview-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: clamp(16px, 3vw, 24px);
            padding-bottom: clamp(16px, 3vw, 20px);
            border-bottom: 2px solid #f1f5f9;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .preview-title h2 {
            color: var(--bleu-marin);
            margin: 0;
            font-size: clamp(20px, 4vw, 24px);
            word-break: break-word;
            hyphens: auto;
        }
        
        .file-name {
            color: #64748b;
            font-size: clamp(12px, 3vw, 14px);
            margin-top: 5px;
            word-break: break-word;
        }
        
        .btn-back {
            padding: clamp(8px, 2vw, 10px) clamp(16px, 3vw, 24px);
            background: var(--bleu-marin);
            color: white;
            text-decoration: none;
            border-radius: 40px;
            font-weight: 500;
            font-size: clamp(13px, 2.8vw, 14px);
            transition: all 0.2s;
            white-space: nowrap;
        }
        
        .btn-back:hover {
            background: #152b44;
            transform: translateY(-2px);
        }
        
        .btn-back:active {
            transform: translateY(-1px);
        }
        
        .preview-frame {
            width: 100%;
            height: min(800px, 60vh);
            border: none;
            border-radius: clamp(12px, 3vw, 16px);
            background: #f8fafc;
        }
        
        .image-preview {
            text-align: center;
            background: #f8fafc;
            padding: clamp(15px, 3vw, 20px);
            border-radius: clamp(12px, 3vw, 16px);
        }
        
        .image-preview img {
            max-width: 100%;
            max-height: min(800px, 70vh);
            width: auto;
            height: auto;
            border-radius: clamp(12px, 3vw, 16px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            object-fit: contain;
        }
        
        .office-viewer {
            width: 100%;
            height: min(800px, 60vh);
            border: none;
            border-radius: clamp(12px, 3vw, 16px);
            background: #f8fafc;
        }
        
        .unsupported {
            text-align: center;
            padding: clamp(40px, 8vw, 80px) clamp(20px, 4vw, 40px);
            background: #f8fafc;
            border-radius: clamp(12px, 3vw, 16px);
        }
        
        .unsupported p {
            color: #64748b;
            font-size: clamp(16px, 3.5vw, 18px);
            margin-bottom: clamp(20px, 5vw, 30px);
            word-break: break-word;
            line-height: 1.6;
        }
        
        .unsupported p:last-of-type {
            font-size: clamp(13px, 3vw, 14px);
        }
        
        .download-link {
            display: inline-block;
            padding: clamp(12px, 3vw, 14px) clamp(30px, 6vw, 40px);
            background: var(--jaune-abricot);
            color: var(--bleu-marin);
            text-decoration: none;
            border-radius: 40px;
            font-weight: 600;
            font-size: clamp(14px, 3.2vw, 15px);
            transition: all 0.2s;
            border: 2px solid transparent;
        }
        
        .download-link:hover {
            background: #f9b091;
            transform: translateY(-2px);
        }
        
        .download-link:active {
            transform: translateY(-1px);
        }
        
        .preview-container > div > div[style*="background: #f0f0f0"] {
            margin-bottom: clamp(15px, 3vw, 20px);
            padding: clamp(8px, 2vw, 10px) clamp(10px, 2.5vw, 15px);
            background: #f0f0f0 !important;
            border-radius: 8px;
            font-size: clamp(11px, 2.5vw, 12px) !important;
            word-break: break-all;
            overflow-wrap: break-word;
            max-width: 100%;
        }
        
        @media (max-width: 768px) {
            .preview-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .btn-back {
                width: 100%;
                text-align: center;
                white-space: normal;
            }
            
            .preview-frame,
            .office-viewer {
                height: 50vh;
            }
            
            .image-preview img {
                max-height: 50vh;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 8px;
            }
            
            .preview-container {
                padding: 16px;
            }
            
            .preview-title h2 {
                font-size: 18px;
            }
            
            .file-name {
                font-size: 12px;
            }
            
            .btn-back {
                font-size: 13px;
                padding: 8px 16px;
            }
            
            .preview-frame,
            .office-viewer {
                height: 40vh;
            }
            
            .image-preview img {
                max-height: 40vh;
            }
            
            .unsupported {
                padding: 30px 15px;
            }
            
            .unsupported p {
                font-size: 15px;
            }
            
            .download-link {
                padding: 10px 25px;
                font-size: 14px;
            }
        }
        
        @media (max-width: 360px) {
            .preview-container {
                padding: 12px;
            }
            
            .preview-title h2 {
                font-size: 16px;
            }
            
            .file-name {
                font-size: 11px;
            }
            
            .preview-frame,
            .office-viewer {
                height: 35vh;
            }
            
            .image-preview img {
                max-height: 35vh;
            }
            
            .unsupported p {
                font-size: 14px;
            }
            
            .download-link {
                padding: 8px 20px;
                font-size: 13px;
            }
        }
        
        /* Gestion des très grands écrans */
        @media (min-width: 1600px) {
            .preview-container {
                max-width: 1400px;
            }
            
            .preview-frame,
            .office-viewer {
                height: 900px;
            }
            
            .image-preview img {
                max-height: 900px;
            }
        }
        
        @media (max-height: 600px) and (orientation: landscape) {
            .preview-frame,
            .office-viewer {
                height: 70vh;
            }
            
            .image-preview img {
                max-height: 70vh;
            }
            
            .preview-container {
                padding: 15px;
            }
        }
        
        @media (hover: none) and (pointer: coarse) {
            .btn-back:hover,
            .download-link:hover {
                transform: none;
            }
            
            .btn-back:active {
                background: #152b44;
                transform: scale(0.98);
            }
            
            .download-link:active {
                background: #f9b091;
                transform: scale(0.98);
            }
        }
        
        ::selection {
            background: var(--jaune-abricot);
            color: var(--bleu-marin);
        }
        
        @media (prefers-contrast: high) {
            .preview-container {
                border: 2px solid var(--bleu-marin);
            }
            
            .btn-back {
                border: 2px solid white;
            }
            
            .download-link {
                border: 2px solid var(--bleu-marin);
            }
        }
        
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
            
            .btn-back:hover,
            .download-link:hover {
                transform: none;
            }
        }
        
        img, video, iframe {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <%
        String fileName = request.getParameter("file");
        
        if (fileName == null || fileName.isEmpty()) {
            response.sendRedirect("convert.jsp");
            return;
        }
        
        String extension = "";
        if (fileName.contains(".")) {
            extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        }
        
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + 
                         request.getServerPort() + request.getContextPath();
        String fileUrl = baseUrl + "/DownloadServlet?file=" + fileName + "&action=preview-force";
        String encodedFileUrl = URLEncoder.encode(fileUrl, "UTF-8");
        
        String officeViewerUrl = "https://view.officeapps.live.com/op/embed.aspx?src=" + encodedFileUrl;
    %>
    
    <div class="preview-container">
        <div class="preview-header">
            <div class="preview-title">
                <h2>Aperçu du fichier</h2>
                <div class="file-name"><%= fileName %></div>
            </div>
            <a href="javascript:history.back()" class="btn-back">← Retour</a>
        </div>
        
        <%-- PDF --%>
        <% if (extension.equals("pdf")) { %>
            <iframe src="DownloadServlet?file=<%= fileName %>&action=preview-force" 
                    class="preview-frame"></iframe>
        
        <%-- Images --%>
        <% } else if (extension.equals("jpg") || extension.equals("jpeg") || 
                      extension.equals("png") || extension.equals("gif") || 
                      extension.equals("bmp") || extension.equals("webp")) { %>
            <div class="image-preview">
                <img src="DownloadServlet?file=<%= fileName %>&action=preview-force" 
                     alt="Aperçu image">
            </div>
        
        <%-- Texte --%>
        <% } else if (extension.equals("txt") || extension.equals("html") || 
                      extension.equals("htm") || extension.equals("css") || 
                      extension.equals("js") || extension.equals("xml") || 
                      extension.equals("json")) { %>
            <iframe src="DownloadServlet?file=<%= fileName %>&action=preview-force" 
                    class="preview-frame"></iframe>
        
        <%-- Word --%>
        <% } else if (extension.equals("docx") || extension.equals("doc")) { %>
            <div style="margin-bottom: 20px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; word-break: break-all;">
                <strong>URL Microsoft Office Online :</strong><br>
                <%= officeViewerUrl %>
            </div>
            <iframe src="<%= officeViewerUrl %>" 
                    class="office-viewer"></iframe>
        
        <%-- Excel --%>
        <% } else if (extension.equals("xlsx") || extension.equals("xls")) { %>
            <div style="margin-bottom: 20px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; word-break: break-all;">
                <strong>URL Microsoft Office Online :</strong><br>
                <%= officeViewerUrl %>
            </div>
            <iframe src="<%= officeViewerUrl %>" 
                    class="office-viewer"></iframe>
        
        <%-- PowerPoint --%>
        <% } else if (extension.equals("pptx") || extension.equals("ppt")) { %>
            <div style="margin-bottom: 20px; padding: 10px; background: #f0f0f0; border-radius: 8px; font-size: 12px; word-break: break-all;">
                <strong>URL Microsoft Office Online :</strong><br>
                <%= officeViewerUrl %>
            </div>
            <iframe src="<%= officeViewerUrl %>" 
                    class="office-viewer"></iframe>
        
        <%-- Format non supporté --%>
        <% } else { %>
            <div class="unsupported">
                <p>⚠️ Aucun aperçu disponible pour le format <strong><%= extension.toUpperCase() %></strong></p>
                <p style="font-size: 14px; margin-bottom: 30px;">
                    Ce type de fichier ne peut pas être affiché directement dans le navigateur.
                </p>
                <a href="DownloadServlet?file=<%= fileName %>&action=download" 
                   class="download-link">
                    ⬇️ Télécharger le fichier
                </a>
            </div>
        <% } %>
    </div>
</body>
</html>