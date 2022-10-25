package DataPrep;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import com.opencsv.*;
import com.opencsv.exceptions.CsvValidationException;

public class CleanNYCLatLon {
	
	public static void cleanNYCLatLon(String inputFilePath, String outputFilePath) 
			throws IOException, CsvValidationException {
		
	    CSVReader reader = new CSVReaderBuilder(new FileReader(inputFilePath)).build();
	    CSVWriter writer = new CSVWriter(new FileWriter(outputFilePath));
	    
	    String[] header = reader.readNext();
	    int geomIndex = -1;
	    int nameIndex = -1;
	    int idIndex = -1;
	    for (int i = 0; i < header.length; i++) { 
	    	System.out.println(header[i]);
	    	if (header[i].equals("the_geom")) geomIndex = i;
	    	if (header[i].equals("NAME")) nameIndex = i;
	    	if (header[i].equals("OBJECTID")) idIndex = i;
	    }
	    
	    String[] outputHeader = new String[] {"ID", "Name", "Latitude", "Longitude"};
	    writer.writeNext(outputHeader);
	    
	    for (String[] strArr : reader) {
	    	String[] latLon = parseValFromGeom(strArr[geomIndex]);
	    	String[] output = new String[4];
	    	output[0] = strArr[idIndex];
	    	output[1] = strArr[nameIndex];
	    	output[2] = latLon[0];
	    	output[3] = latLon[1];
	    	writer.writeNext(output);
	    }
	    
	    reader.close();
	    writer.close();
	}

	private static String[] parseValFromGeom(String geom) {
		String[] vals = geom.replace("POINT (", "").replace(")", "").split(" ");
		return vals;
	}
}
