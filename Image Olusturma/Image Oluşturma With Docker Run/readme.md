javac RandomNumberHttpServer.java
jar cfe RandomNumberHttpServer.jar RandomNumberHttpServer *.class

docker build -t simple-http-server . // Bu komut, Dockerfile'ı kullanarak bir Docker imajı oluşturur ve simple-http-server adını verir.
docker run -d -p 8000:8000 --name my-http-server simple-http-server // Bu komut, simple-http-server adlı Docker imajını kullanarak bir Docker konteynerı başlatır ve 8000 numaralı porttan HTTP sunucunuzu yayınlar.