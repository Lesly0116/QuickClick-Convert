# Utiliser une image avec JDK et Ant (pour builder avec NetBeans)
FROM openjdk:17-jdk-slim

# Installer Ant (outil de build utilisé par NetBeans)
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le code source dans le conteneur
COPY . .

# Builder le projet avec Ant (génère le WAR dans dist/)
RUN ant clean dist

# Utiliser Tomcat pour exécuter l'application
FROM tomcat:9-jdk17

# Supprimer les applications par défaut
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier le WAR généré depuis l'étape précédente
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war

# Exposer le port
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]