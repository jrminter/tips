imp = IJ.openImage("http://wsr.imagej.net/images/Dot_Blot.jpg");
ip = imp.getProcessor();
ip.invert();
prominence = 35;
excludeOnEdge=false;
polygon = new MaximumFinder().getMaxima(ip, prominence, excludeOnEdge);
print("npoints="+polygon.npoints);
imp_proc = ImagePlus("Inverted", ip.invert());
imp_proc.show();
