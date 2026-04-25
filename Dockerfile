# Utiliser Java 21 pour compiler
FROM eclipse-temurin:21-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Télécharger Jakarta Servlet API
RUN wget -O /tmp/jakarta.servlet-api.jar \
    https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

WORKDIR /app
COPY . .

# Copier l'API Servlet dans le dossier des librairies (pour qu'elle soit dans le classpath)
RUN mkdir -p web/WEB-INF/lib && cp /tmp/jakarta.servlet-api.jar web/WEB-INF/lib/

# Builder avec Ant en utilisant le build file personnalisé
RUN ant -f build-custom.xml dist

# Exécution avec Tomcat 10 + JDK 21
FROM tomcat:10-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]