# Utiliser Java 23 pour compiler
FROM eclipse-temurin:23-jdk

# Installer Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le code source (y compris les JAR dans web/WEB-INF/lib/)
COPY . .

# Builder le projet avec Ant
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    dist

# Utiliser Tomcat 10 (support jakarta.servlet)
FROM tomcat:10-jdk17

# Supprimer les applications par défaut
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier le WAR généré
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war

# Exposer le port
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]