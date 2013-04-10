class CCS { 
  int xMin; // minimum X value possible
  int yMin; // minimum Y value possible
  int xMax; // maximum X value possible
  int yMax; // maximum Y value possible
  float xTrans;
  float yTrans;
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
    
    pushMatrix();
    translate(xTrans, yTrans);
    
    // draw the axes
    line(-width, 0, width, 0); // x axis
    line(0, -height, 0, height); // y axis

    scale(width/float(xMax-xMin), -height/float(yMax-yMin)); 

    // let's put some values on the axes
    pushMatrix();
    scale(1/(width/float(xMax-xMin)), 1/(-height/float(yMax-yMin)));
    textAlign(RIGHT, TOP);
    textSize(16);
    text(xMax, (xMax*width/float(xMax-xMin)), 0);
    text(yMax, 0, (yMax*-height/float(yMax-yMin)));
    textAlign(LEFT, TOP);
    text(xMin, (xMin*width/float(xMax-xMin)), 0);
    textAlign(RIGHT, BOTTOM);
    text(yMin, 0, (yMin*-height/float(yMax-yMin)));
    popMatrix(); 
    popMatrix(); 
  }

  void plotPoint(int x, int y) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(width/float(xMax-xMin), -height/float(yMax-yMin)); 
    point(x, y);
    popMatrix();
  }

  void plotLine(int x1, int y1, int x2, int y2) {
    pushMatrix();
    translate(xTrans, yTrans);
    scale(width/float(xMax-xMin), -height/float(yMax-yMin)); 
    line(x1, y1, x2, y2);
    popMatrix();
  }

  void plotBar(int x, int y, int barWidth) { 
    pushMatrix();
    translate(xTrans, yTrans);
    scale(width/float(xMax-xMin), -height/float(yMax-yMin)); 
    rect(x, 0, barWidth, y); 
    popMatrix();
  } 
}
