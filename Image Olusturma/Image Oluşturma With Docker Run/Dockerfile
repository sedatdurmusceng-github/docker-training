# Resmi OpenJDK 21 imajını kullan
FROM openjdk:21-jdk-slim

# Uygulama JAR dosyasını /uygulama/ dizinine kopyala
COPY RandomNumberHttpServer.jar /uygulama/RandomNumberHttpServer.jar

# Uygulamanın çalıştırılacağı dizini belirt
WORKDIR /uygulama

# Docker konteynerı başlatıldığında uygulamayı çalıştır
CMD ["java", "-jar", "RandomNumberHttpServer.jar"]
