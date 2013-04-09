CCS ccs; 
WIG wig; 

void setup () { 
  size(800,600); 
  background(0);
  ccs = new CCS(50, height-50, 800, 600, "count", "chromosome position"); 
  wig = new WIG("L2-1_pm_mm-t1000.wig"); 
  wig.read();
} 


void draw () { 
  background(0); 
  stroke(255); 
  ccs.display(); 
  for (int i=0; i < wig.size(); i++) { 
    WIGRecord r = wig.getRecord(i); 
    if (ccs.yMax < r.dataValue) { 
      ccs.yMax = Math.round(r.dataValue);
    }
    if (ccs.xMax < r.endPos) { 
      ccs.xMax = r.endPos;
    }
    //ccs.plotLine(r.startPos, Math.round(r.dataValue), r.endPos, Math.round(r.dataValue)); 
    ccs.plotBar(r.startPos, Math.round(r.dataValue), r.endPos, Math.round(r.dataValue)); 
  }
}

