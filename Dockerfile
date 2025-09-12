# Use an official JDK runtime as a base image
FROM openjdk:17-jdk-slim

# Set the working directory inside container
WORKDIR /app

# Copy the JAR into the container
COPY target/rest-demo.jar app.jar

# Expose the port your Spring Boot app runs on (default 8080)
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
