CCS ccs; 
WIG wig; 

void setup () { 
  size(800,800, P2D); 
  background(0);
  ccs = new CCS("count", "chromosome position"); 
  wig = new WIG("L2-1_pm_mm-t100.wig"); 
  wig.read();
} 

void draw () { 
  background(0); 
  stroke(255); 
  ccs.display(); 
  for (int i=0; i < wig.size(); i++) { 
    WIGRecord r = wig.getRecord(i); 
    ccs.plotBar(r.startPos, round(r.dataValue), (r.endPos-r.startPos));
  }  
}

