CCS ccs; 
WIG wig; 
PGraphics pg; // offscreen PGraphics window
boolean needToDraw = true;
boolean offScreenDrawing = false; 

void setup () { 
  size(800, 800); 
  frameRate(30);

  pg = createGraphics(800, 800); 
  ccs = new CCS("expression level", "chromosome position", pg); 
  wig = new WIG("L2-1_pm_mm-t1000000.wig"); 
  wig.read();
} 

void draw () { 
  loadPixels(); 
  if (needToDraw == true) {
    pg.loadPixels();
    thread("offScreen"); // do difficult stuff in a thread (e.g. render the pg object) 
    needToDraw = false;
  }
  if (keyPressed && ((key == '+') || (key == '-'))) { // interpret key press as a refresh command 
    needToDraw = true;
  }
  arrayCopy(pg.pixels, pixels); 
  updatePixels();

  // show the current (x,y) position in the top right corner
  int xPos, yPos;
  xPos = round((mouseX - ccs.xTrans) / ccs.xScale / ccs.zoomLevel);
  yPos = round((mouseY - ccs.yTrans) / ccs.yScale / ccs.zoomLevel);
  textAlign(RIGHT, TOP); 
  String position = "(" + xPos + "," + yPos + ")"; 
  fill(255, 0, 0); 
  text(position, width, 0);
  fill(255);
}

synchronized void offScreen() { 
  if (offScreenDrawing == false) { 
    offScreenDrawing = true; 
    pg.beginDraw();
    pg.background(0); 
    pg.stroke(255); 
    pg.fill(255);
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

    if (keyPressed && key == '+') { 
      ccs.zoomIn();
    }
    else if (keyPressed && key == '-') { 
      ccs.zoomOut();
    }
    pg.endDraw(); 
    offScreenDrawing = false;
  }
}

