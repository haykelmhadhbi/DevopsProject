FROM openjdk:11
EXPOSE 8082
# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le JAR de votre application dans le conteneur
COPY target/DevOps_Project-2.1.jar app.jar

# Exécutez l'application Spring Boot au démarrage
CMD ["java", "-jar", "app.jar"]
