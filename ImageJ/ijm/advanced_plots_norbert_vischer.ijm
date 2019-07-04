// "Advanced Plots" macros
// Norbert Vischer  23-aug-2018 
//
// These macros demonstrate filled plots, custom plot symbols,
// staircase histograms,  the usage of functions toUnscaled() and toScaled() 
// and the creation of dynamic plots (stacks containing a plot family)
//
// There are eight macros:
//    Filled Plot [1]
//    Staircase Histogram [2]
//    Damped Wave Plot [3] *
//    Plot with Custom Symbols [4] *
//    Highlight and Annotate Area [5]
//    Qualify Roi [6]
//    Dynamic Plot [7] *
//    Dynamic Plot 2D [8] *
//
//  *These macros are also avalilabe from menu Help>Examples>Macro>
// Some macros require ImageJ 1.51u or later.


macro "Filled Plot [1]"{
   requires("1.51t");
   left = 0;
   right = 4;
   bottom = 0;
   top = 1.2;
   nPoints = 50;
   range = right - left;
   
   //Create demo data
   xValues = newArray(nPoints);
   yValues = newArray(nPoints);
   sigma = 0.4; ampl = 1;   x0 = 2;
   for (p = 0; p < nPoints; p++){
      x = p/nPoints * range + left;
      y = ampl * exp(-pow(x - x0, 2)/(sigma * sigma * 2));
      xValues[p] = x;
      yValues[p] = y;
   }
   
   //Create filled plot
   Plot.create("Filled Plot", "X", "Y");
   Plot.setLimits(left, right, bottom, top );
   Plot.setFrameSize(600, 300 );
   Plot.setColor("blue", "#ccccff");
   Plot.add("filled", xValues, yValues);
   Plot.show;
}

//Staircase histogram 
macro "Staircase Histogram [2]"{
    requires("1.52f");
    values = newArray(2,3,3,3,4,4);
    Plot.create("Mini Histogram", "X", "Y");
    Plot.setColor("red", "#ddddff");
    binWidth = 1;//use 0 for auto-binning
    binCenter = 0;
    Plot.addHistogram(values, binWidth, binCenter);
    Plot.setLimits(NaN, NaN, 0, NaN);
}

//Uses postive and negative filled plots
// Author: Norbert Vischer
//*Also avalilabe from menu Help>Examples>Macro>            
macro "Damped Wave Plot [3]"{
   requires("1.51t");
   left = 0;
   right = 4;
   bottom = -1.2;
   top = 1.2;
   nPoints = 150;
   
   //Create demo data
   xValues = newArray(nPoints);
   yValues1 = newArray(nPoints);
   yValues2 = newArray(nPoints);
   yValues3 = newArray(nPoints);
   for (p = 0; p < nPoints; p++){
      x = p/nPoints * right;
      xValues[p] = x;
      a = exp(-x);
      yValues1[p] = a;
      yValues2[p] = -a;
      yValues3[p] = a * cos(p/5);
   }
   
   Plot.create("Damped Wave", "X", "Y");
   Plot.setLimits(left, right, bottom, top );
   Plot.setFrameSize(600, 300 );
   Plot.setColor( "#ddddff");
   Plot.add("filled", xValues, yValues1);
   Plot.add("filled", xValues, yValues2);
   Plot.setColor("blue");
   Plot.setLineWidth(2);
   Plot.add("line", xValues, yValues3);
   Plot.show;
}

macro "Plot with Custom Symbols [4]" {
/*
*Also avalilabe from menu Help>Examples>Macro>
With ImageJ 1.51r and later, if the 'type' argument of the Plot.add(type,xpoints,ypoints)
macro function starts with "code: " then the macro code contained in the rest of the
string is executed per point, using variable names 'x' and 'y' for the point location, 
's' for high-resolution scale factor and 'i' for the point index.
*/
    xValues = newArray(11, 20, 33, 46, 61, 82);
    yValues1 = newArray(31, 40, 48, 52, 55, 58);
    yValues2 = newArray(21, 30, 38, 42, 45, 48);
    yValues3 = newArray(11, 20, 28, 32, 35, 38);
    yValues4 = newArray(1, 10, 18, 22, 25, 28);

    cross = "code: fillOval(x-8*s,y-2*s,16*s,4*s);fillOval(x-2*s,y-8*s, 4*s,16*s);";
    circle = "code: fillOval(x-6*s,y-6*s,12*s,12*s);setColor('yellow');fillOval(x-3*s,y-3*s,6*s,6*s);";
    letter = "code: setFont('sanserif',14*s,'bold anti');drawString('H',x-4*s,y+8*s);"
    numbers = "code: setFont('sanserif',14*s,'bold anti');drawString(''+i,x-4*s,y+8*s);"
     
    Plot.create("Plot with Custom Symbols", "X", "Y");
    Plot.setLimits(0, 90, 0, 60 );
    
    Plot.setLineWidth(2);
    Plot.setColor("#ffbbbb"); //light red
    Plot.add("line", xValues, yValues1);
    Plot.setColor("red"); 
    Plot.add(cross, xValues, yValues1); 

    Plot.setColor("#bbbbff"); //light blue
    Plot.add("line", xValues, yValues2);
    Plot.setColor("blue"); 
    Plot.add(circle, xValues, yValues2); 

    Plot.setColor("#800000"); // maroon
    Plot.add("line", xValues, yValues3);
    Plot.setColor("#a00000");
    Plot.add(letter, xValues, yValues3); 

    Plot.setColor("#bbbbbb"); // light gray
    Plot.add("line", xValues, yValues4);
    Plot.setColor("black");
    Plot.add(numbers, xValues, yValues4); 

    // empty labels cause lines to be ignored in legend
    Plot.setFontSize(14);
    Plot.addLegend("\nRed symbol\n\nBlue symbol\n\nLetter\n\nNumbers");
  
    Plot.show;
}

macro "Highlight and Annotate Area [5]" {
   left = -1;
   right = 5;
   bottom = -0.2;
   top = 1.2;
   nPoints = 200;
   range = right - left;
   
   xValues = newArray(nPoints);
   yValues = newArray(nPoints);
   Plot.create("Gauss-Ellipse-Match", "X", "Y");
   Plot.setFrameSize(500, 300);
   Plot.setLimits(left, right, bottom, top );
   sigma = 2;
   ampl = 1;    
   x0 = 2;
   radiusX = sigma /sqrt(2);//horizontal radius
   for (p = 0; p < nPoints; p++){
      x = p/nPoints * range + left;
      y = ampl * exp(-pow(x - x0, 2)/(sigma * sigma * 2));
      xValues[p] = x;
      yValues[p] = y;
   }
   Plot.setColor("blue");
   Plot.add("line", xValues, yValues);
   Plot.setColor("red");
   Plot.drawLine(x0, ampl/2, x0+radiusX, ampl/2);
   Plot.show;
   
   hookLeft = x0-radiusX;
   hookTop =    ampl;
   hookBottom =   0;
   hookRight = x0+radiusX;
   toUnscaled(hookLeft, hookTop);
   toUnscaled(hookRight, hookBottom);
   
   makeOval(hookLeft, hookTop, hookRight - hookLeft, hookBottom - hookTop);
   changeValues(0x00ffffff, 0x00ffffff, 0x00ccddff);
   run("Select None");
   setColor(0xff0000);
   x = x0;
   y = ampl/2;
   toUnscaled(x, y);
   setFont("SansSerif" , 14, "antialiased");
   drawString("r = sigma / sqrt(2)", x, y-2);
   if (getVersion()>="1.49t")
      Plot.freeze(); //avoid removing the oval or annotation by resizing or zooming
}

macro "Qualify ROI [6]" {
   k1000 = 1000;
   xValues = newArray(k1000);
   yValues = newArray(k1000);
   for (jj = 0; jj <k1000; jj++){
      noise = pow(random- 0.5, 3) * 20;
      xValues[jj] = jj/100;               
      yValues[jj] = sqrt(jj)/5 + noise;
   }
   Plot.create("Qualify Roi", "X", "Y");
   Plot.setFrameSize(500, 300);
   Plot.setLimits(0, 10, 0, 10 );
   Plot.setColor("blue");
   Plot.add("dots", xValues, yValues); 
   Plot.show;
   setTool("Freehand");
   waitForUser("Create ROI for qualifying some dots, then click OK");
   if (selectionType == -1) exit ("No Selection found");

   qualifiedX = newArray(k1000);
   qualifiedY = newArray(k1000);
   q = 0;
   for (jj = 0; jj <k1000; jj++){
      x = xValues[jj];
      y = yValues[jj];
      toUnscaled(x, y);
      if (selectionContains(x, y)){
         qualifiedX[q] = xValues[jj];
         qualifiedY[q++] = yValues[jj];
      }
   }
   qualifiedX = Array.trim(qualifiedX, q);
   qualifiedY = Array.trim(qualifiedY, q);

   Plot.create("Qualify Roi", "X", "Y");
   Plot.setFrameSize(500, 300);
   Plot.setLimits(0, 10, 0, 10 );
   Plot.setColor("blue");
   Plot.add("dots", xValues, yValues); 
   Plot.setColor("red");
   Plot.add("circles", qualifiedX, qualifiedY); 
   Plot.update;   
}



//Creates a stack of frozen plots
//(Use slider to change one variable)
//Author: Norbert Vischer
//also available from menu Help>Examples>Macros

macro "Dynamic Plot [7]" {
   left = 0;
   right = 4;
   bottom = 0;
   top = 1.6;
   nPoints = 50;
   range = right - left;
   Plot.create("Dynamic Plot", "X", "Y");
   Plot.setLimits(left, right, bottom, top );
   Plot.setFrameSize(800, 500 );
   Plot.setFontSize(18);  
   xValues = newArray(nPoints);
   yValues1 = newArray(nPoints);
   yValues2 = newArray(nPoints);
   yValues3 = newArray(nPoints);
   sigma = 0.4; ampl = 1;   x0 = 2;
   for(dx = -2; dx < 2; dx += 0.05){
      for (p = 0; p < nPoints; p++){
         x = p/nPoints * range + left;
         y1 = ampl * exp(-pow(x - x0, 2)/(sigma * sigma * 2));
         y2 = 0.5 * ampl * exp(-pow(x -dx - x0, 2)/(sigma * sigma * 2));
         xValues[p] = x;
         yValues1[p] = y1;
         yValues2[p] = y2;
         yValues3[p] = y1 + y2;
      }
      Plot.setColor("#ccccff");     
      Plot.add("filled", xValues, yValues3);
      Plot.setLineWidth(2);
      Plot.setColor("green");
      Plot.add("line", xValues, yValues1);
      Plot.setColor("red");
      Plot.add("line", xValues, yValues2);
      Plot.setLineWidth(1);
      txt = "dx = " + d2s(dx, 2);
      Plot.addText(txt, 0.77, 0.1);
      Plot.setLegend("Sum\nGauss1\nGauss2", "top-left");
      Plot.appendToStack;
   }
   Plot.show;
   rename("Sum of Gaussians");
   run("Animation Options...", "speed=10 loop");
   doCommand("Start Animation [\\]");
}



// Creates a virtual hyperstack of frozen plots.
// Use the sliders to change sigma and amplitude.
// Author: Norbert Vischer
//  *Also avalilabe from menu Help>Examples>Macro>

macro "Plot Family 2D [8]"{
   left = 0;
   right = 4;
   bottom = 0;
   top = 1.5;
   nPoints = 100;
   range = right - left;
   x0 = 2;

   Plot.create("Plot Family 2D", "X", "Y");
   Plot.setLimits(left, right, bottom, top );
   Plot.setFrameSize(800, 500); 
   Plot.setFontSize(18);  
   
   numFrames = 0;
   for (sigma = 0.2; sigma <0.6; sigma +=0.03){
      showProgress((sigma - 0.2)/0.4);
      numFrames ++;
      numSlices = 0;
      for (ampl = 1; ampl < 1.5; ampl += 0.03){
         numSlices++;
         xValues = newArray(nPoints);//start building one member
         yValues = newArray(nPoints);
         for (p = 0; p < nPoints; p++) {
            x = p/nPoints * range + left;
            xValues[p] = x;
            yValues[p] = ampl * exp(-pow(x - x0, 2)/(sigma * sigma * 2));
         }
         Plot.setLineWidth(2);
         Plot.setColor("#555555", "#eeeeee");
         Plot.setColor("#ddddff");  
         Plot.add("filled", xValues, yValues);
         Plot.setColor("black");  
         Plot.add("line", xValues, yValues);
         txt = "Sigma: " + d2s(sigma, 2);
         txt += "\nAmplitude: " + d2s(ampl, 2);
         txt += "\n(use sliders to change)";
         Plot.setColor("red");
         Plot.addText(txt, 0.7, 0.1);
         Plot.setLineWidth(1);
         Plot.appendToStack; //end building one member
      }
   }
   Plot.show;
   rename("Adjustable Gaussian");
   run("Stack to Hyperstack...", "slices=&numSlices frames=&numFrames");
}