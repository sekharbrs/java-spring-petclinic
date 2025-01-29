FROM techiescamp/jdk-17:1.0.0 AS build

# Copy the Java Application source code
COPY . /usr/src/

# Build Java Application
RUN mvn -f /usr/src/pom.xml clean install -DskipTests

FROM techiescamp/jre-17:1.0.0
WORKDIR /app

# Copy the JAR file from the build stage (/app)
COPY --from=build /usr/src/target/*.jar ./java.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the jar file
CMD ["java", "-jar", "java.jar"]
