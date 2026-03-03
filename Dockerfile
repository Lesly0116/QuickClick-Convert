# Utiliser Java 21 pour compiler
FROM eclipse-temurin:21-jdk

# Installer Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Builder avec des paramètres explicites
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    -Djavac.classpath="$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')" \
    -Djavac.source=21 \
    -Djavac.target=21 \
    dist

# Exécution avec Tomcat 10 + JDK 21
FROM tomcat:10-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]