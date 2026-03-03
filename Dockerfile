# Utiliser une image JDK officielle et fiable
FROM eclipse-temurin:17-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Télécharger la bibliothèque CopyLibs de NetBeans
RUN wget -O /tmp/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    https://repo1.maven.org/maven2/org/netbeans/modules/org-netbeans-modules-java-j2seproject-copylibstask/RELEASE180/org-netbeans-modules-java-j2seproject-copylibstask-RELEASE180.jar

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le code source dans le conteneur
COPY . .

# Builder le projet avec Ant en passant tous les paramètres nécessaires
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/tmp/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    dist

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