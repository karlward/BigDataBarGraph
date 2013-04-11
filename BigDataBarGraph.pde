CCS ccs; 
WIG wig; 

void setup () { 
  size(800,800); 
  background(0);
  ccs = new CCS("expression level", "chromosome position"); 
  wig = new WIG("L2-1_pm_mm-t1000.wig"); 
  wig.read();
} 

void draw () { 
  background(0); 
  stroke(255); 
  fill(255);
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

  int xPos, yPos;
  xPos = round((mouseX - ccs.xTrans) / ccs.xScale);
  yPos = round((mouseY - ccs.yTrans) / ccs.yScale);
  textAlign(RIGHT, TOP); 
  String position = "(" + xPos + "," + yPos + ")"; 
  fill(255,0,0); 
  text(position, width, 0);
  fill(255);
}

