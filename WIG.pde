import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.ArrayList; 

class WIGRecord { 
  public String chromosome; 
  public int startPos;
  public int endPos;
  public float dataValue; 
  
  WIGRecord(String c, int s, int e, float d) { 
    chromosome = c; 
    startPos = s;
    endPos = e;
    dataValue = d; 
  }
}

class WIG { 
  String filename; 
  BufferedReader reader; 
  ArrayList<WIGRecord> records;

  WIG(String vFilename) { 
    filename = vFilename; 
    records = new ArrayList<WIGRecord>(); 
  } 

  void read() { 
    try { 
      reader = createReader(filename);
      String currentLine; 
      Pattern p = Pattern.compile("^(\\S+)\\s+(\\d+)\\s+(\\d+)\\s([-0-9.]+)"); 
      Matcher m; 
      while((currentLine = reader.readLine()) != null) { 
        m = p.matcher(currentLine); 
        if (m.matches()) { 
          addRecord(m.group(1), int(m.group(2)), int(m.group(3)), float(m.group(4))); 
        }
      } 
    } catch (IOException e) { 
      e.printStackTrace(); 
    } 
  }
  
  void addRecord(String chromosome, int startPos, int endPos, float dataValue) { 
    WIGRecord record = new WIGRecord(chromosome, startPos, endPos, dataValue); 
    records.ensureCapacity(records.size() + 1); // FIXME: inefficient
    records.add(record); 
  } 
  
  long size() { 
    return(records.size()); 
  }
  
  WIGRecord getRecord(int index) { 
    return(records.get(index)); 
  } 
} 

