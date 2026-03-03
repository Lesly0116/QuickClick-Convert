# Étape 1 : Builder avec JDK 23
FROM eclipse-temurin:23-jdk AS builder

# Installer Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Builder
RUN ant -f build.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    -Djavac.classpath="$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')" \
    dist

# Étape 2 : Utiliser Tomcat avec JDK 23
FROM tomcat:10-jdk17

# Remplacer JDK 17 par JDK 23 depuis l'étape builder
COPY --from=builder /opt/java/openjdk /opt/java/openjdk
ENV JAVA_HOME=/opt/java/openjdk

# Supprimer les applications par défaut
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier le WAR
COPY --from=builder /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]