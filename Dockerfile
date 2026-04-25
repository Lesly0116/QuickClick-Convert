# Utiliser Java 21 pour compiler
FROM eclipse-temurin:21-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Définir JAVA_HOME explicitement (utile pour Ant)
ENV JAVA_HOME /usr/lib/jvm/java-21-openjdk-amd64

# Télécharger Jakarta Servlet API
RUN wget -O /tmp/jakarta.servlet-api.jar \
    https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

WORKDIR /app
COPY . .

# Builder avec tous les JARs nécessaires
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    -Djavac.classpath="$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':'):/tmp/jakarta.servlet-api.jar" \
    -Djavac.source=21 \
    -Djavac.target=21 \
    -Dplatforms.JDK_21.home=${JAVA_HOME} \
    dist

# Exécution avec Tomcat 10 + JDK 21
FROM tomcat:10-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]