# Utiliser Java 21 pour compiler
FROM eclipse-temurin:21-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Définir JAVA_HOME explicitement
ENV JAVA_HOME /usr/lib/jvm/java-21-openjdk-amd64

# Télécharger Jakarta Servlet API
RUN wget -O /tmp/jakarta.servlet-api.jar \
    https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

WORKDIR /app
COPY . .

# ========== DIAGNOSTICS ==========
# 1. Vérifier que javac fonctionne
RUN $JAVA_HOME/bin/javac -version

# 2. Compiler un fichier test trivial
RUN mkdir -p /app/test-compile && \
    echo 'public class Test { public static void main(String[] args) { System.out.println("ok"); } }' > /app/test-compile/Test.java && \
    $JAVA_HOME/bin/javac -d /app/test-compile /app/test-compile/Test.java && \
    java -cp /app/test-compile Test && \
    rm -rf /app/test-compile

# 3. Compiler un seul fichier de votre projet (le premier trouvé)
RUN cd /app && \
    FIRST_JAVA=$(find src -name "*.java" | head -1) && \
    if [ -n "$FIRST_JAVA" ]; then \
        echo "Compilation test de : $FIRST_JAVA" && \
        $JAVA_HOME/bin/javac -cp "$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')/tmp/jakarta.servlet-api.jar" \
            -d /tmp "$FIRST_JAVA"; \
    else \
        echo "Aucun fichier source trouvé dans src/"; \
    fi

# 4. Compiler TOUS les fichiers sources pour voir les erreurs détaillées
RUN cd /app && \
    mkdir -p /tmp/build && \
    find src -name "*.java" > /tmp/sources.txt && \
    if [ -s /tmp/sources.txt ]; then \
        echo "Compilation complète de $(wc -l < /tmp/sources.txt) fichiers..." && \
        $JAVA_HOME/bin/javac -cp "$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')/tmp/jakarta.servlet-api.jar" \
            -d /tmp/build -sourcepath src @/tmp/sources.txt 2>&1 || true; \
    else \
        echo "Aucune source Java trouvée"; \
    fi
# ========== FIN DIAGNOSTICS ==========

# Builder avec Ant
# Si vous utilisez build-custom.xml, remplacez build.xml par build-custom.xml
RUN ant -f build-custom.xml \
    -Dj2ee.server.home=/usr/local/tomcat \
    -Dlibs.CopyLibs.classpath=/app/lib/org-netbeans-modules-java-j2seproject-copylibstask.jar \
    -Djavac.classpath="$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':'):/tmp/jakarta.servlet-api.jar" \
    -Djavac.source=21 \
    -Djavac.target=21 \
    -Dplatforms.JDK_21.home=${JAVA_HOME} \
    dist

# Étape d'exécution avec Tomcat
FROM tomcat:10-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]