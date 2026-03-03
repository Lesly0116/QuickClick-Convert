# Utiliser Java 23 pour compiler
FROM eclipse-temurin:23-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Télécharger Jakarta Servlet API (déjà fait)
RUN wget -O /tmp/jakarta.servlet-api.jar \
    https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

# Définir le répertoire de travail
WORKDIR /app

# Copier tout le code source
COPY . .

# Créer une variable avec tous les JARs du projet
RUN echo "Collecting all JARs from web/WEB-INF/lib..." && \
    JARS=$(find /app/web/WEB-INF/lib -name "*.jar" | tr '\n' ':') && \
    echo "JARs found: $JARS" && \
    echo "export CLASSPATH=$JARS:/tmp/jakarta.servlet-api.jar" >> /etc/profile

# Builder avec Ant en incluant tous les JARs
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    -Djavac.classpath="$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':'):/tmp/jakarta.servlet-api.jar" \
    dist

# Utiliser Tomcat 10 pour exécuter
FROM tomcat:10-jdk17

# Supprimer les applications par défaut
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier le WAR généré
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war

# Exposer le port
EXPOSE 8080

# Démarrer Tomcat
CMD ["catalina.sh", "run"]