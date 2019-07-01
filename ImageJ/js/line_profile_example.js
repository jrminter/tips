importClass(Packages.ij.IJ);
importClass(Packages.ij.gui.Line);
importClass(Packages.ij.plugin.ChannelSplitter);

IJ.run("Close All");
imp = IJ.openImage("/Users/jrminter/Downloads/blue_gradient.jpeg");
IJ.run(imp, "Line Width...", "line=60");
channels = ChannelSplitter.split(imp);
imp_blue = channels[2]
imp_blue.setRoi(new Line(0,52,420,48));
IJ.run(imp_blue, "Plot Profile", "");
imp_blue.show();
