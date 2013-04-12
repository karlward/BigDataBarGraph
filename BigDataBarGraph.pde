CCS ccs; 
WIG wig; 
PGraphics offScreenPg; // offscreen PGraphics window
boolean needToDraw = true;
boolean offScreenDrawing = false; 

void setup () { 
  size(800, 800); 
  frameRate(30);

  offScreenPg = createGraphics(800, 800); 
  ccs = new CCS("expression level", "chromosome position", offScreenPg); 
  wig = new WIG("L2-1_pm_mm.wig"); 
  wig.read();
} 

void draw () { 
  if (needToDraw == true) { 
    loadPixels(); 
    thread("offScreen"); // do difficult stuff in a thread (e.g. render the pg object) 
    offScreenPg.loadPixels();
    arrayCopy(offScreenPg.pixels, pixels); 
    updatePixels();
    needToDraw = false;
  }
  if (keyPressed) { // interpret key press as a refresh command 
    needToDraw = true;
  }

//  arrayCopy(offScreenPg.pixels, pixels); 
  //updatePixels();

  // show the current (x,y) position in the top right corner
  fill(0);
  rect(width-120, 0, 120, 20);  
  fill(255);
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
    offScreenPg.loadPixels();
    offScreenPg.beginDraw();
    offScreenPg.background(0); 
    offScreenPg.stroke(255); 
    offScreenPg.fill(255);
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
    offScreenPg.endDraw(); 
    
    offScreenDrawing = false;
  }
}

