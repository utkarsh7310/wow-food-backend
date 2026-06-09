# Stage 1: Build stage (Code ko compile aur jar file banane ke liye)
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run stage (Sirf bani hui jar file ko chalane ke liye - isse size chota rehta hai)
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Render ka port handle karne ke liye (Render automatically PORT variable deta hai)
EXPOSE 8080
CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT:-8080}"]
