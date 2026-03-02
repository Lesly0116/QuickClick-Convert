<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Accès refusé</title>
    <style>
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            height: auto;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: clamp(15px, 4vw, 20px);
            overflow-x: hidden;
        }
        
        .container {
            text-align: center;
            background: white;
            padding: clamp(30px, 6vw, 50px) clamp(20px, 5vw, 50px);
            border-radius: clamp(15px, 4vw, 20px);
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 500px;
            width: 100%;
            margin: 10px;
            animation: fadeInUp 0.6s ease-out;
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
        
        .icon {
            font-size: clamp(60px, 15vw, 100px);
            margin-bottom: clamp(15px, 4vw, 20px);
            animation: shake 0.5s ease-in-out;
            line-height: 1;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        
        h1 {
            color: #dc3545;
            font-size: clamp(1.8em, 6vw, 2.5em);
            margin-bottom: clamp(15px, 4vw, 20px);
            word-break: break-word;
            hyphens: auto;
            line-height: 1.2;
        }
        
        .message {
            color: #666;
            font-size: clamp(1em, 3.5vw, 1.2em);
            margin-bottom: clamp(20px, 5vw, 30px);
            line-height: 1.6;
            word-break: break-word;
            padding: 0 5px;
        }
        
        .code {
            background: #f8f9fa;
            color: #333;
            font-size: clamp(0.9em, 3vw, 1.1em);
            padding: clamp(12px, 3vw, 15px);
            border-radius: 10px;
            margin-bottom: clamp(20px, 5vw, 30px);
            border-left: 4px solid #dc3545;
            text-align: left;
            font-family: monospace;
            word-break: break-word;
            overflow-wrap: break-word;
        }
        
        .alert {
            background: #fff3cd;
            color: #856404;
            padding: clamp(12px, 3vw, 15px);
            border-radius: 10px;
            margin-bottom: clamp(15px, 4vw, 20px);
            border-left: 4px solid #ffc107;
            font-size: clamp(0.9em, 3vw, 1em);
            word-break: break-word;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .alert::before {
            content: '⚠️';
            font-size: clamp(1.1em, 3.5vw, 1.2em);
        }
        
        .btn {
            display: inline-block;
            padding: clamp(12px, 3vw, 15px) clamp(20px, 5vw, 40px);
            margin: 8px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: clamp(0.9em, 3vw, 1.1em);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            white-space: nowrap;
            min-width: min(200px, 80%);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #ddd;
        }
        
        .btn-secondary:hover {
            background: #e9ecef;
            transform: translateY(-3px);
        }
        
        .footer {
            margin-top: clamp(20px, 5vw, 30px);
            color: #999;
            font-size: clamp(0.8em, 2.8vw, 0.9em);
            word-break: break-word;
            line-height: 1.5;
        }
        
        /* Breakpoints supplémentaires */
        @media (max-width: 640px) {
            body {
                padding: 15px;
            }
            
            .container {
                padding: 30px 25px;
            }
        }
        
        @media (max-width: 480px) {
            body {
                padding: 10px;
            }
            
            .container {
                padding: 25px 20px;
            }
            
            h1 {
                font-size: 1.8em;
            }
            
            .btn {
                display: block;
                width: 100%;
                max-width: 280px;
                margin: 10px auto;
                white-space: normal;
                word-break: break-word;
            }
            
            .icon {
                font-size: 70px;
            }
        }
        
        @media (max-width: 360px) {
            body {
                padding: 8px;
            }
            
            .container {
                padding: 20px 15px;
            }
            
            h1 {
                font-size: 1.6em;
            }
            
            .message {
                font-size: 0.95em;
            }
            
            .code {
                font-size: 0.85em;
                padding: 10px;
            }
            
            .alert {
                font-size: 0.85em;
                padding: 10px;
            }
            
            .btn {
                font-size: 0.9em;
                padding: 10px 15px;
            }
            
            .footer {
                font-size: 0.75em;
            }
        }
        
        /* Gestion des très grands écrans */
        @media (min-width: 1200px) {
            .container {
                max-width: 600px;
                padding: 60px;
            }
            
            h1 {
                font-size: 3em;
            }
            
            .message {
                font-size: 1.3em;
            }
            
            .btn {
                font-size: 1.2em;
                padding: 18px 50px;
            }
        }
        
        /* Gestion de l'orientation paysage sur mobile */
        @media (max-height: 600px) and (orientation: landscape) {
            body {
                align-items: flex-start;
                padding: 20px;
            }
            
            .container {
                padding: 25px 40px;
            }
            
            h1 {
                font-size: 2em;
                margin-bottom: 15px;
            }
            
            .icon {
                font-size: 60px;
                margin-bottom: 10px;
            }
            
            .message {
                margin-bottom: 15px;
            }
            
            .code {
                margin-bottom: 15px;
            }
            
            .footer {
                margin-top: 15px;
            }
        }
        
        /* Améliorations tactiles pour mobile */
        @media (hover: none) and (pointer: coarse) {
            .btn:hover {
                transform: none;
            }
            
            .btn:active {
                transform: scale(0.98);
            }
            
            .btn-primary:active {
                background: #764ba2;
            }
            
            .btn-secondary:active {
                background: #e9ecef;
            }
        }
        
        /* Style pour la sélection de texte */
        ::selection {
            background: #667eea;
            color: white;
        }
        
        /* Amélioration de la lisibilité */
        @media (prefers-contrast: high) {
            body {
                background: #764ba2;
            }
            
            .container {
                border: 3px solid #333;
            }
            
            .btn-primary {
                border: 2px solid white;
            }
            
            .btn-secondary {
                border: 2px solid #333;
            }
            
            .code {
                border: 2px solid #dc3545;
            }
            
            .alert {
                border: 2px solid #ffc107;
            }
        }
        
        /* Désactiver l'animation si l'utilisateur préfère moins de mouvement */
        @media (prefers-reduced-motion: reduce) {
            * {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
            
            .container {
                animation: none;
            }
            
            .icon {
                animation: none;
            }
            
            .btn:hover {
                transform: none;
            }
        }
        
        /* Prévention du débordement */
        img, video, iframe {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">🚫</div>
        
        <h1>Accès refusé</h1>
        
        <div class="message">
            Vous n'avez pas les droits nécessaires pour accéder à cette page.
        </div>
        
        <div class="alert">
            ⚠️ Cette section est réservée aux administrateurs du site.
        </div>
        
        <div class="code">
            <strong>Détail :</strong> Votre compte ne dispose pas des privilèges d'administration requis.
        </div>
        
        <div>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
                🔑 Se connecter avec un compte admin
            </a>
            
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">
                🏠 Retour à l'accueil
            </a>
        </div>
        
        <div class="footer">
            Si vous pensez qu'il s'agit d'une erreur, veuillez contacter l'administrateur.
        </div>
    </div>
</body>
</html>