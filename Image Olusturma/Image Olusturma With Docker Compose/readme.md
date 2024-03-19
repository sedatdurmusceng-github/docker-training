javac Sum.java
jar cfe Sum.jar Sum *.class

docker build -t my-java-sum-app:latest .
docker-compose up

Test
-----------------------------------------------
curl -X POST -d "5,10" http://localhost:7000