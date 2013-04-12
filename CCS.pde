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
  int zoomX; // x value for center of current zoom focus
  int zoomY; // y values for center of current zoom focus

  // label each axis (unimplemented)
  String xLabel; 
  String yLabel;

  CCS(String vXLabel, String vYLabel) { 
    xMin = round(-height);
    yMin = round(-width); 
    xMax = round(height);
    yMax = round(width);
    xLabel = vXLabel; 
    yLabel = vYLabel;
    zoomLevel = 1;
    zoomX = 0; 
    zoomY = 0;
  } 

  void display() {  
    xTrans = width * (abs(xMin / float(abs(xMin)+abs(xMax))));
    yTrans = height * (abs(yMax / float(abs(yMin)+abs(yMax))));
    xScale = width/float(xMax-xMin);
    yScale = -height/float(yMax-yMin); 
    
    pushMatrix();
    translate(xTrans, yTrans);
    
    // draw the axes
    line(-width, 0, width, 0); // x axis
    line(0, -height, 0, height); // y axis

    scale(xScale*zoomLevel, yScale*zoomLevel); 

    // let's put some values on the axes
    pushMatrix();
    scale(1/(xScale*zoomLevel), 1/(yScale*zoomLevel)); // temporarily undo the scaling, for text rendering reason
    textAlign(RIGHT, TOP);
    textSize(16);
    text(round(xMax/zoomLevel), (xMax*xScale), 0);
    textAlign(LEFT, TOP);
    text(round(xMin/zoomLevel), (xMin*xScale), 0);
    text(round(yMax/zoomLevel), 0, (yMax*yScale));
    textAlign(LEFT, BOTTOM);
    text(round(yMin/zoomLevel), 0, (yMin*yScale));
    popMatrix(); 
    popMatrix(); 
  }

  void plotPoint(int x, int y) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale*zoomLevel, yScale*zoomLevel); 
    point(x, y);
    popMatrix();
  }

  void plotLine(int x1, int y1, int x2, int y2) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale*zoomLevel, yScale*zoomLevel); 
    line(x1, y1, x2, y2);
    popMatrix();
  }

  void plotBar(int x, int y, int barWidth) { 
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale*zoomLevel, yScale*zoomLevel); 
    rect(x, 0, barWidth, y); 
    popMatrix();
  } 
  
  void zoomIn() {  

    println("zooming in on (" + zoomX + "," + zoomY + ")");
    // find the middle of the Processing window 
    int centerX = round(width / 2); 
    int centerY = round(height / 2); 
    
    // convert the CCS grid (x, y) values to Processing (x,y) values
    int realX = round((zoomX * xScale) + xTrans);
    int realY = round((zoomY * yScale) + yTrans);
    
    translate(centerX-realX, centerY-realY);
    
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
