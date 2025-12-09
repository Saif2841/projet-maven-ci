FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built JAR from Maven (target/)
COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
