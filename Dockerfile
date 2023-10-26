# Use the official OpenJDK image as a parent image
FROM openjdk:8-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file built by Maven into the container
COPY target/DevOps_Project-1.0.jar /app/app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8081

# Command to run your Spring Boot application
CMD ["java", "-jar", "app.jar"]
