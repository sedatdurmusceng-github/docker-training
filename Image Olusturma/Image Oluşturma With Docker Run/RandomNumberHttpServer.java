import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.Random;

public class RandomNumberHttpServer {
    public static void main(String[] args) throws Exception {
        // HTTP sunucusunu 8000 numaralı portta başlat
        HttpServer server = HttpServer.create(new InetSocketAddress(8000), 0);
        // '/' endpoint'ine bir istek geldiğinde işlenecek işlem
        server.createContext("/", new RandomNumberHandler());
        // Sunucuyu başlat
        server.start();
        System.out.println("Sunucu başlatıldı. Port: 8000");
    }

    static class RandomNumberHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            // Rasgele bir sayı üret
            Random rand = new Random();
            int randomNumber = rand.nextInt(100); // 0 ile 99 arasında bir sayı üret
            String response = String.valueOf(randomNumber); // Dönülecek sayı
            t.sendResponseHeaders(200, response.length()); // Cevap kodu ve cevap uzunluğu ayarla
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes()); // Cevabı gönder
            os.close();
        }
    }
}
