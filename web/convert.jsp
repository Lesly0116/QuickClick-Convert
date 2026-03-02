<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Conversion de fichiers - QuickClick Convert</title>
    

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
            --shadow-sm: 0 4px 6px -2px rgba(30, 58, 95, 0.05);
            --shadow-md: 0 10px 15px -3px rgba(30, 58, 95, 0.1);
            --shadow-lg: 0 20px 25px -5px rgba(30, 58, 95, 0.15);
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: clamp(12px, 3vw, 20px);
            position: relative;
            overflow-x: hidden;
            width: 100%;
        }

        body::before {
            content: '';
            position: fixed;
            top: -20%;
            right: -10%;
            width: min(600px, 80vw);
            height: min(600px, 80vw);
            background: radial-gradient(circle, rgba(251, 196, 171, 0.08) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        body::after {
            content: '';
            position: fixed;
            bottom: -20%;
            left: -10%;
            width: min(600px, 80vw);
            height: min(600px, 80vw);
            background: radial-gradient(circle, rgba(30, 58, 95, 0.05) 0%, transparent 70%);
            border-radius: 50%;
            pointer-events: none;
        }

        .convert-container {
            max-width: 560px;
            width: 100%;
            background: var(--blanc);
            padding: clamp(32px, 6vw, 48px) clamp(20px, 5vw, 40px);
            border-radius: clamp(24px, 5vw, 32px);
            box-shadow: var(--shadow-lg);
            position: relative;
            z-index: 10;
            animation: fadeInUp 0.6s ease-out;
            margin: 10px;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .convert-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: clamp(6px, 1.5vw, 8px);
            background: linear-gradient(90deg, var(--bleu-marin), var(--jaune-abricot), var(--bleu-marin));
            border-radius: clamp(24px, 5vw, 32px) clamp(24px, 5vw, 32px) 0 0;
        }

        h2 {
            color: var(--bleu-marin);
            font-size: clamp(24px, 6vw, 32px);
            font-weight: 700;
            margin-bottom: clamp(24px, 5vw, 32px);
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
            bottom: clamp(-10px, -2vw, -8px);
            left: 0;
            width: clamp(60px, 12vw, 70px);
            height: clamp(3px, 0.8vw, 4px);
            background: var(--jaune-abricot);
            border-radius: 2px;
            transition: width 0.3s ease;
        }

        h2:hover::after {
            width: 100%;
        }

        .error, .success {
            padding: clamp(14px, 3vw, 16px) clamp(16px, 3.5vw, 20px);
            border-radius: clamp(12px, 3vw, 16px);
            margin-bottom: clamp(24px, 4vw, 28px);
            font-size: clamp(14px, 3vw, 15px);
            display: flex;
            align-items: center;
            gap: clamp(8px, 2vw, 12px);
            animation: slideIn 0.4s ease-out;
            width: 100%;
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

        .error {
            background: #fff8f8;
            color: #c53030;
            border-left: 4px solid #c53030;
            border-radius: 12px;
        }

        .error::before {
            content: '⚠️';
            font-size: clamp(16px, 3.5vw, 18px);
            flex-shrink: 0;
        }

        .success {
            background: #f4fef7;
            color: #276749;
            border-left: 4px solid #48bb78;
            border-radius: 12px;
        }

        .success::before {
            content: '✅';
            font-size: clamp(16px, 3.5vw, 18px);
            flex-shrink: 0;
        }

        label {
            display: block;
            color: var(--bleu-marin);
            font-weight: 600;
            font-size: clamp(12px, 3vw, 14px);
            margin-bottom: clamp(6px, 1.5vw, 8px);
            letter-spacing: 0.5px;
            text-transform: uppercase;
            word-break: break-word;
        }

        input[type="file"] {
            width: 100%;
            padding: clamp(12px, 3vw, 14px) clamp(16px, 3.5vw, 20px);
            border: 2px solid #edf2f7;
            border-radius: clamp(14px, 3.5vw, 18px);
            font-size: clamp(14px, 3vw, 15px);
            color: #1a202c;
            background: var(--gris-clair);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: clamp(24px, 4vw, 28px);
            cursor: pointer;
        }

        input[type="file"]:hover {
            border-color: var(--bleu-marin);
            background: white;
            box-shadow: var(--shadow-sm);
        }

        input[type="file"]:focus {
            outline: none;
            border-color: var(--bleu-marin);
            box-shadow: 0 0 0 4px rgba(30, 58, 95, 0.08);
            background: white;
        }

        select {
            width: 100%;
            padding: clamp(14px, 3vw, 16px) clamp(16px, 3.5vw, 20px);
            border: 2px solid #edf2f7;
            border-radius: clamp(14px, 3.5vw, 18px);
            font-size: clamp(14px, 3vw, 15px);
            color: #1a202c;
            background-color: var(--gris-clair);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: clamp(24px, 4vw, 28px);
            cursor: pointer;
            
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            
            padding-right: 48px;
            
            background-image: 
                linear-gradient(45deg, transparent 50%, var(--bleu-marin) 50%),
                linear-gradient(135deg, var(--bleu-marin) 50%, transparent 50%);
            background-position: 
                calc(100% - 25px) center,
                calc(100% - 20px) center;
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
            box-shadow: 0 0 0 4px rgba(30, 58, 95, 0.08);
            background-color: white;
        }

        select option[value=""] {
            color: #a0aec0;
        }

        select option {
            padding: clamp(8px, 2vw, 12px);
            font-size: clamp(14px, 3vw, 15px);
        }

        input[type="submit"] {
            width: 100%;
            padding: clamp(16px, 3.5vw, 18px) clamp(24px, 5vw, 32px);
            background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
            color: white;
            border: none;
            border-radius: 50px;
            font-size: clamp(15px, 3.5vw, 17px);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: clamp(12px, 2.5vw, 16px);
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        input[type="submit"]::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #15304d 0%, #0e2439 100%);
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        input[type="submit"]:hover::before {
            width: 400px;
            height: 400px;
        }

        input[type="submit"]:active {
            transform: translateY(-1px);
        }

        .actions {
            display: flex;
            gap: clamp(12px, 2.5vw, 16px);
            margin-top: clamp(24px, 4vw, 28px);
            flex-wrap: wrap;
        }

        .preview-btn, .download-btn {
            flex: 1 1 auto;
            min-width: min(200px, 100%);
            padding: clamp(14px, 3vw, 16px) clamp(20px, 4vw, 24px);
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: clamp(4px, 1.5vw, 8px);
            font-size: clamp(14px, 3.2vw, 16px);
            word-break: break-word;
        }

        .preview-btn {
            background: var(--blanc);
            color: var(--bleu-marin);
            border: 2px solid var(--bleu-marin);
        }

        .preview-btn:hover {
            background: var(--bleu-marin);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .download-btn {
            background: linear-gradient(135deg, var(--jaune-abricot) 0%, var(--jaune-abricot-fonce) 100%);
            color: var(--bleu-marin);
            border: 2px solid transparent;
        }

        .download-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px -8px rgba(251, 196, 171, 0.5);
        }

        .format-badge {
            display: inline-block;
            margin-top: clamp(10px, 2vw, 12px);
            padding: clamp(4px, 1.5vw, 6px) clamp(12px, 3vw, 16px);
            background: var(--bleu-ciel);
            color: var(--bleu-marin);
            border-radius: 30px;
            font-size: clamp(12px, 2.8vw, 13px);
            font-weight: 600;
            text-align: center;
            width: auto;
            max-width: 100%;
            word-break: break-word;
        }

        /* Liens */
        .links {
            margin-top: clamp(32px, 5vw, 36px);
            padding-top: clamp(24px, 4vw, 28px);
            border-top: 2px solid #f1f5f9;
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
            font-weight: 700;
            padding: 4px 8px;
            position: relative;
            transition: color 0.2s ease;
            display: inline-block;
        }

        .links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 8px;
            width: 0;
            height: 2px;
            background: linear-gradient(90deg, var(--jaune-abricot), var(--jaune-abricot-fonce));
            transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-radius: 2px;
        }

        .links a:hover::after {
            width: calc(100% - 16px);
        }

        @media (max-width: 640px) {
            .convert-container {
                padding: 40px 28px;
            }
            
            h2 {
                font-size: 28px;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .preview-btn, .download-btn {
                width: 100%;
            }
            
            input[type="submit"] {
                padding: 16px 28px;
                font-size: 16px;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 12px;
            }
            
            .convert-container {
                padding: 32px 20px;
            }
            
            h2 {
                font-size: 26px;
                margin-bottom: 28px;
            }
            
            h2::after {
                width: 60px;
                height: 3px;
                bottom: -8px;
            }
            
            label {
                font-size: 13px;
            }
            
            input[type="file"],
            select {
                padding: 14px 16px;
                font-size: 14px;
                margin-bottom: 24px;
            }
            
            .preview-btn, .download-btn {
                padding: 14px 20px;
                font-size: 15px;
            }
            
            .links p {
                font-size: 14px;
            }
        }

        @media (max-width: 360px) {
            .convert-container {
                padding: 28px 16px;
                margin: 5px;
            }
            
            h2 {
                font-size: 24px;
            }
            
            .preview-btn, .download-btn {
                padding: 12px 16px;
                font-size: 14px;
            }
            
            .format-badge {
                font-size: 11px;
                padding: 4px 10px;
            }
        }

        @media (min-width: 1200px) {
            .convert-container {
                max-width: 600px;
                padding: 56px 48px;
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
            
            .preview-btn, .download-btn {
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
                margin-bottom: 20px;
            }
            
            input[type="file"],
            select {
                margin-bottom: 20px;
            }
            
            .actions {
                margin-top: 20px;
            }
            
            .links {
                margin-top: 24px;
                padding-top: 20px;
            }
        }

        @media (hover: none) and (pointer: coarse) {
            input[type="submit"]:hover,
            .preview-btn:hover,
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
            
            input[type="submit"] {
                animation: none;
            }
            
            select {
                background-color: white;
            }
        }

        ::selection {
            background: var(--jaune-abricot);
            color: var(--bleu-marin);
        }

        img, video, iframe, table {
            max-width: 100%;
            height: auto;
        }

        @media (prefers-contrast: high) {
            .error {
                border: 2px solid #c53030;
            }
            
            .success {
                border: 2px solid #48bb78;
            }
            
            .preview-btn {
                border: 3px solid var(--bleu-marin);
            }
        }

        input[type="submit"] {
            animation: pulse 3s infinite;
        }

        input[type="submit"]:hover {
            animation: none;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(30, 58, 95, 0.2);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(30, 58, 95, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(30, 58, 95, 0);
            }
        }

        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
            
            input[type="submit"] {
                animation: none;
            }
        }
    </style>
</head>

<body>
<div class="convert-container">
    <h2>Conversion de fichiers</h2>

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
        
        String extension = "";
        if (fichierConverti.contains(".")) {
            extension = fichierConverti.substring(fichierConverti.lastIndexOf(".") + 1).toUpperCase();
        }
%>
    <div class="actions">
        
        <a href="apercu.jsp?file=<%= fichierConverti %>" 
           class="preview-btn" 
           target="_blank">
            <span>👁️</span> Aperçu <%= extension %>
        </a>
        
        <a href="DownloadServlet?file=<%= fichierConverti %>&action=download" 
           class="download-btn">
            <span>⬇️</span> Télécharger
        </a>
    </div>
    
    <div class="format-badge">
        Format : <strong><%= extension %></strong>
    </div>
<%

        // session.removeAttribute("fichierConverti");
    }
%>

    <div class="links">
        <p><a href="DocumentsUtilisateur"> Voir mes documents convertis</a></p>
        <p><a href="logout.jsp">Se déconnecter</a></p>
    </div>
</div>
</body>
</html>