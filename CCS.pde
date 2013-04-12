class CCS { 
  int xMin; // minimum X value possible
  int yMin; // minimum Y value possible
  int xMax; // maximum X value possible
  int yMax; // maximum Y value possible

  // we will use translate() to center the grid in the window
  float xTrans; // amount of x translation
  float yTrans; // amount of y translation
  
  // we will use scale() for two reasons: 
  //  1. to allow large x and y values to fit into the window
  //  2. to flip y values so positive y values are above negative y values
  float xScale; 
  float yScale; 
  
  int zoomLevel; // how zoomed in we are (1 is fully zoomed out, higher values are more zoomed in)

  // label each axis (unimplemented)
  String xLabel; 
  String yLabel;
  
  PGraphics pg; 

  CCS(String vXLabel, String vYLabel, PGraphics vPg) { 
    pg = vPg; 
    xMin = round(-pg.height);
    yMin = round(-pg.width); 
    xMax = round(pg.height);
    yMax = round(pg.width);
    xLabel = vXLabel; 
    yLabel = vYLabel;
    zoomLevel = 1;
  } 

  void display() {  
    xTrans = pg.width * (abs(xMin / float(abs(xMin)+abs(xMax))));
    yTrans = pg.height * (abs(yMax / float(abs(yMin)+abs(yMax))));
    xScale = pg.width/float(xMax-xMin);
    yScale = -pg.height/float(yMax-yMin); 
    
    pg.pushMatrix();
    pg.translate(xTrans, yTrans);
    
    // draw the axes
    pg.line(-pg.width, 0, pg.width, 0); // x axis
    pg.line(0, -pg.height, 0, pg.height); // y axis

    pg.scale(xScale*zoomLevel, yScale*zoomLevel); 

    // let's put some values on the axes
    pg.pushMatrix();
    pg.scale(1/(xScale*zoomLevel), 1/(yScale*zoomLevel)); // temporarily undo the scaling, for text rendering reason
    pg.textAlign(RIGHT, TOP);
    pg.textSize(16);
    pg.text(round(xMax/zoomLevel), (xMax*xScale), 0);
    pg.textAlign(LEFT, TOP);
    pg.text(round(xMin/zoomLevel), (xMin*xScale), 0);
    pg.text(round(yMax/zoomLevel), 0, (yMax*yScale));
    pg.textAlign(LEFT, BOTTOM);
    pg.text(round(yMin/zoomLevel), 0, (yMin*yScale));
    pg.popMatrix(); 
    pg.popMatrix(); 
  }

  void plotPoint(int x, int y) {
    pg.pushMatrix();
    pg.translate(xTrans, yTrans);
    pg.scale(xScale*zoomLevel, yScale*zoomLevel); 
    pg.point(x, y);
    pg.popMatrix();
  }

  void plotLine(int x1, int y1, int x2, int y2) {
    pg.pushMatrix();
    pg.translate(xTrans, yTrans);
    pg.scale(xScale*zoomLevel, yScale*zoomLevel); 
    pg.line(x1, y1, x2, y2);
    pg.popMatrix();
  }

  void plotBar(int x, int y, int barWidth) { 
    pg.pushMatrix();
    pg.translate(xTrans, yTrans);
    pg.scale(xScale*zoomLevel, yScale*zoomLevel); 
    pg.rect(x, 0, barWidth, y); 
    pg.popMatrix();
  } 
  
  void zoomIn() {  
    if (zoomLevel <= 1000) { 
      zoomLevel = zoomLevel + 1; 
    }
  }
  
  void zoomOut() { 
    if (zoomLevel > 1) { 
      zoomLevel = zoomLevel - 1; 
    }
  }
}
