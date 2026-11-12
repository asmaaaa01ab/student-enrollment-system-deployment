# syntax=docker/dockerfile:1

# ---------- Étape 1 : build (Maven + JDK 17) ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace

# Cache des dépendances : on copie d'abord uniquement le pom.xml
COPY pom.xml .
RUN --mount=type=cache,target=/root/.m2 mvn -B -q dependency:go-offline

# Compilation de l'application
COPY src ./src
RUN --mount=type=cache,target=/root/.m2 mvn -B -q clean package -DskipTests

# ---------- Étape 2 : runtime (JRE 17 léger) ----------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Utilisateur non-root (bonne pratique de sécurité)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

COPY --from=build --chown=spring:spring /workspace/target/*.jar app.jar

EXPOSE 8081

# Adaptation de la JVM aux limites mémoire du conteneur
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport"

ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]
