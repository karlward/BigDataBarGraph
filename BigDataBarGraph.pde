CCS ccs; 
WIG wig; 

void setup () { 
  size(800,800); 
  background(0);
  ccs = new CCS("count", "chromosome position"); 
  wig = new WIG("L2-1_pm_mm.wig"); 
  wig.read();
} 

void draw () { 
  background(0); 
  stroke(255); 
  ccs.display(); 
  for (int i=0; i < wig.size(); i++) { 
    WIGRecord r = wig.getRecord(i); 
    if (ccs.xMin > r.startPos) { 
      ccs.xMin = r.startPos;
    }
    if (ccs.xMax < r.endPos) { 
      ccs.xMax = r.endPos;
    }
    if (ccs.yMin > r.dataValue) { 
      ccs.yMin = round(r.dataValue);
    }
    if (ccs.yMax < r.dataValue) { 
      ccs.yMax = round(r.dataValue);
    } 
    ccs.plotBar(r.startPos, round(r.dataValue), (r.endPos-r.startPos));
  }  
}

