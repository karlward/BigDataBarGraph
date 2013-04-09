class CCS { 
  int xOffset;
  int yOffset;
  int xScale; 
  int yScale;
  String xLabel; 
  String yLabel;
  int margin;  

  CCS(int vXOffset, int vYOffset, int vXScale, int vYScale, String vXLabel, String vYLabel) { 
    xOffset = vXOffset;
    yOffset = vYOffset; 
    xScale = vXScale;
    yScale = vYScale;
    xLabel = vXLabel; 
    yLabel = vYLabel;
  } 

  void display() { 
    // draw the axes
    line(xOffset, 0, xOffset, height); 
    line(xOffset, yOffset, width, yOffset); 

    textSize(12);
    // label the x axis  
    text("0", (xOffset/2)-5, yOffset);
    text(yScale, (xOffset/2)-10, height-yOffset);
    text(xLabel, xOffset/4, (height/2));

    // label the y axis
    text("0", xOffset+5, yOffset+((height-yOffset)/2));
    text(xScale, width-xOffset, yOffset+((height-yOffset)/2));
    text(yLabel, (width/2)-xOffset, yOffset+((height-yOffset)/2));
  }

  void plotPoint(int xCoord, int yCoord) { 
    int realXCoord = round(map(xCoord, 0, xScale, xOffset, width-xOffset)); 
    int realYCoord = round(map(yCoord, 0, yScale, yOffset, height-yOffset)); 
    point(realXCoord, realYCoord);
  }

  void plotLine(int x1, int y1, int x2, int y2) {
    int realX1 = round(map(x1, 0, xScale, xOffset, width-xOffset)); 
    int realY1 = round(map(y1, 0, yScale, yOffset, height-yOffset)); 
    int realX2 = round(map(x2, 0, xScale, xOffset, width-xOffset)); 
    int realY2 = round(map(y2, 0, yScale, yOffset, height-yOffset)); 
    line(realX1, realY1, realX2, realY2); 
  }

  void plotBar (int x1, int y1, int x2, int y2) {
      int realX1 = round(map(x1, 0, xScale, xOffset, width-xOffset)); 
      int realY1 = round(map(y1, 0, yScale, yOffset, height-yOffset)); 
      int realX2 = round(map(x2, 0, xScale, xOffset, width-xOffset)); 
      int realY2 = round(map(y2, 0, yScale, yOffset, height-yOffset)); 
      if (y1 > 0) { 
        rect(realX1, realY1, Math.abs(realX2-realX1), Math.abs(realY1-yOffset));
      }
      else { 
        rect(realX1, yOffset, Math.abs(realX2-realX1), Math.abs(realY1-yOffset));
      }
  }
}
