# Use an official OpenJDK base image
FROM eclipse-temurin:17-jdk as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the application using Maven Wrapper
RUN ./mvnw package -DskipTests

# Use a minimal JDK runtime image for the final container
FROM eclipse-temurin:17-jre

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
