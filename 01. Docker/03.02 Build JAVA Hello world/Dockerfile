# Use an Java runtime as base image
FROM eclipse-temurin:25-jre

# Set working directory inside container
WORKDIR /app

# Copy the compiled Java class into the container
COPY HelloWorld.class .

# Set the command to run when container starts
CMD ["java", "HelloWorld"]
