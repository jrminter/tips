// This script demonstrates the 12 types of graphs supported
// by the Plot class. Requires ImageJ 1.52h or later.

  n = 50;
  img = IJ.createImage("", "32-bit noise", n, 1, 1);
  ip = img.getProcessor();
  ip.blurGaussian(3);
  stats = ip.getStats();
  ip.add(-stats.min);
  ypoints = ip.getLine(0, 0, n, 0);
  plot = new Plot("Graph Types", "X", "Y");
  plot.setColor("red", "red");
  plot.setLineWidth(2);
  plot.setFont(new Font("SansSerif",Font.PLAIN,16));
  plot.add("line", ypoints);
  plot.addLegend("Data Points");
  plot.show();
  types = plot.getTypes();
  for (i=0; i<types.length; i++) {
     plot.setType(0, types[i]);
     plot.setLegend("\""+types[i]+"\"", Plot.TOP_RIGHT);
     IJ.wait(2000);
  }
  for (i=0; i<ypoints.length; i++)
     ypoints[i] = ypoints[i]/4;
  plot.setLimits(Double,NaN, -0.1, stats.max-stats.min+0.4)
  plot.add("error bars", ypoints);
  plot.setType(0, types[0]);
  plot.setLegend("\"Error Bars\"", Plot.TOP_RIGHT);