<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Connexion - QuickClick Convert</title>

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
    background: linear-gradient(145deg, var(--bleu-ciel) 0%, #f0f7fa 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: clamp(12px, 3vw, 20px);
    overflow-x: hidden;
    width: 100%;
}

.login-container {
    max-width: 460px;
    width: 100%;
    background: var(--blanc);
    padding: clamp(32px, 6vw, 48px) clamp(20px, 5vw, 40px);
    border-radius: clamp(24px, 5vw, 32px);
    box-shadow: 0 25px 50px -12px rgba(30, 58, 95, 0.2);
    position: relative;
    overflow: hidden;
    margin: 10px;
}

.login-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: clamp(4px, 1vw, 6px);
    background: linear-gradient(90deg, var(--bleu-marin), var(--jaune-abricot));
}

h2 {
    color: var(--bleu-marin);
    font-size: clamp(24px, 6vw, 32px);
    font-weight: 700;
    margin-bottom: clamp(24px, 5vw, 32px);
    text-align: center;
    word-break: break-word;
    hyphens: auto;
    letter-spacing: -0.5px;
}

.error {
    background: #fff5f5;
    color: #c53030;
    padding: clamp(14px, 3vw, 16px) clamp(16px, 3.5vw, 20px);
    border-radius: clamp(12px, 3vw, 16px);
    margin-bottom: clamp(20px, 4vw, 24px);
    border-left: 4px solid #c53030;
    font-size: clamp(14px, 3vw, 15px);
    word-break: break-word;
    animation: slideIn 0.4s ease-out;
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

label {
    display: block;
    color: var(--bleu-marin);
    font-weight: 600;
    font-size: clamp(13px, 3vw, 15px);
    margin-bottom: clamp(6px, 1.5vw, 8px);
    word-break: break-word;
}

input[type="text"],
input[type="password"] {
    width: 100%;
    padding: clamp(12px, 3vw, 14px) clamp(14px, 3.5vw, 18px);
    border: 2px solid #e2e8f0;
    border-radius: clamp(14px, 3.5vw, 16px);
    font-size: clamp(14px, 3vw, 15px);
    transition: all 0.2s ease;
    margin-bottom: clamp(20px, 4vw, 24px);
    background: var(--gris-clair);
}

input[type="text"]:hover,
input[type="password"]:hover {
    border-color: var(--bleu-marin);
    background: white;
}

input[type="text"]:focus,
input[type="password"]:focus {
    outline: none;
    border-color: var(--bleu-marin);
    box-shadow: 0 0 0 3px rgba(30, 58, 95, 0.1);
    background: white;
}

input[type="text"]::placeholder,
input[type="password"]::placeholder {
    color: #a0aec0;
    font-weight: 400;
    font-size: clamp(13px, 2.8vw, 14px);
}

input[type="submit"] {
    width: 100%;
    padding: clamp(14px, 3vw, 16px) clamp(24px, 5vw, 32px);
    background: var(--bleu-marin);
    color: white;
    border: none;
    border-radius: 50px;
    font-size: clamp(15px, 3.2vw, 16px);
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    margin-top: clamp(4px, 1.5vw, 8px);
    letter-spacing: 0.5px;
}

input[type="submit"]:hover {
    background: #15304d;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(30, 58, 95, 0.2);
}

input[type="submit"]:active {
    transform: translateY(-1px);
    box-shadow: 0 5px 10px rgba(30, 58, 95, 0.15);
}

.links {
    margin-top: clamp(28px, 5vw, 32px);
    text-align: center;
    padding-top: clamp(20px, 4vw, 24px);
    border-top: 1px solid #e2e8f0;
}

.links p {
    color: #4a5568;
    font-size: clamp(14px, 3vw, 15px);
    word-break: break-word;
    line-height: 1.6;
}

.links a {
    color: var(--bleu-marin);
    text-decoration: none;
    font-weight: 600;
    position: relative;
    padding: 2px 4px;
    display: inline-block;
}

.links a::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--jaune-abricot);
    transition: width 0.2s ease;
    border-radius: 2px;
}

.links a:hover::after {
    width: 100%;
}

/* Breakpoints supplémentaires */
@media (max-width: 480px) {
    body {
        padding: 10px;
    }
    
    .login-container {
        padding: 28px 20px;
        border-radius: 24px;
    }
    
    h2 {
        font-size: 26px;
        margin-bottom: 24px;
    }
    
    label {
        font-size: 14px;
    }
    
    input[type="text"],
    input[type="password"] {
        padding: 12px 14px;
        font-size: 14px;
        margin-bottom: 20px;
    }
    
    input[type="submit"] {
        padding: 14px 24px;
        font-size: 15px;
    }
    
    .links p {
        font-size: 14px;
    }
}

@media (max-width: 360px) {
    body {
        padding: 8px;
    }
    
    .login-container {
        padding: 24px 16px;
        border-radius: 20px;
        margin: 5px;
    }
    
    h2 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    
    label {
        font-size: 13px;
        margin-bottom: 4px;
    }
    
    input[type="text"],
    input[type="password"] {
        padding: 10px 12px;
        font-size: 13px;
        margin-bottom: 16px;
        border-radius: 12px;
    }
    
    input[type="submit"] {
        padding: 12px 20px;
        font-size: 14px;
        margin-top: 4px;
    }
    
    .links {
        margin-top: 24px;
        padding-top: 18px;
    }
    
    .links p {
        font-size: 13px;
    }
}

/* Gestion des très grands écrans */
@media (min-width: 1200px) {
    .login-container {
        max-width: 500px;
        padding: 56px 48px;
    }
    
    h2 {
        font-size: 34px;
    }
    
    label {
        font-size: 16px;
    }
    
    input[type="text"],
    input[type="password"] {
        font-size: 16px;
        padding: 16px 20px;
    }
    
    input[type="submit"] {
        font-size: 17px;
        padding: 18px 32px;
    }
    
    .links p {
        font-size: 16px;
    }
}

/* Gestion de l'orientation paysage sur mobile */
@media (max-height: 600px) and (orientation: landscape) {
    body {
        align-items: flex-start;
        padding: 20px;
    }
    
    .login-container {
        padding: 28px 30px;
        margin: 10px auto;
    }
    
    h2 {
        font-size: 24px;
        margin-bottom: 16px;
    }
    
    input[type="text"],
    input[type="password"] {
        margin-bottom: 16px;
        padding: 10px 14px;
    }
    
    .links {
        margin-top: 20px;
        padding-top: 16px;
    }
}

/* Améliorations tactiles pour mobile */
@media (hover: none) and (pointer: coarse) {
    input[type="submit"]:hover,
    input[type="text"]:hover,
    input[type="password"]:hover {
        transform: none;
    }
    
    .links a::after {
        display: none;
    }
    
    .links a:active {
        opacity: 0.7;
    }
    
    input[type="submit"]:active {
        transform: scale(0.98);
    }
}

/* Style pour la sélection de texte */
::selection {
    background: var(--jaune-abricot);
    color: var(--bleu-marin);
}

/* Amélioration de la lisibilité */
@media (prefers-contrast: high) {
    .error {
        border: 2px solid #c53030;
        background: #ffffff;
    }
    
    input[type="text"],
    input[type="password"] {
        border: 2px solid var(--bleu-marin);
    }
    
    input[type="submit"] {
        border: 2px solid white;
    }
    
    .login-container {
        border: 2px solid var(--bleu-marin);
    }
}

/* Prévention du débordement */
img, video, iframe, table {
    max-width: 100%;
    height: auto;
}

/* Désactiver l'animation si l'utilisateur préfère moins de mouvement */
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
    
    .error {
        animation: none;
    }
    
    input[type="submit"]:hover {
        transform: none;
    }
}
    </style>
</head>

<body>
    <div class="login-container">
        <h2>Connexion</h2>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }
        %>

    <form action="LoginServlet" method="post">
    <label>Email</label>
    <input type="text" name="email" required>

    <label>Mot de passe</label>
    <input type="password" name="password" required>

    <!-- Ce champ caché est CRUCIAL -->
    <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>">

    <input type="submit" value="Se connecter">
</form>

        <div class="links">
            <p>
                Pas encore de compte ?
                <a href="enregistrercompte.jsp">Créer un compte</a>
            </p>
        </div>
    </div>
</body>
</html>