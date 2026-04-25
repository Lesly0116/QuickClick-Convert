# Utiliser Java 21 pour compiler
FROM eclipse-temurin:21-jdk

# Installer Ant et wget
RUN apt-get update && apt-get install -y ant wget && rm -rf /var/lib/apt/lists/*

# Télécharger Jakarta Servlet API
RUN wget -O /tmp/jakarta.servlet-api.jar \
    https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar

WORKDIR /app
COPY . .

# ========== DIAGNOSTICS ==========
# 1. Vérifier que javac fonctionne
RUN javac -version

# 2. Compiler un fichier test trivial
RUN mkdir -p /app/test-compile && \
    echo 'public class Test { public static void main(String[] args) { System.out.println("ok"); } }' > /app/test-compile/Test.java && \
    javac -d /app/test-compile /app/test-compile/Test.java && \
    java -cp /app/test-compile Test && \
    rm -rf /app/test-compile

# 3. Compiler un seul fichier (hors tests)
RUN cd /app && \
    FIRST_JAVA=$(find src -path "*/test/*" -prune -o -name "*.java" -print | head -1) && \
    if [ -n "$FIRST_JAVA" ]; then \
        echo "Compilation test de : $FIRST_JAVA" && \
        javac -cp "$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')/tmp/jakarta.servlet-api.jar" \
            -d /tmp "$FIRST_JAVA"; \
    else \
        echo "Aucun fichier source trouvé dans src/ (hors tests)"; \
    fi

# 4. Compiler TOUS les fichiers (hors tests)
RUN cd /app && \
    mkdir -p /tmp/build && \
    find src -path "*/test/*" -prune -o -name "*.java" -print > /tmp/sources.txt && \
    if [ -s /tmp/sources.txt ]; then \
        echo "Compilation complète de $(wc -l < /tmp/sources.txt) fichiers..." && \
        javac -cp "$(find /app/web/WEB-INF/lib -name '*.jar' | tr '\n' ':')/tmp/jakarta.servlet-api.jar" \
            -d /tmp/build -sourcepath src @/tmp/sources.txt 2>&1 || true; \
    else \
        echo "Aucune source Java trouvée (hors tests)"; \
    fi
# ========== FIN DIAGNOSTICS ==========

# Builder avec Ant (utilise build-custom.xml)
RUN ant -f build-custom.xml dist

# Exécution avec Tomcat 10 + JDK 21
FROM tomcat:10-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=0 /app/dist/ConvertirFichier.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]