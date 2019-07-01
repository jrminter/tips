// This script demonstrates the graph styles supported
// by the Plot class. Requires ImageJ 1.52h or later.
// Plot_Styles.js by Wayne Rasband
//
// Date        Who  What
// ----------  ---  ----------------------------------------
// 2019-06-29  WSR  From ImageJ 1.52k 
// 2019-06-29  JRM  added importClass imports to work w Fiji

importClass(Packages.ij.IJ);
importClass(Packages.ij.gui.Plot);
importClass(java.awt.Font);
importClass(java.lang.Double);

n = 50;
img = IJ.createImage("", "32-bit noise", n, 1, 1);
ip = img.getProcessor();
ip.blurGaussian(3);
stats = ip.getStats();
ip.add(-stats.min);
ypoints = ip.getLine(0, 0, n, 0);
plot = new Plot("Plot Styles", "X", "Y");
plot.setFont(new Font("SansSerif",Font.PLAIN,16));
plot.add("line", ypoints);
plot.show();

set("blue,blue,1,Line"); set("blue,blue,2,Line"); set("blue,blue,3,Line");
set("blue,red,1,Connected Circle"); set("blue,red,2,Connected Circle"); set("blue,red,3,Connected Circle");
set("#00aaff,#00aaff,1,Filled"); set("red,#44ccff,3,Filled");
set("#00aaff,#00aaff,1,Bar"); set("red,#44ccff,3,Bar");
set("#00aaff,#00aaff,1,Separated Bar"); set("red,#00aaff,1,Separated Bar");
set("blue,white,1,Circle"); set("blue,white,2,Circle"); set("blue,blue,3,Circle");
set("black,white,1,Box"); set("black,white,2,Box");
set("black,white,2,Triangle");
set("black,white,2,Diamond");
set("black,black,3,Cross");
set("black,black,2,X");
set("black,black,2,Dot"); set("black,black,3,Dot");

for (i=0; i<ypoints.length; i++)
  ypoints[i] = ypoints[i]/4;
plot.setLimits(Double.NaN, Double.NaN, -0.1, stats.max-stats.min+0.4);
plot.setPlotObjectStyle(0, "blue,blue,2,Line");
plot.add("error bars", ypoints);
plot.setLegend("Error Bars", Plot.TOP_RIGHT);

function set(style) {
    plot.setPlotObjectStyle(0, style);
    items = style.split(",");
    color = items[0].equals(items[1])?items[0]:items[0]+"/"+items[1];
    label = items[3]+", "+color+", "+items[2];
    plot.setLegend(label, Plot.TOP_RIGHT);
    IJ.wait(2000); 
}

