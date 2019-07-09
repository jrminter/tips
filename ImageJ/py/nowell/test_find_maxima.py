from ij import IJ

imp = IJ.openImage("/Users/jrminter/Downloads/Fiji Manual Resources/Demo Images/Widefield Images/Segmentation/Nuclei.tif");
IJ.run(imp, "Find Maxima...", "prominence=400 exclude output=[Segmented Particles]");
