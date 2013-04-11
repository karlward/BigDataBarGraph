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
  } 

  void display() {
    if (xMin > 0) { 
      xTrans = 0; 
    } 
    else {    
      xTrans = width * (abs(xMin / float(abs(xMin)+abs(xMax))));
    }
    if (yMin > 0) { 
      yTrans = 0; 
    }
    else { 
      yTrans = height * (abs(yMax / float(abs(yMin)+abs(yMax))));
    }
    xScale = width/float(xMax-xMin);
    yScale = -height/float(yMax-yMin); 
    
    pushMatrix();
    translate(xTrans, yTrans);
    
    // draw the axes
    line(-width, 0, width, 0); // x axis
    line(0, -height, 0, height); // y axis

    scale(xScale, yScale); 

    // let's put some values on the axes
    pushMatrix();
    scale(1/xScale, 1/yScale); // temporarily undo the scaling, for text rendering reason
    textAlign(RIGHT, TOP);
    textSize(16);
    text(xMax, (xMax*xScale), 0);
    text(yMax, 0, (yMax*yScale));
    textAlign(LEFT, TOP);
    text(xMin, (xMin*xScale), 0);
    textAlign(RIGHT, BOTTOM);
    text(yMin, 0, (yMin*yScale));
    popMatrix(); 
    popMatrix(); 
  }

  void plotPoint(int x, int y) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale, yScale); 
    point(x, y);
    popMatrix();
  }

  void plotLine(int x1, int y1, int x2, int y2) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale, yScale); 
    line(x1, y1, x2, y2);
    popMatrix();
  }

  void plotBar(int x, int y, int barWidth) { 
    pushMatrix();
    translate(xTrans, yTrans);
    scale(xScale, yScale); 
    rect(x, 0, barWidth, y); 
    popMatrix();
  } 
}
