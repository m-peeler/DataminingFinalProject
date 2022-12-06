import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

public class JSONParser {
	
	/**
	 * Returns all coordinates in order, as a string, representing the location of all metro stations in Chicago.
	 * @throws IOException 
	 */
	public ArrayList<String> parse(String filepath) throws IOException {
		String filestring = new String(Files.readAllBytes(Paths.get(filepath)));
		
		JSONTokener tokenizer = new JSONTokener(filestring);
        JSONObject root = new JSONObject(tokenizer);
        
        JSONArray features = getFeatures(root);
        
        return extractCoordinates(features);
        
	}
	
	public ArrayList<String> extractCoordinates(JSONArray features) {
		
		ArrayList<String> coordList = new ArrayList<String>();
		
		for (int i = 0; i < features.length(); i++) {
			JSONObject geometry = getGeometry(features.getJSONObject(i));
			JSONArray coords = getCoordinates(geometry);
			coordList.add((String)coords.get(0).toString()); // longitude first
			coordList.add((String)coords.get(1).toString()); // latitude second
		}
		
		return coordList;
	}
	
	public JSONArray getFeatures(JSONObject obj) {
		return getArray("features", obj);
	}
	
	public JSONObject getGeometry(JSONObject obj) {
		return getObject("geometry", obj);
	}
	
	public JSONArray getCoordinates(JSONObject obj) {
		return getArray("coordinates", obj);
	}
	
    private JSONObject getObject(String key, JSONObject obj) {
        try {
            return obj.getJSONObject(key);
        } catch (JSONException e) {
            System.out.println(String.format("Could not find JSONObject with key \"%s\"", key));
        }

        return null;
    }
    
    private JSONArray getArray(String key, JSONObject obj) {
        try {
            return obj.getJSONArray(key);
        } catch (JSONException e) {
            System.out.println(String.format("Could not find JSONArray with key \"%s\"", key));
        }

        return null;
    }
    
//    public static void main(String[] args) {
//    	
//    	try {
//			System.out.println(new JSONParser().parse("src/metra_entrances.json"));
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    	
//    }
    
}



