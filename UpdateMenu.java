import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.ArrayList;
import java.io.IOException;

public class UpdateMenu {
    public static void main(String[] args) throws IOException {
        String transcriptPath = "C:\\Users\\ADMIN\\.gemini\\antigravity\\brain\\68e6e95b-ce68-4583-96e3-972d9bbb5e7e\\.system_generated\\logs\\transcript_full.jsonl";
        
        String content = new String(Files.readAllBytes(Paths.get(transcriptPath)));
        
        // Find the index of the start of the data
        int startIndex = content.indexOf("1\\t1\\tNeer Dosa");
        if (startIndex == -1) {
            System.out.println("Data not found!");
            return;
        }
        
        // Find the end index of the data (next JSON field or similar)
        int endIndex = content.indexOf("</USER_REQUEST>", startIndex);
        if (endIndex == -1) {
             endIndex = content.length();
        }
        
        String data = content.substring(startIndex, endIndex);
        // The data might have \\n or \n. Let's replace \\n with actual newlines just in case
        data = data.replace("\\n", "\n").replace("\\t", "\t");
        
        String[] lines = data.split("\n");
        
        System.out.println("Found " + lines.length + " data lines.");
        
        List<String> sqlQueries = new ArrayList<>();
        for (String line : lines) {
            String[] parts = line.split("\t");
            if (parts.length >= 8) {
                String menuid = parts[0];
                String foodname = parts[2];
                String img = getImage(foodname);
                sqlQueries.add("UPDATE menu SET imagepath = '" + img + "' WHERE menuid = " + menuid + ";");
            }
        }
        
        Files.write(Paths.get("update_images.sql"), sqlQueries);
        System.out.println("Generated " + sqlQueries.size() + " update queries.");
    }
    
    private static String getImage(String food) {
        String f = food.toLowerCase();
        
        if (f.contains("biryani") || f.contains("pulao") || f.contains("rice") || f.contains("bath") || f.contains("khichdi"))
            return "images/biryani.jpg";
            
        if (f.contains("fish") || f.contains("prawn") || f.contains("seafood") || f.contains("squid") || f.contains("crab") || f.contains("anjal") || f.contains("kane"))
            return "images/fish.jpg";
            
        if (f.contains("noodle") || f.contains("manchurian") || f.contains("fried rice") || f.contains("chop suey") || f.contains("roll") || f.contains("momos") || f.contains("dimsum") || f.contains("pizza") || f.contains("burger") || f.contains("pasta") || f.contains("sandwich") || f.contains("cheese") || f.contains("taco") || f.contains("nachos") || f.contains("burrito"))
            return "images/pizza.jpg";
            
        if (f.contains("paneer") || f.contains("veg") || f.contains("gobi") || f.contains("aloo") || f.contains("mushroom") || f.contains("dal") || f.contains("chole") || f.contains("palak"))
            return "images/paneer.jpg";
            
        if (f.contains("dosa") || f.contains("idli") || f.contains("rotti") || f.contains("appam") || f.contains("pesarattu") || f.contains("uttapam") || f.contains("pongal") || f.contains("upma") || f.contains("bhature") || f.contains("kulcha") || f.contains("naan"))
            return "images/masala_dosa.jpg";
            
        if (f.contains("vada") || f.contains("bajji") || f.contains("bonda") || f.contains("buns") || f.contains("puri") || f.contains("kachori") || f.contains("samosa"))
            return "images/medu_vada.jpg";
            
        if (f.contains("shawarma") || f.contains("kathi") || f.contains("wrap") || f.contains("falafel") || f.contains("hummus"))
            return "images/shawarma.jpg";
            
        if (f.contains("chicken fry") || f.contains("lollipop") || f.contains("65") || f.contains("chilli chicken") || f.contains("wings"))
            return "images/fried_chicken.jpg";
            
        if (f.contains("chicken") || f.contains("mutton") || f.contains("kebab") || f.contains("meat") || f.contains("lamb") || f.contains("beef") || f.contains("roast") || f.contains("sukka") || f.contains("curry") || f.contains("tikka") || f.contains("chops") || f.contains("sausage"))
            return "images/chicken_fry.jpg";
            
        // default fallback
        return "images/masala_dosa.jpg";
    }
}
