<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=5.0, user-scalable=yes">
    <title>Déconnexion - QuickClick Convert</title>
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

      .logout-container {
        max-width: 460px;
        width: 100%;
        background: var(--blanc);
        padding: clamp(32px, 6vw, 48px) clamp(20px, 5vw, 40px);
        border-radius: clamp(24px, 5vw, 32px);
        box-shadow: 0 25px 50px -12px rgba(30, 58, 95, 0.2);
        position: relative;
        overflow: hidden;
        text-align: center;
        margin: 10px;
      }

      .logout-container::before {
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
        word-break: break-word;
        hyphens: auto;
        letter-spacing: -0.5px;
      }

      p {
        color: #4a5568;
        font-size: clamp(14px, 3.5vw, 15px);
        margin-bottom: clamp(20px, 4vw, 24px);
        word-break: break-word;
        line-height: 1.6;
        padding: 0 clamp(5px, 2vw, 10px);
      }

      a {
        display: inline-block;
        padding: clamp(12px, 3vw, 14px) clamp(20px, 5vw, 28px);
        background: var(--bleu-marin);
        color: white;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        font-size: clamp(14px, 3.5vw, 15px);
        white-space: nowrap;
        min-width: min(200px, 80%);
        letter-spacing: 0.5px;
      }

      a:hover {
        background: #15304d;
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(30, 58, 95, 0.2);
      }

      a:active {
        transform: translateY(-1px);
        box-shadow: 0 5px 10px rgba(30, 58, 95, 0.15);
      }

      /* Breakpoints supplémentaires */
      @media (max-width: 480px) {
        body {
          padding: 10px;
        }
        
        .logout-container {
          padding: 28px 20px;
          border-radius: 24px;
        }
        
        h2 {
          font-size: 26px;
          margin-bottom: 24px;
        }
        
        p {
          font-size: 14px;
          margin-bottom: 20px;
        }
        
        a {
          padding: 12px 24px;
          font-size: 14px;
          min-width: 180px;
        }
      }

      @media (max-width: 360px) {
        body {
          padding: 8px;
        }
        
        .logout-container {
          padding: 24px 16px;
          border-radius: 20px;
          margin: 5px;
        }
        
        h2 {
          font-size: 24px;
          margin-bottom: 20px;
        }
        
        p {
          font-size: 13px;
          margin-bottom: 18px;
        }
        
        a {
          padding: 10px 20px;
          font-size: 13px;
          min-width: 160px;
          width: 100%;
          max-width: 250px;
          white-space: normal;
          word-break: break-word;
        }
      }

      /* Gestion des très grands écrans */
      @media (min-width: 1200px) {
        .logout-container {
          max-width: 500px;
          padding: 56px 48px;
        }
        
        h2 {
          font-size: 34px;
        }
        
        p {
          font-size: 16px;
          margin-bottom: 28px;
        }
        
        a {
          font-size: 16px;
          padding: 16px 32px;
        }
      }

      /* Gestion de l'orientation paysage sur mobile */
      @media (max-height: 500px) and (orientation: landscape) {
        body {
          align-items: flex-start;
          padding: 15px;
        }
        
        .logout-container {
          padding: 24px 30px;
          margin: 10px auto;
        }
        
        h2 {
          font-size: 24px;
          margin-bottom: 16px;
        }
        
        p {
          margin-bottom: 16px;
        }
        
        a {
          padding: 10px 24px;
        }
      }

      /* Améliorations tactiles pour mobile */
      @media (hover: none) and (pointer: coarse) {
        a:hover {
          transform: none;
        }
        
        a:active {
          transform: scale(0.98);
          background: #15304d;
        }
      }

      /* Style pour la sélection de texte */
      ::selection {
        background: var(--jaune-abricot);
        color: var(--bleu-marin);
      }

      /* Animation d'apparition */
      .logout-container {
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

      /* Amélioration de la lisibilité */
      @media (prefers-contrast: high) {
        .logout-container {
          border: 2px solid var(--bleu-marin);
        }
        
        a {
          border: 2px solid white;
        }
      }

      /* Désactiver l'animation si l'utilisateur préfère moins de mouvement */
      @media (prefers-reduced-motion: reduce) {
        * {
          animation-duration: 0.01ms !important;
          animation-iteration-count: 1 !important;
          transition-duration: 0.01ms !important;
        }
        
        .logout-container {
          animation: none;
        }
        
        a:hover {
          transform: none;
        }
      }

      /* Prévention du débordement */
      img, video, iframe, table {
        max-width: 100%;
        height: auto;
      }
    </style>
</head>
<body>
    <div class="logout-container">
        <h2>Déconnexion réussie</h2>
        <p>Vous avez été déconnecté avec succès.</p>
        <a href="login.jsp">Se reconnecter</a>
    </div>
</body>
</html>