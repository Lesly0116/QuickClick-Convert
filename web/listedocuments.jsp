<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, dto.DocumentDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Administration - Documents convertis</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            padding: clamp(10px, 2vw, 20px);
            display: flex;
            justify-content: center;
            align-items: flex-start;
            width: 100%;
        }

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

        .container {
            max-width: 1400px;
            width: 100%;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-radius: clamp(20px, 4vw, 32px);
            box-shadow: var(--ombre-subtile);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            position: relative;
            z-index: 10;
        }

        .header {
            background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
            color: white;
            padding: clamp(20px, 3vw, 25px) clamp(20px, 4vw, 40px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            z-index: 10;
            flex-wrap: wrap;
            gap: 15px;
        }

        .header h1 {
            font-size: clamp(20px, 4vw, 28px);
            font-weight: 700;
            letter-spacing: -0.5px;
            word-break: break-word;
            hyphens: auto;
        }

        .header p {
            font-size: clamp(14px, 3vw, 16px);
            font-weight: 500;
            opacity: 0.95;
            word-break: break-word;
        }

        .logout {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: clamp(8px, 2vw, 10px) clamp(16px, 3vw, 24px);
            border-radius: 40px;
            text-decoration: none;
            font-weight: 600;
            font-size: clamp(13px, 2.5vw, 14px);
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
            white-space: nowrap;
        }

        .logout:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .content {
            padding: clamp(20px, 4vw, 40px);
        }

        .error-message, .success-message {
            padding: clamp(14px, 3vw, 16px) clamp(20px, 4vw, 24px);
            border-radius: clamp(12px, 3vw, 16px);
            margin-bottom: clamp(24px, 4vw, 30px);
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

        .stats {
            display: flex;
            gap: clamp(15px, 3vw, 25px);
            margin-bottom: clamp(30px, 5vw, 35px);
            flex-wrap: wrap;
        }

        .stat-card {
            flex: 1 1 auto;
            min-width: min(200px, 100%);
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

        .table-container {
            background: var(--blanc);
            border-radius: 24px;
            padding: 5px;
            box-shadow: 0 10px 20px -5px rgba(30, 58, 95, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.1);
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1000px;
        }

        th {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            padding: clamp(12px, 2.5vw, 18px) clamp(10px, 2vw, 15px);
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
            padding: clamp(12px, 2.5vw, 18px) clamp(10px, 2vw, 15px);
            border-bottom: 1px solid #edf2f7;
            color: var(--gris-texte);
            font-size: clamp(0.85em, 2.5vw, 0.95em);
            word-break: break-word;
        }

        tr:hover td {
            background: rgba(251, 196, 171, 0.05);
        }

        .badge {
            display: inline-block;
            padding: clamp(4px, 1.5vw, 6px) clamp(10px, 2.5vw, 14px);
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

        .btn {
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

        .btn-download {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            box-shadow: 0 5px 15px -5px #28a745;
        }

        .btn-download:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px #28a745;
        }

        .btn-view {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            color: white;
            box-shadow: 0 5px 15px -5px #17a2b8;
        }

        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px #17a2b8;
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 5px 15px -5px #dc3545;
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -5px #dc3545;
        }

        .actions {
            display: flex;
            gap: clamp(6px, 1.5vw, 8px);
            flex-wrap: wrap;
        }

        .date {
            color: var(--gris-texte);
            font-size: clamp(0.8em, 2.5vw, 0.9em);
            font-weight: 500;
            white-space: nowrap;
        }

        .filename {
            max-width: min(250px, 30vw);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-weight: 500;
        }

        @media (max-width: 1024px) {
            .content {
                padding: 30px 20px;
            }
            
            .stats {
                flex-direction: column;
            }
            
            .stat-card {
                min-width: 100%;
            }
            
            .filename {
                max-width: 150px;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
                padding: 20px;
            }
            
            .header h1 {
                font-size: 24px;
            }
            
            .header p {
                font-size: 14px;
            }
            
            .logout {
                width: 100%;
                text-align: center;
            }
            
            .content {
                padding: 20px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
                font-size: 0.9em;
            }
            
            .filename {
                max-width: 120px;
            }
        }

        @media (max-width: 480px) {
            .container {
                border-radius: 20px;
            }
            
            .header {
                padding: 15px;
            }
            
            .header h1 {
                font-size: 20px;
            }
            
            .content {
                padding: 15px;
            }
            
            .stat-card {
                padding: 15px;
            }
            
            .stat-card .number {
                font-size: 2em;
            }
            
            .filename {
                max-width: 80px;
            }
            
            td, th {
                padding: 10px 8px;
            }
            
            .date {
                font-size: 0.75em;
            }
            
            .btn {
                padding: 6px 10px;
                font-size: 0.75em;
            }
            
            .badge {
                padding: 4px 8px;
                font-size: 0.7em;
            }
        }

        @media (max-width: 360px) {
            .header h1 {
                font-size: 18px;
            }
            
            .filename {
                max-width: 60px;
            }
            
            td, th {
                padding: 8px 5px;
                font-size: 0.75em;
            }
            
            .btn {
                padding: 4px 6px;
                font-size: 0.7em;
            }
        }

        @media (min-width: 1600px) {
            .container {
                max-width: 1600px;
            }
            
            th {
                font-size: 1em;
                padding: 20px 18px;
            }
            
            td {
                font-size: 1em;
                padding: 20px 18px;
            }
            
            .btn {
                font-size: 0.95em;
                padding: 12px 20px;
            }
        }

        .table-container {
            position: relative;
        }

        @media (max-width: 1100px) {
            .table-container::after {
                content: '← Glissez pour voir plus →';
                display: block;
                text-align: center;
                padding: 10px;
                font-size: clamp(11px, 2.5vw, 12px);
                color: var(--bleu-marin);
                background: var(--bleu-ciel);
                border-radius: 0 0 12px 12px;
                font-weight: 500;
                letter-spacing: 0.5px;
                animation: fadeInSlide 0.5s ease-out;
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

        @media (hover: none) and (pointer: coarse) {
            .btn:hover,
            .stat-card:hover,
            .logout:hover {
                transform: none;
            }
            
            tr:hover td {
                background: none;
            }
            
            .btn:active {
                transform: scale(0.95);
            }
            
            .logout:active {
                background: rgba(255, 255, 255, 0.3);
            }
        }

        ::selection {
            background: var(--jaune-abricot);
            color: var(--bleu-marin);
        }

        @media (prefers-contrast: high) {
            .error-message {
                border: 2px solid var(--rouge-erreur);
            }
            
            .success-message {
                border: 2px solid #48bb78;
            }
            
            .btn {
                border: 2px solid transparent;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
            
            .table-container::after {
                animation: none;
            }
            
            .stat-card:hover {
                transform: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Administration - Documents convertis</h1>
            <p>Bienvenue, ${adminEmail != null ? adminEmail : sessionScope.email}</p>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout">Déconnexion</a>
        </div>
        
        <div class="content">

            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if(session.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= session.getAttribute("success") %>
                    <% session.removeAttribute("success"); %>
                </div>
            <% } %>
            
            <% 
            List<DocumentDTO> docs = (List<DocumentDTO>) request.getAttribute("documents");
            
            if(docs != null && !docs.isEmpty()) { 
            %>
            
            <div class="stats">
                <div class="stat-card">
                    <h3>Total documents</h3>
                    <div class="number"><%= docs.size() %></div>
                </div>
                
                <% 
                java.util.Set<String> types = new java.util.HashSet<>();
                for(DocumentDTO doc : docs) {
                    types.add(doc.getTypeAvant() + " → " + doc.getTypeApres());
                }
                %>
                
                <div class="stat-card">
                    <h3>Types de conversion</h3>
                    <div class="number"><%= types.size() %></div>
                </div>
            </div>
            
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Fichier original</th>
                            <th>Type avant</th>
                            <th>Type après</th>
                            <th>Date conversion</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(DocumentDTO doc : docs) { %>
                        <tr>
                            <td>#<%= doc.getId() %></td>
                            <td><%= doc.getUserEmail() != null ? doc.getUserEmail() : "Non disponible" %></td>
                            <td class="filename" title="<%= doc.getNomFichier() %>">
                                <%= doc.getNomFichier() %>
                            </td>
                            <td>
                                <span class="badge badge-success"><%= doc.getTypeAvant() %></span>
                            </td>
                            <td>
                                <span class="badge badge-success"><%= doc.getTypeApres() %></span>
                            </td>
                            <td>
                                <div class="date">
                                    <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(doc.getDateConversion()) %>
                                </div>
                            </td>
                            <td>
                                <div class="actions">
                                    <a href="${pageContext.request.contextPath}/download?file=<%= doc.getNomFichierConverti() %>" 
                                       class="btn btn-download">📥 Télécharger</a>
                                    
                                    <button onclick="voirFichier('<%= doc.getNomFichierConverti() %>')" 
                                            class="btn btn-view">👁️ Voir</button>
                                    
                                    <button onclick="confirmerSuppression(<%= doc.getId() %>, '<%= doc.getNomFichier() %>')" 
                                            class="btn btn-delete">🗑️ Supprimer</button>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            
            <% } else { %>
            <div class="error-message" style="text-align: center; padding: clamp(30px, 5vw, 50px);">
                <h3 style="font-size: clamp(20px, 4vw, 24px); margin-bottom: 15px;">Aucun document trouvé</h3>
                <p style="font-size: clamp(14px, 3vw, 16px); opacity: 0.8;">Il n'y a pas encore de documents convertis sur le site.</p>
                <p style="font-size: clamp(11px, 2.5vw, 12px); color: #666; margin-top: 20px;">
                    Email session: <%= session.getAttribute("email") %><br>
                    Rôle session: <%= session.getAttribute("role") %>
                </p>
            </div>
            <% } %>
        </div>
    </div>
    
    <script>
        function confirmerSuppression(id, nomFichier) {
            if(confirm('Êtes-vous sûr de vouloir supprimer le document "' + nomFichier + '" ?\nCette action est irréversible.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/AdminServlet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'supprimer';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function voirFichier(nomFichier) {
            window.open('${pageContext.request.contextPath}/view?file=' + nomFichier, '_blank');
        }
    </script>
</body>
</html>