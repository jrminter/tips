importClass(Packages.ij.IJ);
importClass(Packages.ij.plugin.filter.MaximumFinder);

// This makes little sense to me...

imp = IJ.openImage("http://wsr.imagej.net/images/Dot_Blot.jpg");
ip = imp.getProcessor();
ip.invert();
prominence = 35;
excludeOnEdge=false;
polygon = new MaximumFinder().getMaxima(ip, prominence, excludeOnEdge);
print("npoints="+polygon.npoints);
x_vals = polygon.xpoints;
y_vals = polygon.xpoints;
imp.show();
// print(x_vals);
// print(y_vals);