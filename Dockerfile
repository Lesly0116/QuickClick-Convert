# Utiliser une image JDK officielle et fiable
FROM eclipse-temurin:17-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Télécharger les bibliothèques Java EE
RUN wget -O /tmp/javax.servlet-api.jar https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le code source dans le conteneur
COPY . .

# Rendre les bibliothèques NetBeans et Java EE disponibles
ENV CLASSPATH=/app/nbproject/org-netbeans-modules-java-j2seproject-copylibstats.jar:/tmp/javax.servlet-api.jar:$CLASSPATH

# Builder le projet avec Ant
RUN ant -f build.xml -Dj2ee.server.home=/usr/local/tomcat dist

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