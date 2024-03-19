# Resmi OpenJDK 21 imajını kullan
FROM openjdk:21-jdk-slim

# Uygulama JAR dosyasını Docker imajına kopyalayalım
COPY Sum.jar /app/Sum.jar

# Çalışma dizinini /app olarak belirleyelim
WORKDIR /app

# Ortam değişkenlerinden alınacak sayıları çalışma zamanında ayarlayalım
CMD ["java", "-jar", "Sum.jar"]