<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <title>Créer un compte - QuickClick Convert</title>

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
    top: -100px;
    right: -100px;
    width: min(400px, 80vw);
    height: min(400px, 80vw);
    background: radial-gradient(circle, rgba(251, 196, 171, 0.08) 0%, transparent 70%);
    border-radius: 50%;
    pointer-events: none;
}

body::after {
    content: '';
    position: fixed;
    bottom: -100px;
    left: -100px;
    width: min(400px, 80vw);
    height: min(400px, 80vw);
    background: radial-gradient(circle, rgba(30, 58, 95, 0.05) 0%, transparent 70%);
    border-radius: 50%;
    pointer-events: none;
}

.register-container {
    max-width: 480px;
    width: 100%;
    background: var(--blanc);
    padding: clamp(32px, 6vw, 48px) clamp(20px, 5vw, 40px);
    border-radius: clamp(24px, 5vw, 32px);
    box-shadow: 0 30px 60px -15px rgba(30, 58, 95, 0.2);
    position: relative;
    overflow: hidden;
    animation: fadeInUp 0.6s ease-out;
    border: 1px solid rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    z-index: 10;
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

.register-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: clamp(4px, 1vw, 6px);
    background: linear-gradient(90deg, var(--bleu-marin), var(--jaune-abricot), var(--bleu-marin));
}

.register-container::after {
    content: '';
    position: absolute;
    bottom: -50px;
    right: -50px;
    width: min(200px, 40vw);
    height: min(200px, 40vw);
    background: radial-gradient(circle, rgba(251, 196, 171, 0.05) 0%, transparent 70%);
    border-radius: 50%;
    pointer-events: none;
}

h2 {
    color: var(--bleu-marin);
    font-size: clamp(24px, 6vw, 32px);
    font-weight: 700;
    margin-bottom: clamp(24px, 5vw, 32px);
    text-align: center;
    letter-spacing: -0.5px;
    position: relative;
    display: inline-block;
    width: 100%;
    word-break: break-word;
    hyphens: auto;
}

h2::after {
    content: '';
    position: absolute;
    bottom: clamp(-12px, -2.5vw, -10px);
    left: 50%;
    transform: translateX(-50%);
    width: clamp(50px, 12vw, 60px);
    height: clamp(3px, 0.8vw, 4px);
    background: var(--jaune-abricot);
    border-radius: 2px;
}

.error, .success {
    padding: clamp(14px, 3vw, 16px) clamp(16px, 3.5vw, 20px);
    border-radius: clamp(12px, 3vw, 16px);
    margin-bottom: clamp(24px, 4vw, 28px);
    font-size: clamp(14px, 3vw, 15px);
    text-align: left;
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
    color: var(--rouge-erreur);
    border-left: 4px solid var(--rouge-erreur);
    border-radius: 12px;
}

.success {
    background: #f4fef7;
    color: var(--vert-succes);
    border-left: 4px solid #48bb78;
    border-radius: 12px;
}

label {
    display: block;
    color: var(--bleu-marin);
    font-weight: 600;
    font-size: clamp(12px, 3vw, 14px);
    margin-bottom: clamp(6px, 1.5vw, 8px);
    letter-spacing: 0.3px;
    word-break: break-word;
}

input[type="text"],
input[type="password"],
input[type="email"] {
    width: 100%;
    padding: clamp(12px, 3vw, 16px) clamp(14px, 3.5vw, 18px);
    border: 2px solid #edf2f7;
    border-radius: clamp(14px, 3.5vw, 18px);
    font-size: clamp(14px, 3vw, 15px);
    transition: all 0.3s ease;
    margin-bottom: clamp(20px, 4vw, 24px);
    background: var(--gris-clair);
    color: var(--gris-texte);
    font-family: 'Inter', sans-serif;
}

input[type="text"]:hover,
input[type="password"]:hover,
input[type="email"]:hover {
    border-color: var(--bleu-marin);
    background: white;
}

input[type="text"]:focus,
input[type="password"]:focus,
input[type="email"]:focus {
    outline: none;
    border-color: var(--bleu-marin);
    box-shadow: 0 0 0 4px rgba(30, 58, 95, 0.08);
    background: white;
}

input[type="text"]::placeholder,
input[type="password"]::placeholder,
input[type="email"]::placeholder {
    color: #a0aec0;
    font-weight: 400;
    font-size: clamp(13px, 2.8vw, 14px);
}

input[type="submit"] {
    width: 100%;
    padding: clamp(14px, 3vw, 16px) clamp(24px, 5vw, 32px);
    background: linear-gradient(135deg, var(--bleu-marin) 0%, #15304d 100%);
    color: white;
    border: none;
    border-radius: 50px;
    font-size: clamp(15px, 3.2vw, 16px);
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
    box-shadow: 0 15px 30px -8px rgba(30, 58, 95, 0.3);
}

input[type="submit"]:hover::before {
    width: 300px;
    height: 300px;
}

input[type="submit"]:active {
    transform: translateY(-1px);
    box-shadow: 0 8px 15px rgba(30, 58, 95, 0.2);
}

.links {
    margin-top: clamp(28px, 5vw, 32px);
    text-align: center;
    padding-top: clamp(24px, 4vw, 28px);
    border-top: 2px solid #f1f5f9;
}

.links p {
    color: var(--gris-texte);
    font-size: clamp(14px, 3vw, 15px);
    font-weight: 500;
    word-break: break-word;
    line-height: 1.6;
}

.links a {
    color: var(--bleu-marin);
    text-decoration: none;
    font-weight: 700;
    position: relative;
    padding: 4px 8px;
    transition: color 0.2s ease;
    display: inline-block;
}

.links a::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 0;
    height: 2px;
    background: linear-gradient(90deg, var(--jaune-abricot), var(--jaune-abricot-fonce));
    transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border-radius: 2px;
}

.links a:hover {
    color: var(--bleu-marin);
}

.links a:hover::after {
    width: 100%;
}

@media (max-width: 640px) {
    body {
        padding: 16px;
    }

    .register-container {
        padding: 40px 24px;
    }

    h2 {
        font-size: 28px;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"] {
        padding: 14px 16px;
        border-radius: 16px;
    }

    input[type="submit"] {
        padding: 14px 28px;
    }
}

@media (max-width: 480px) {
    body {
        padding: 12px;
    }
    
    .register-container {
        padding: 32px 20px;
    }

    h2 {
        font-size: 26px;
        margin-bottom: 28px;
    }

    h2::after {
        width: 50px;
        height: 3px;
        bottom: -10px;
    }

    .error, .success {
        padding: 14px 16px;
        font-size: 14px;
    }

    label {
        font-size: 13px;
    }

    input[type="text"],
    input[type="password"],
    input[type="email"] {
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

::selection {
    background: var(--jaune-abricot);
    color: var(--bleu-marin);
}

@media (max-width: 360px) {
    body {
        padding: 8px;
    }
    
    .register-container {
        padding: 24px 16px;
        margin: 5px;
    }

    h2 {
        font-size: 24px;
        margin-bottom: 24px;
    }
    
    h2::after {
        width: 40px;
        height: 3px;
        bottom: -8px;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="email"] {
        padding: 10px 12px;
        font-size: 13px;
        margin-bottom: 16px;
    }
    
    label {
        font-size: 12px;
        margin-bottom: 4px;
    }
    
    input[type="submit"] {
        padding: 12px 20px;
        font-size: 14px;
        margin-top: 8px;
    }
    
    .links {
        margin-top: 24px;
        padding-top: 20px;
    }
    
    .links p {
        font-size: 13px;
    }
}

@media (min-width: 1200px) {
    .register-container {
        max-width: 520px;
        padding: 56px 48px;
    }
    
    h2 {
        font-size: 34px;
    }
    
    label {
        font-size: 15px;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="email"] {
        font-size: 16px;
        padding: 18px 20px;
    }
    
    input[type="submit"] {
        font-size: 17px;
    }
}

@media (max-height: 600px) and (orientation: landscape) {
    body {
        align-items: flex-start;
        padding: 20px;
    }
    
    .register-container {
        padding: 28px 30px;
        margin: 15px auto;
    }
    
    h2 {
        font-size: 24px;
        margin-bottom: 20px;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="email"] {
        margin-bottom: 16px;
        padding: 10px 14px;
    }
    
    .links {
        margin-top: 20px;
        padding-top: 16px;
    }
}

@media (hover: none) and (pointer: coarse) {
    input[type="submit"]:hover,
    input[type="text"]:hover,
    input[type="password"]:hover,
    input[type="email"]:hover {
        transform: none;
    }
    
    .links a::after {
        display: none;
    }
    
    .links a:active {
        opacity: 0.7;
    }
}

img, video, iframe, table {
    max-width: 100%;
    height: auto;
}

@media (prefers-contrast: high) {
    .error {
        border: 2px solid var(--rouge-erreur);
    }
    
    .success {
        border: 2px solid #48bb78;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="email"] {
        border: 2px solid var(--bleu-marin);
    }
}

@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}
</style>

</head>

<body>
    <div class="register-container">
        <h2>Créer un compte</h2>

       
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

        <form action="EnregistrerCompteServlet" method="post">
            <label>Email</label>
            <input type="text" name="email" placeholder="petitcon@email.com" required>

            <label>Mot de passe</label>
            <input type="password" name="password" placeholder="Votre mot de passe" required>

            <input type="submit" value="S'inscrire">
        </form>

        <div class="links">
            <p>
                Déjà inscrit ? <a href="login.jsp">Se connecter</a>
            </p>
        </div>
    </div>
</body>
</html>