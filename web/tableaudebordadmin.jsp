<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dto.DocumentDTO, model.utilisateur" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Admin Dashboard</title>
  <style>
    :root {
        --bleu-marin: #1e3a5f;
        --bleu-ciel: #e6f3ff;
        --jaune-abricot: #fbc4ab;
        --jaune-abricot-fonce: #f9b091;
        --blanc: #ffffff;
        --gris-clair: #f8fafc;
        --gris-texte: #4a5568;
        --rouge-erreur: #c53030;
        --vert-succes: #276749;
        --ombre-subtile: 0 20px 40px -15px rgba(30, 58, 95, 0.15);
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
        background: linear-gradient(145deg, var(--bleu-ciel) 0%, #d4e7f0 100%);
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
        width: 100%;
    }

    /* Éléments décoratifs */
    body::before {
        content: '';
        position: fixed;
        top: -100px;
        right: -100px;
        width: min(500px, 80vw);
        height: min(500px, 80vw);
        background: radial-gradient(circle, rgba(251, 196, 171, 0.08) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
        z-index: 0;
    }

    body::after {
        content: '';
        position: fixed;
        bottom: -100px;
        left: -100px;
        width: min(500px, 80vw);
        height: min(500px, 80vw);
        background: radial-gradient(circle, rgba(30, 58, 95, 0.05) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
        z-index: 0;
    }

    /* Header */
    .header {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        color: var(--bleu-marin);
        padding: clamp(15px, 3vw, 20px) clamp(20px, 4vw, 40px);
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: relative;
        z-index: 10;
        box-shadow: var(--ombre-subtile);
        flex-wrap: wrap;
        gap: 15px;
    }

    .header h1 {
        font-size: clamp(22px, 5vw, 28px);
        font-weight: 700;
        letter-spacing: -0.5px;
        background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        word-break: break-word;
        hyphens: auto;
    }

    .header div {
        display: flex;
        align-items: center;
        gap: clamp(10px, 2vw, 20px);
        flex-wrap: wrap;
        justify-content: center;
    }

    .header span {
        color: var(--gris-texte);
        font-weight: 500;
        font-size: clamp(13px, 3vw, 15px);
        word-break: break-word;
    }

    .logout-btn {
        background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
        color: white;
        padding: clamp(8px, 2vw, 10px) clamp(16px, 3vw, 24px);
        border-radius: 40px;
        text-decoration: none;
        font-weight: 600;
        font-size: clamp(13px, 2.5vw, 14px);
        transition: all 0.3s ease;
        border: 1px solid transparent;
        white-space: nowrap;
    }

    .logout-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px -8px rgba(30, 58, 95, 0.3);
        background: linear-gradient(135deg, #15304d 0%, #0e2439 100%);
    }

    /* Layout */
    .container {
        display: flex;
        max-width: 1600px;
        margin: 0 auto;
        padding: clamp(15px, 3vw, 20px);
        gap: clamp(15px, 3vw, 20px);
        position: relative;
        z-index: 5;
        flex-wrap: wrap;
    }

    /* Sidebar */
    .sidebar {
        width: 280px;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border-radius: 24px;
        padding: 20px 0;
        box-shadow: var(--ombre-subtile);
        border: 1px solid rgba(255, 255, 255, 0.2);
        height: fit-content;
        position: sticky;
        top: 20px;
        flex-shrink: 0;
    }

    .sidebar a {
        display: block;
        padding: clamp(12px, 2.5vw, 15px) clamp(20px, 3vw, 25px);
        text-decoration: none;
        color: var(--gris-texte);
        font-weight: 500;
        border-left: 4px solid transparent;
        transition: all 0.3s ease;
        cursor: pointer;
        margin: 4px 0;
        font-size: clamp(14px, 2.5vw, 15px);
        word-break: break-word;
    }

    .sidebar a:hover {
        background: rgba(251, 196, 171, 0.1);
        border-left-color: var(--jaune-abricot);
        color: var(--bleu-marin);
    }

    .sidebar a.active {
        background: rgba(30, 58, 95, 0.05);
        border-left-color: var(--bleu-marin);
        color: var(--bleu-marin);
        font-weight: 600;
    }

    /* Main Content */
    .main-content {
        flex: 1;
        min-width: 300px;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        border-radius: 24px;
        padding: clamp(20px, 4vw, 30px);
        box-shadow: var(--ombre-subtile);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    /* Stats Cards */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(min(240px, 100%), 1fr));
        gap: clamp(15px, 3vw, 20px);
        margin-bottom: clamp(25px, 4vw, 30px);
    }

    .stat-card {
        background: var(--blanc);
        padding: clamp(20px, 4vw, 25px);
        border-radius: 20px;
        box-shadow: 0 10px 20px -5px rgba(30, 58, 95, 0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.1);
        position: relative;
        overflow: hidden;
    }

    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(90deg, var(--bleu-marin), var(--jaune-abricot));
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 30px -10px rgba(30, 58, 95, 0.15);
    }

    .stat-card h3 {
        color: var(--gris-texte);
        font-size: clamp(0.9em, 2.5vw, 0.95em);
        font-weight: 500;
        margin-bottom: clamp(8px, 2vw, 10px);
        letter-spacing: 0.3px;
    }

    .stat-card .number {
        font-size: clamp(2em, 5vw, 2.5em);
        font-weight: 700;
        color: var(--bleu-marin);
        line-height: 1.2;
        word-break: break-word;
    }

    /* Tables */
    .table-card {
        background: var(--blanc);
        border-radius: 20px;
        padding: clamp(20px, 4vw, 25px);
        margin-bottom: 25px;
        box-shadow: 0 10px 20px -5px rgba(30, 58, 95, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.1);
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }

    .table-card h2 {
        color: var(--bleu-marin);
        font-size: clamp(18px, 4vw, 20px);
        font-weight: 600;
        letter-spacing: -0.3px;
        word-break: break-word;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 600px;
    }

    th {
        background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        padding: clamp(12px, 2.5vw, 15px);
        text-align: left;
        font-weight: 600;
        font-size: clamp(0.8em, 2.2vw, 0.9em);
        color: var(--bleu-marin);
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 2px solid var(--jaune-abricot);
        white-space: nowrap;
    }

    td {
        padding: clamp(12px, 2.5vw, 15px);
        border-bottom: 1px solid #edf2f7;
        color: var(--gris-texte);
        font-size: clamp(0.85em, 2.5vw, 0.95em);
        word-break: break-word;
    }

    tr:hover td {
        background: rgba(251, 196, 171, 0.05);
    }

    /* Badges */
    .badge {
        display: inline-block;
        padding: clamp(4px, 1.5vw, 6px) clamp(8px, 2vw, 12px);
        border-radius: 30px;
        font-size: clamp(0.75em, 2.2vw, 0.85em);
        font-weight: 600;
        letter-spacing: 0.3px;
        white-space: nowrap;
    }

    .badge-success {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
        border: 1px solid rgba(21, 87, 36, 0.1);
    }

    .badge-info {
        background: linear-gradient(135deg, #cce5ff 0%, #b8daff 100%);
        color: #004085;
        border: 1px solid rgba(0, 64, 133, 0.1);
    }

    /* Boutons */
    .btn-nav, .btn-primary, .btn-download, .btn-view, .btn-delete {
        padding: clamp(8px, 2vw, 10px) clamp(12px, 3vw, 18px);
        border-radius: 40px;
        font-weight: 600;
        font-size: clamp(0.8em, 2.5vw, 0.9em);
        cursor: pointer;
        transition: all 0.3s ease;
        border: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: clamp(4px, 1.5vw, 8px);
        text-decoration: none;
        white-space: nowrap;
    }

    .btn-primary {
        background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
        color: white;
        box-shadow: 0 5px 15px -5px rgba(30, 58, 95, 0.3);
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px -5px rgba(30, 58, 95, 0.4);
    }

    .btn-nav {
        background: rgba(251, 196, 171, 0.2);
        color: var(--bleu-marin);
        border: 1px solid rgba(251, 196, 171, 0.3);
    }

    .btn-nav:hover {
        background: var(--jaune-abricot);
        transform: translateY(-2px);
    }

    .btn-download {
        background: linear-gradient(135deg, #28a745 0%, #218838 100%);
        color: white;
    }

    .btn-download:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px -5px #28a745;
    }

    .btn-view {
        background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
        color: white;
    }

    .btn-view:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px -5px #17a2b8;
    }

    .btn-delete {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
    }

    .btn-delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px -5px #dc3545;
    }

    .actions {
        display: flex;
        gap: clamp(6px, 1.5vw, 8px);
        flex-wrap: wrap;
    }

    /* Messages d'erreur/succès */
    .error-message, .success-message {
        padding: clamp(14px, 3vw, 16px) clamp(20px, 4vw, 24px);
        border-radius: clamp(12px, 3vw, 16px);
        margin-bottom: 25px;
        font-size: clamp(14px, 3vw, 15px);
        display: flex;
        align-items: center;
        gap: clamp(8px, 2vw, 12px);
        animation: slideIn 0.4s ease-out;
        word-break: break-word;
    }

    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateX(-10px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .error-message {
        background: #fff8f8;
        color: var(--rouge-erreur);
        border-left: 4px solid var(--rouge-erreur);
    }

    .success-message {
        background: #f4fef7;
        color: var(--vert-succes);
        border-left: 4px solid #48bb78;
    }

    /* Date */
    .date {
        color: var(--gris-texte);
        font-size: clamp(0.8em, 2.5vw, 0.9em);
        font-weight: 500;
        white-space: nowrap;
    }

    /* Filename */
    .filename {
        max-width: min(250px, 30vw);
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        font-weight: 500;
    }

    /* Filter buttons */
    .filter-buttons {
        display: flex;
        gap: clamp(8px, 2vw, 10px);
        margin-bottom: 20px;
        flex-wrap: wrap;
    }

    .filter-btn {
        padding: clamp(6px, 2vw, 8px) clamp(12px, 3vw, 20px);
        border: 1px solid #e2e8f0;
        background: white;
        border-radius: 30px;
        cursor: pointer;
        font-weight: 500;
        color: var(--gris-texte);
        transition: all 0.3s ease;
        font-size: clamp(13px, 2.5vw, 14px);
        white-space: nowrap;
    }

    .filter-btn:hover {
        background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
        color: white;
        border-color: transparent;
    }

    /* Search input */
    #searchDoc {
        padding: clamp(10px, 2.5vw, 12px) clamp(16px, 3vw, 20px);
        border: 2px solid #edf2f7;
        border-radius: 40px;
        width: 100%;
        max-width: min(350px, 100%);
        font-size: clamp(13px, 2.5vw, 14px);
        transition: all 0.3s ease;
        background: white;
    }

    #searchDoc:focus {
        outline: none;
        border-color: var(--bleu-marin);
        box-shadow: 0 0 0 4px rgba(30, 58, 95, 0.08);
    }

    /* Message pour indiquer le défilement horizontal */
    .table-card {
        position: relative;
    }

    @media (max-width: 768px) {
        .table-card::after {
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
            margin-top: 10px;
        }
    }

    /* Responsive */
    @media (max-width: 1024px) {
        .container {
            flex-direction: column;
        }
        
        .sidebar {
            width: 100%;
            position: static;
            display: flex;
            flex-wrap: wrap;
            padding: 10px;
        }
        
        .sidebar a {
            flex: 1 1 auto;
            text-align: center;
            border-left: none;
            border-bottom: 4px solid transparent;
            padding: 12px;
            min-width: 120px;
        }
        
        .sidebar a:hover {
            border-left-color: transparent;
            border-bottom-color: var(--jaune-abricot);
        }
        
        .sidebar a.active {
            border-left-color: transparent;
            border-bottom-color: var(--bleu-marin);
        }
    }

    @media (max-width: 768px) {
        .header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
            padding: 15px;
        }
        
        .header div {
            width: 100%;
            justify-content: center;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .table-card {
            padding: 15px;
        }
        
        .actions {
            flex-direction: column;
        }
        
        .btn-nav, .btn-primary {
            width: 100%;
            justify-content: center;
        }
        
        #searchDoc {
            max-width: 100%;
        }
        
        .filter-buttons {
            justify-content: center;
        }
    }

    @media (max-width: 480px) {
        .sidebar a {
            min-width: 100%;
        }
        
        table {
            min-width: 500px;
        }
        
        td, th {
            padding: 10px 8px;
            font-size: 0.85em;
        }
        
        .badge {
            font-size: 0.7em;
            padding: 3px 6px;
        }
        
        .btn-nav, .btn-primary {
            font-size: 0.85em;
        }
        
        .header h1 {
            font-size: 20px;
        }
    }

    @media (max-width: 360px) {
        .main-content {
            padding: 15px;
        }
        
        table {
            min-width: 450px;
        }
        
        td, th {
            padding: 8px 5px;
            font-size: 0.8em;
        }
        
        .btn-nav, .btn-primary {
            font-size: 0.8em;
            padding: 6px 10px;
        }
    }

    /* Style pour la sélection de texte */
    ::selection {
        background: var(--jaune-abricot);
        color: var(--bleu-marin);
    }

    /* Améliorations tactiles pour mobile */
    @media (hover: none) and (pointer: coarse) {
        .btn-nav:hover,
        .btn-primary:hover,
        .stat-card:hover,
        .filter-btn:hover {
            transform: none;
        }
        
        tr:hover td {
            background: none;
        }
        
        .btn-primary:active {
            transform: scale(0.98);
        }
        
        .sidebar a:active {
            background: rgba(251, 196, 171, 0.2);
        }
    }

    /* Désactiver l'animation si l'utilisateur préfère moins de mouvement */
    @media (prefers-reduced-motion: reduce) {
        * {
            animation-duration: 0.01ms !important;
            animation-iteration-count: 1 !important;
            transition-duration: 0.01ms !important;
        }
        
        .error-message, .success-message {
            animation: none;
        }
        
        .stat-card:hover {
            transform: none;
        }
    }
</style>
</head>
<body>
    <%
        List<DocumentDTO> documents = (List<DocumentDTO>) request.getAttribute("documents");
        List<utilisateur> utilisateurs = (List<utilisateur>) request.getAttribute("utilisateurs");
        String adminEmail = (String) session.getAttribute("email");
        
        int totalDocuments = documents != null ? documents.size() : 0;
        int totalUtilisateurs = utilisateurs != null ? utilisateurs.size() : 0;
    %>

    <!-- Header -->
    <header class="header">
        <h1>📊 Admin Dashboard</h1>
        <div>
            <span><%= adminEmail %> (Admin)</span>
            <a href="${pageContext.request.contextPath}/DeconnexionServlet" class="logout-btn">Déconnexion</a>
        </div>
    </header>

    <div class="container">
        <!-- Sidebar -->
        <nav class="sidebar">
            <a class="active" onclick="showSection('dashboard')">📊 Tableau de bord</a>
            <a onclick="showSection('documents')">📄 Documents</a>
            <a onclick="showSection('utilisateurs')">👥 Utilisateurs</a>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Messages -->
            <% if(request.getAttribute("error") != null) { %>
                <div style="background:#f8d7da; color:#721c24; padding:10px; margin-bottom:20px;">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- Dashboard Section -->
            <div id="dashboard-section" class="content-section">
                <div class="stats-grid">
                    <div class="stat-card">
                        <h3>📄 Total documents</h3>
                        <div class="number"><%= totalDocuments %></div>
                    </div>
                    <div class="stat-card">
                        <h3>👥 Total utilisateurs</h3>
                        <div class="number"><%= totalUtilisateurs %></div>
                    </div>
                </div>

                <!-- Boutons de navigation rapide -->
                <div style="display: flex; gap: 15px; margin-bottom: 30px; flex-wrap: wrap;">
                   <a href="${pageContext.request.contextPath}/ListeDocumentsServlet" class="btn-primary" style="text-decoration: none; display: inline-block;">
                            📄 Voir tous les documents
                   </a>
                    <button class="btn-primary" onclick="showSection('utilisateurs')">👥 Voir tous les utilisateurs</button>
                    <button class="btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/AdminServlet'">🔄 Rafraîchir</button>
                </div>

                <!-- Derniers documents -->
                <div class="table-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; flex-wrap: wrap; gap: 10px;">
                        <h2>📄 Derniers documents</h2>
                        <a href="${pageContext.request.contextPath}/ListeDocumentsServlet" class="btn-nav" style="text-decoration: none;">
                            Voir tout →
                        </a>
                    </div>
                    <table>
                        <thead>
                            <tr><th>ID</th><th>Utilisateur</th><th>Fichier</th><th>Conversion</th><th>Date</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                            <% if(documents != null && !documents.isEmpty()) { 
                                int count = 0;
                                for(DocumentDTO doc : documents) { 
                                    if(count++ >= 5) break;
                            %>
                            <tr>
                                <td>#<%= doc.getId() %></td>
                                <td><%= doc.getUserEmail() %></td>
                                <td><%= doc.getNomFichier() %></td>
                                <td>
                                    <span class="badge badge-info"><%= doc.getTypeAvant() %></span> →
                                    <span class="badge badge-success"><%= doc.getTypeApres() %></span>
                                </td>
                                <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(doc.getDateConversion()) %></td>
                                <td>
                                    <button onclick="viewFile('<%= doc.getNomFichierConverti() %>')" title="Voir">👁️</button>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr><td colspan="6" style="text-align: center;">Aucun document trouvé</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Derniers utilisateurs -->
                <div class="table-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; flex-wrap: wrap; gap: 10px;">
                        <h2>👥 Derniers utilisateurs</h2>
                        <button class="btn-nav" onclick="showSection('utilisateurs')">Voir tout →</button>
                    </div>
                    <table>
                        <thead>
                            <tr><th>ID</th><th>Email</th><th>Rôle</th><th>Date</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                            <% if(utilisateurs != null && !utilisateurs.isEmpty()) { 
                                int count = 0;
                                for(utilisateur user : utilisateurs) { 
                                    if(count++ >= 5) break;
                            %>
                            <tr>
                                <td>#<%= user.getId() %></td>
                                <td><%= user.getEmail() %></td>
                                <td>
                                    <span class="badge <%= "admin".equals(user.getRole()) ? "badge-success" : "badge-info" %>">
                                        <%= user.getRole() %>
                                    </span>
                                </td>
                                <td>01/01/2024</td>
                                <td>
                                    <button onclick="voirFichiersUtilisateur(<%= user.getId() %>)" title="Voir ses fichiers">📁</button>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr><td colspan="5" style="text-align: center;">Aucun utilisateur trouvé</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Documents Section -->
            <div id="documents-section" class="content-section" style="display:none;">
                <div class="table-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
                        <h2>📄 Tous les documents</h2>
                        <button class="btn-nav" onclick="showSection('dashboard')">← Retour au tableau de bord</button>
                    </div>
                    
                    <input type="text" id="searchDoc" placeholder="Rechercher un document..." 
                           style="padding:8px; margin-bottom:15px; width:300px; border:1px solid #ddd; border-radius:5px;"
                           onkeyup="searchDocuments()">
                    
                    <table id="documents-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Fichier original</th>
                                <th>Type</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(documents != null) for(DocumentDTO doc : documents) { %>
                            <tr>
                                <td>#<%= doc.getId() %></td>
                                <td><%= doc.getUserEmail() %></td>
                                <td><%= doc.getNomFichier() %></td>
                                <td>
                                    <span class="badge badge-info"><%= doc.getTypeAvant() %></span> → 
                                    <span class="badge badge-success"><%= doc.getTypeApres() %></span>
                                </td>
                                <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(doc.getDateConversion()) %></td>
                                <td>
                                    <button onclick="viewFile('<%= doc.getNomFichierConverti() %>')" title="Voir">👁️</button>
                                    <button onclick="downloadFile('<%= doc.getNomFichierConverti() %>')" title="Télécharger">📥</button>
                                    <button onclick="deleteDocument(<%= doc.getId() %>)" title="Supprimer">🗑️</button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="utilisateurs-section" class="content-section" style="display:none;">
                <div class="table-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 10px;">
                        <h2>👥 Gestion des utilisateurs</h2>
                        <button class="btn-nav" onclick="showSection('dashboard')">← Retour au tableau de bord</button>
                    </div>
                    
                    <div class="filter-buttons">
                        <button class="filter-btn" onclick="filterUsers('all')">Tous</button>
                        <button class="filter-btn" onclick="filterUsers('admin')">Admins</button>
                        <button class="filter-btn" onclick="filterUsers('utilisateur')">Utilisateurs</button>
                    </div>
                    
                    <table id="users-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Email</th>
                                <th>Rôle</th>
                                <th>Date inscription</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(utilisateurs != null) for(utilisateur user : utilisateurs) { %>
                            <tr data-role="<%= user.getRole() %>">
                                <td>#<%= user.getId() %></td>
                                <td><%= user.getEmail() %></td>
                                <td>
                                    <span class="badge <%= "admin".equals(user.getRole()) ? "badge-success" : "badge-info" %>">
                                        <%= user.getRole() %>
                                    </span>
                                </td>
                                <td>01/01/2024</td>
                                <td>
                                    <button onclick="voirFichiersUtilisateur(<%= user.getId() %>)" title="Voir ses documents">📁</button>
                                    <button onclick="location.href='${pageContext.request.contextPath}/admin/modifier-utilisateur?id=<%= user.getId() %>'" title="Modifier">✏️</button>
                                    <button onclick="bloquerUtilisateur(<%= user.getId() %>)" title="Bloquer">🔒</button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>

        function showSection(section) {
            document.querySelectorAll('.content-section').forEach(el => el.style.display = 'none');
            document.getElementById(section + '-section').style.display = 'block';
            
            document.querySelectorAll('.sidebar a').forEach(el => el.classList.remove('active'));
            event.currentTarget.classList.add('active');
        }
        

        function filterUsers(role) {
            document.querySelectorAll('#users-table tbody tr').forEach(row => {
                if(role === 'all' || row.dataset.role === role) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        

        function searchDocuments() {
            let search = document.getElementById('searchDoc').value.toLowerCase();
            document.querySelectorAll('#documents-table tbody tr').forEach(row => {
                let text = row.textContent.toLowerCase();
                row.style.display = text.includes(search) ? '' : 'none';
            });
        }
        

        function viewFile(filename) { 
            window.open('${pageContext.request.contextPath}/view?file=' + filename, '_blank'); 
        }
        
        function downloadFile(filename) { 
            window.location.href = '${pageContext.request.contextPath}/download?file=' + filename; 
        }
        
        function voirFichiersUtilisateur(userId) { 
            window.location.href = '${pageContext.request.contextPath}/admin/fichiers-utilisateur?userId=' + userId; 
        }
        
        function deleteDocument(id) {
            if(confirm('Supprimer ce document ?')) {
                let form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/AdminServlet';
                form.innerHTML = '<input type="hidden" name="action" value="supprimer">' +
                                '<input type="hidden" name="id" value="'+id+'">';
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function bloquerUtilisateur(id) {
            if(confirm('Bloquer cet utilisateur ?')) {
                alert('Fonctionnalité à implémenter');
               
            }
        }
    </script>
</body>
</html>