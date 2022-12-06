import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 * https://springhow.com/java-write-csv/
 */
public class CsvWriter {
	
  public static void main(String[] args) throws IOException {
	  
	  ArrayList<String> coords = new JSONParser().parse("src/cta_entrances.json");
 
	  File csvFile = new File("chicago_cta_coordinates.csv");
	  FileWriter fileWriter = new FileWriter(csvFile);

	  fileWriter.write("Longitude, Latitude\n");
      
      int i = 0;
      while(i < coords.size() - 2) {
    	  String lon = coords.get(i);
    	  String lat = coords.get(i+1);
    	  i = i+2;
    	  
    	  fileWriter.write(lon);
    	  fileWriter.write(", ");
    	  fileWriter.write(lat);
    	  fileWriter.write("\n");

      }
      
      fileWriter.close();
      System.out.println("File successfully made! enjoy your cool little fun little numbers :)");
  }
}
   
