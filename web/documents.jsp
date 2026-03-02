<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.documents" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Mes documents - QuickClick Convert</title>

    <style>
       :root {
    --bleu-marin: #1e3a5f;
    --bleu-ciel: #e6f3ff;
    --jaune-abricot: #fbc4ab;
    --jaune-abricot-fonce: #f9b091;
    --blanc: #ffffff;
    --gris-clair: #f8fafc;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    font-size: 16px;
    -webkit-text-size-adjust: 100%;
}

body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: var(--bleu-ciel);
    min-height: 100vh;
    padding: clamp(20px, 4vw, 40px) clamp(10px, 3vw, 20px);
    display: flex;
    justify-content: center;
    align-items: flex-start;
    overflow-x: hidden;
    width: 100%;
}

.documents-container {
    max-width: 1200px;
    width: 100%;
    margin: 0 auto;
    background: var(--blanc);
    padding: clamp(24px, 5vw, 40px);
    border-radius: clamp(20px, 4vw, 32px);
    box-shadow: 0 25px 50px -12px rgba(30, 58, 95, 0.15);
}

h2 {
    color: var(--bleu-marin);
    font-size: clamp(24px, 5vw, 32px);
    font-weight: 700;
    margin-bottom: clamp(24px, 4vw, 32px);
    letter-spacing: -0.01em;
    position: relative;
    display: inline-block;
    word-break: break-word;
    hyphens: auto;
    max-width: 100%;
}

h2::after {
    content: '';
    position: absolute;
    bottom: clamp(-8px, -1.5vw, -6px);
    left: 0;
    width: clamp(50px, 10vw, 60px);
    height: clamp(3px, 0.8vw, 4px);
    background: var(--jaune-abricot);
    border-radius: 2px;
}

.error {
    background: #fff5f5;
    color: #c53030;
    padding: clamp(14px, 3vw, 16px) clamp(16px, 3.5vw, 20px);
    border-radius: clamp(12px, 3vw, 16px);
    margin-bottom: clamp(20px, 4vw, 24px);
    border-left: 4px solid #c53030;
    word-break: break-word;
}

.table-responsive {
    overflow-x: auto;
    border-radius: clamp(12px, 3vw, 16px);
    border: 1px solid #e2e8f0;
    -webkit-overflow-scrolling: touch;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    min-width: 800px;
}

thead {
    background: var(--bleu-marin);
}

th {
    color: white;
    font-weight: 600;
    font-size: clamp(12px, 2.5vw, 14px);
    padding: clamp(12px, 2.5vw, 16px) clamp(12px, 2.5vw, 20px);
    text-align: left;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    white-space: nowrap;
}

td {
    padding: clamp(12px, 2.5vw, 16px) clamp(12px, 2.5vw, 20px);
    border-bottom: 1px solid #e2e8f0;
    color: #2d3748;
    font-size: clamp(13px, 2.5vw, 14px);
    word-break: break-word;
}

tr:hover td {
    background: var(--bleu-ciel);
}

.download-link {
    display: inline-flex;
    align-items: center;
    padding: clamp(6px, 2vw, 8px) clamp(12px, 3vw, 16px);
    background: var(--jaune-abricot);
    color: var(--bleu-marin);
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    font-size: clamp(12px, 2.5vw, 13px);
    transition: all 0.2s ease;
    border: 2px solid transparent;
    white-space: nowrap;
}

.download-link:hover {
    background: var(--jaune-abricot-fonce);
    transform: translateY(-2px);
}

.links {
    margin-top: clamp(24px, 5vw, 32px);
    padding-top: clamp(20px, 4vw, 24px);
    border-top: 1px solid #e2e8f0;
    display: flex;
    gap: clamp(12px, 3vw, 24px);
    justify-content: center;
    flex-wrap: wrap;
}

.links a {
    color: var(--bleu-marin);
    text-decoration: none;
    font-weight: 600;
    padding: clamp(6px, 2vw, 8px) clamp(12px, 3vw, 16px);
    border-radius: 50px;
    transition: all 0.2s ease;
    font-size: clamp(13px, 2.8vw, 14px);
    text-align: center;
    white-space: nowrap;
}

.links a:hover {
    background: var(--bleu-ciel);
    color: var(--bleu-marin);
}

@media (max-width: 768px) {
    .documents-container {
        padding: 30px 20px;
    }
    
    th, td {
        padding: 14px;
    }
    
    .links {
        flex-direction: column;
        align-items: center;
        gap: 10px;
    }
    
    .links a {
        width: 100%;
        max-width: 300px;
        white-space: normal;
    }
}

@media (max-width: 640px) {
    body {
        padding: 15px 10px;
    }
    
    .documents-container {
        padding: 25px 16px;
    }
    
    h2 {
        font-size: 26px;
    }
    
    th, td {
        padding: 12px 10px;
    }
}

@media (max-width: 480px) {
    body {
        padding: 10px 8px;
    }
    
    .documents-container {
        padding: 20px 12px;
        border-radius: 20px;
    }
    
    h2 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    
    h2::after {
        width: 50px;
        height: 3px;
    }
    
    th {
        font-size: 11px;
        padding: 10px 8px;
    }
    
    td {
        font-size: 12px;
        padding: 10px 8px;
    }
    
    .download-link {
        padding: 5px 10px;
        font-size: 11px;
    }
    
    .links {
        margin-top: 20px;
        padding-top: 16px;
    }
    
    .links a {
        font-size: 13px;
        padding: 8px 16px;
        max-width: 250px;
    }
}

@media (max-width: 360px) {
    .documents-container {
        padding: 16px 8px;
    }
    
    h2 {
        font-size: 22px;
        margin-bottom: 16px;
    }
    
    th {
        font-size: 10px;
        padding: 8px 5px;
    }
    
    td {
        font-size: 11px;
        padding: 8px 5px;
    }
    
    .download-link {
        padding: 4px 8px;
        font-size: 10px;
    }
    
    .links a {
        font-size: 12px;
        padding: 6px 12px;
    }
}

@media (min-width: 1400px) {
    .documents-container {
        max-width: 1300px;
        padding: 50px;
    }
    
    h2 {
        font-size: 36px;
    }
    
    th {
        font-size: 16px;
        padding: 20px 24px;
    }
    
    td {
        font-size: 16px;
        padding: 20px 24px;
    }
    
    .download-link {
        font-size: 14px;
        padding: 10px 20px;
    }
    
    .links a {
        font-size: 16px;
    }
}

@media (hover: none) and (pointer: coarse) {
    .download-link:hover,
    .links a:hover {
        transform: none;
    }
    
    tr:hover td {
        background: none;
    }
    
    .download-link:active {
        background: var(--jaune-abricot-fonce);
        transform: scale(0.95);
    }
    
    .links a:active {
        background: var(--bleu-ciel);
    }
}

img, video, iframe, table {
    max-width: 100%;
    height: auto;
}

@media (prefers-contrast: high) {
    .error {
        border: 2px solid #c53030;
    }
    
    th {
        background: #0f2a44;
    }
    
    table {
        border: 2px solid var(--bleu-marin);
    }
}

.table-responsive::after {
    display: none;
}

@media (max-width: 820px) {
    .table-responsive {
        position: relative;
    }
    
    .table-responsive::after {
        content: '← Glissez pour voir plus →';
        display: block;
        text-align: center;
        padding: 10px;
        font-size: 12px;
        color: var(--bleu-marin);
        background: var(--bleu-ciel);
        border-radius: 0 0 12px 12px;
        font-weight: 500;
        letter-spacing: 0.5px;
    }
}

@media (max-width: 480px) {
    .table-responsive::after {
        font-size: 11px;
        padding: 8px;
    }
}

@keyframes fadeInSlide {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.table-responsive::after {
    animation: fadeInSlide 0.5s ease-out;
}

@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
    
    .table-responsive::after {
        animation: none;
    }
}
    </style>
</head>
<body>
<div class="documents-container">
    <h2>Mes documents convertis</h2>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="error"><%= error %></div>
    <% } %>

    <%
        List<documents> docs = (List<documents>) request.getAttribute("documents");
        if (docs != null && !docs.isEmpty()) {
    %>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom du fichier</th>
                        <th>Type avant</th>
                        <th>Type après</th>
                        <th>Nom du fichier Converti</th>
                        <th>Date de conversion</th>
                        <th>Télécharger</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (documents doc : docs) {
                        
                        String nomConverti = doc.getNomFichierConverti();
                %>
                    <tr>
                        <td><%= doc.getId() %></td>
                        <td><%= doc.getNomFichier() %></td>
                        <td><%= doc.getTypeAvant() %></td>
                        <td><%= doc.getTypeApres() %></td>
                        <td><%= doc.getNomFichierConverti() %> </td>
                        <td><%= doc.getDateConversion() %></td>
                        <td>
                            <a class="download-link" href="DownloadServlet?file=<%= nomConverti %>" target="_blank">Télécharger</a>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    <% } else { %>
        <p style="text-align:center; margin-top:20px; font-size: clamp(14px, 3vw, 16px);">Aucun document converti pour le moment.</p>
    <% } %>

    <div class="links">
        <p><a href="convert.jsp">Convertir un nouveau document</a></p>
        <p><a href="logout.jsp">Se déconnecter</a></p>
    </div>
</div>
</body>
</html>