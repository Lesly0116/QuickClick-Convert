<%-- 
    Document   : accueille
    Created on : Jan 14, 2026, 3:36:50 PM
    Author     : Jean Lesly JOCELYN
--%>

<%@page contentType = "text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
        <title>Convertisseur de fichiers - QuickClick Convert</title>
        
        <!-- Google Fonts - Inter -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;550;600&display=swap" rel="stylesheet">
        
        <style>
            :root {
                --bleu-marin: #1e3a5f;
                --bleu-ciel: #e6f3ff;
                --jaune-abricot: #fbc4ab;
                --jaune-abricot-doux: #ffe4d6;
                --blanc: #ffffff;
                --gris-doux: #f7fafc;
                --gris-texte: #4a5568;
                --ombre-subtile: 0 15px 35px -10px rgba(30, 58, 95, 0.08);
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
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 16px;
                position: relative;
                overflow-x: hidden;
                width: 100%;
            }

            body::before {
                content: '';
                position: fixed;
                top: -10%;
                right: -5%;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(251, 196, 171, 0.12) 0%, transparent 70%);
                border-radius: 50%;
                pointer-events: none;
            }

            body::after {
                content: '';
                position: fixed;
                bottom: -10%;
                left: -5%;
                width: 400px;
                height: 400px;
                background: radial-gradient(circle, rgba(30, 58, 95, 0.06) 0%, transparent 70%);
                border-radius: 50%;
                pointer-events: none;
            }

            .convert-container {
                max-width: 540px;
                width: 100%;
                background: var(--blanc);
                padding: clamp(32px, 6vw, 48px) clamp(20px, 5vw, 44px);
                border-radius: clamp(20px, 4vw, 28px);
                box-shadow: var(--ombre-subtile);
                position: relative;
                z-index: 10;
                border: 1px solid rgba(255, 255, 255, 0.7);
                backdrop-filter: blur(8px);
                margin: 10px;
            }

            .convert-container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 24px;
                right: 24px;
                height: 3px;
                background: linear-gradient(90deg, var(--bleu-marin) 0%, var(--jaune-abricot) 50%, var(--bleu-marin) 100%);
                border-radius: 3px 3px 0 0;
            }

            @media (max-width: 480px) {
                .convert-container::before {
                    left: 16px;
                    right: 16px;
                }
            }

            h2 {
                color: var(--bleu-marin);
                font-size: clamp(24px, 5vw, 30px);
                font-weight: 600;
                margin-bottom: clamp(32px, 5vw, 36px);
                letter-spacing: -0.02em;
                position: relative;
                display: inline-block;
                word-break: break-word;
                hyphens: auto;
                max-width: 100%;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 0;
                width: 50px;
                height: 2px;
                background: var(--jaune-abricot);
                border-radius: 2px;
                transition: width 0.25s ease;
            }

            h2:hover::after {
                width: 80px;
            }

            @media (max-width: 480px) {
                h2::after {
                    width: 40px;
                    height: 2px;
                }
                
                h2:hover::after {
                    width: 60px;
                }
            }

            .error, .success {
                padding: clamp(14px, 3vw, 16px) clamp(16px, 3vw, 20px);
                border-radius: clamp(12px, 3vw, 14px);
                margin-bottom: clamp(24px, 4vw, 28px);
                font-size: clamp(14px, 3vw, 15px);
                display: flex;
                align-items: center;
                gap: clamp(8px, 2vw, 12px);
                animation: slideIn 0.3s ease;
                width: 100%;
                word-break: break-word;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .error {
                background: #fff9f9;
                color: #b91c1c;
                border: 1px solid #fecaca;
            }

            .error::before {
                content: '⚠️';
                font-size: clamp(14px, 3vw, 16px);
                flex-shrink: 0;
            }

            .success {
                background: #f9fffc;
                color: #065f46;
                border: 1px solid #d1fae5;
            }

            .success::before {
                content: '✓';
                font-size: clamp(16px, 3.5vw, 18px);
                font-weight: 700;
                flex-shrink: 0;
            }

            label {
                display: block;
                color: var(--bleu-marin);
                font-weight: 550;
                font-size: clamp(13px, 3vw, 14px);
                margin-bottom: clamp(6px, 1.5vw, 8px);
                letter-spacing: 0.3px;
                word-break: break-word;
            }

            input[type="file"] {
                width: 100%;
                padding: clamp(12px, 3vw, 14px) clamp(14px, 3vw, 18px);
                border: 1.5px solid #edf2f7;
                border-radius: clamp(14px, 3vw, 16px);
                font-size: clamp(14px, 3vw, 15px);
                color: var(--gris-texte);
                background: var(--gris-doux);
                transition: all 0.2s ease;
                margin-bottom: clamp(24px, 4vw, 28px);
                cursor: pointer;
            }

            input[type="file"]:hover {
                border-color: var(--bleu-marin);
                background: white;
            }

            input[type="file"]:focus {
                outline: none;
                border-color: var(--bleu-marin);
                box-shadow: 0 0 0 3px rgba(30, 58, 95, 0.06);
                background: white;
            }

            select {
                width: 100%;
                padding: clamp(14px, 3vw, 16px) clamp(14px, 3vw, 18px);
                border: 1.5px solid #edf2f7;
                border-radius: clamp(14px, 3vw, 16px);
                font-size: clamp(14px, 3vw, 15px);
                color: var(--gris-texte);
                background: var(--gris-doux);
                transition: all 0.2s ease;
                margin-bottom: clamp(24px, 4vw, 28px);
                cursor: pointer;
                appearance: none;
                -webkit-appearance: none;
                padding-right: 48px;
                
                background-image: 
                    linear-gradient(45deg, transparent 50%, var(--bleu-marin) 50%),
                    linear-gradient(135deg, var(--bleu-marin) 50%, transparent 50%);
                background-position: 
                    calc(100% - 24px) center,
                    calc(100% - 19px) center;
                background-size: 6px 6px, 6px 6px;
                background-repeat: no-repeat;
            }

            @media (max-width: 480px) {
                select {
                    background-position: 
                        calc(100% - 16px) center,
                        calc(100% - 11px) center;
                    padding-right: 40px;
                }
            }

            select:hover {
                border-color: var(--bleu-marin);
                background-color: white;
            }

            select:focus {
                outline: none;
                border-color: var(--bleu-marin);
                box-shadow: 0 0 0 3px rgba(30, 58, 95, 0.06);
                background-color: white;
            }

            select option {
                padding: clamp(10px, 2vw, 12px);
                font-size: clamp(14px, 3vw, 15px);
            }

            input[type="submit"] {
                width: 100%;
                padding: clamp(14px, 3vw, 16px) clamp(24px, 5vw, 32px);
                background: var(--bleu-marin);
                color: white;
                border: none;
                border-radius: 40px;
                font-size: clamp(15px, 3vw, 16px);
                font-weight: 550;
                cursor: pointer;
                transition: all 0.25s ease;
                margin-top: 8px;
                letter-spacing: 0.5px;
                border: 1px solid transparent;
            }

            input[type="submit"]:hover {
                background: #0f2a44;
                transform: translateY(-2px);
                box-shadow: 0 10px 25px -8px rgba(30, 58, 95, 0.2);
            }

            input[type="submit"]:active {
                transform: translateY(0);
            }

            .download-btn {
                display: inline-block;
                width: 100%;
                padding: clamp(14px, 3vw, 16px) clamp(24px, 5vw, 32px);
                background: var(--jaune-abricot-doux);
                color: var(--bleu-marin);
                border-radius: 40px;
                font-weight: 600;
                text-decoration: none;
                font-size: clamp(15px, 3vw, 16px);
                transition: all 0.25s ease;
                margin-top: clamp(24px, 4vw, 28px);
                border: 1px solid rgba(251, 196, 171, 0.3);
                text-align: center;
                word-break: break-word;
            }

            .download-btn::before {
                content: '⬇️';
                margin-right: 8px;
                font-size: clamp(14px, 3vw, 15px);
                display: inline-block;
            }

            .download-btn:hover {
                background: var(--jaune-abricot);
                transform: translateY(-2px);
                border-color: transparent;
                box-shadow: 0 10px 25px -8px rgba(251, 196, 171, 0.4);
            }

            .links {
                margin-top: clamp(32px, 5vw, 36px);
                padding-top: clamp(24px, 4vw, 28px);
                border-top: 1px solid #edf2f7;
            }

            .links p {
                color: var(--gris-texte);
                font-size: clamp(14px, 3vw, 15px);
                margin: clamp(10px, 2vw, 12px) 0;
                word-break: break-word;
                line-height: 1.6;
            }

            .links a {
                color: var(--bleu-marin);
                text-decoration: none;
                font-weight: 600;
                padding: 4px 6px;
                position: relative;
                transition: color 0.2s;
                display: inline-block;
            }

            .links a::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 6px;
                right: 6px;
                height: 1.5px;
                background: var(--jaune-abricot);
                transform: scaleX(0);
                transition: transform 0.25s ease;
                border-radius: 2px;
            }

            .links a:hover {
                color: var(--bleu-marin);
            }

            .links a:hover::after {
                transform: scaleX(1);
            }

            @media (max-width: 360px) {
                body {
                    padding: 8px;
                }
                
                .convert-container {
                    padding: 24px 16px;
                    margin: 5px;
                }
                
                h2 {
                    font-size: 22px;
                }
                
                .links p {
                    font-size: 13px;
                }
                
                .download-btn::before {
                    margin-right: 4px;
                }
            }

            /* Gestion des très grands écrans */
            @media (min-width: 1200px) {
                .convert-container {
                    max-width: 600px;
                    padding: 56px 52px;
                }
                
                h2 {
                    font-size: 34px;
                }
                
                label {
                    font-size: 15px;
                }
                
                input[type="file"],
                select {
                    font-size: 16px;
                }
                
                input[type="submit"],
                .download-btn {
                    font-size: 17px;
                }
            }

            @media (max-height: 600px) and (orientation: landscape) {
                body {
                    align-items: flex-start;
                    padding: 20px;
                }
                
                .convert-container {
                    padding: 28px 30px;
                    margin: 15px auto;
                }
                
                h2 {
                    font-size: 24px;
                    margin-bottom: 24px;
                }
                
                input[type="file"],
                select {
                    margin-bottom: 20px;
                }
                
                .links {
                    margin-top: 28px;
                    padding-top: 20px;
                }
            }

            @media (hover: none) and (pointer: coarse) {
                input[type="submit"]:hover,
                .download-btn:hover,
                select:hover,
                input[type="file"]:hover {
                    transform: none;
                }
                
                .links a::after {
                    display: none;
                }
                
                .links a:active {
                    opacity: 0.7;
                }
                
                select {
                    background-color: white;
                }
            }

            ::selection {
                background: var(--jaune-abricot-doux);
                color: var(--bleu-marin);
            }

            img, video, iframe, table {
                max-width: 100%;
                height: auto;
            }

            @media (prefers-contrast: high) {
                .error {
                    border: 2px solid #b91c1c;
                }
                
                .success {
                    border: 2px solid #065f46;
                }
            }
        </style>
    </head>
    
    <body>
        <div class="convert-container">
            <h2>Conversion de fichiers</h2>

            <%-- Messages d'erreur et de succès --%>
            <%
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
                if (error != null) {
            %>
                <div class="error"><%= error %></div>
            <% } %>
            <% if (message != null) { %>
                <div class="success"><%= message %></div>
            <% } %>

            <%-- Formulaire de conversion --%>
            <form action="ConvertServlet" method="post" enctype="multipart/form-data">
                <label for="fichier">Sélectionnez un fichier :</label>
                <input type="file" name="fichier" id="fichier" required>

                <label for="typeConversion">En quel type souhaitez-vous convertir ce fichier ?</label>
                <select name="typeConversion" id="typeConversion" required>
                    <option value="">-- Choisissez --</option>
                    <option value="pdf">Word → PDF</option>
                    <option value="docx">PDF → Word</option>
                    <option value="xlsx">PDF → Excel</option>
                </select>

                <input type="submit" value="Convertir">
            </form>

            <%
                String fichierConverti = (String) session.getAttribute("fichierConverti");
                if (fichierConverti != null) {
            %>
                <a href="DownloadServlet?file=<%= fichierConverti %>" class="download-btn">
                    Télécharger le fichier
                </a>
            <%
                    session.removeAttribute("fichierConverti");
                }
            %>

            <div class="links">
                <p>Déjà inscrit ? <a href="login.jsp">Se connecter</a></p>
                <p>Pas encore de compte ? <a href="enregistrercompte.jsp">Créer un compte</a></p>
            </div>
            
            <div class ="links">
                
                <div class="links">
                    
                    <p>Espace réservé au cadre de l'application 
                    <a href="AdminRedirectServlet">Accéder</a>
                    </p>
                </div>
                
            </div>
            
        </div>
    </body>
</html>