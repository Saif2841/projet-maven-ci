FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy the built JAR
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]