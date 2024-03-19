import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;

public class Sum {
    private static int num1 = 0;
    private static int num2 = 0;

    public static void main(String[] args) throws IOException {
        // Ortam değişkenlerinden sayıları al
        String num1Str = System.getenv("NUM1");
        String num2Str = System.getenv("NUM2");
        if (num1Str != null && num2Str != null) {
            num1 = Integer.parseInt(num1Str);
            num2 = Integer.parseInt(num2Str);
        }

        // HTTP sunucusunu başlat
        HttpServer server = HttpServer.create(new InetSocketAddress(7000), 0);
        server.createContext("/", exchange -> {
            if ("POST".equals(exchange.getRequestMethod())) {
                // POST isteği ile gelen sayıları al
                String requestBody = new String(exchange.getRequestBody().readAllBytes());
                String[] numbers = requestBody.split(",");
                if (numbers.length == 2) {
                    num1 = Integer.parseInt(numbers[0]);
                    num2 = Integer.parseInt(numbers[1]);
                }
            }

            // Toplamı hesapla ve yanıtı gönder
            String response = "Sum: " + (num1 + num2);
            exchange.sendResponseHeaders(200, response.getBytes().length);
            OutputStream os = exchange.getResponseBody();
            os.write(response.getBytes());
            os.close();
            exchange.close();
        });
        server.start();

        System.out.println("Server is listening on port 7000...");
    }
}
