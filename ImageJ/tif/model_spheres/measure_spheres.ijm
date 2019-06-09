run("Close All")
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/model-spheres/spheres-3.tif");
run("8-bit");
run("Properties...", "channels=1 slices=1 frames=1 unit=px pixel_width=1 pixel_height=1 voxel_depth=1");
setAutoThreshold("Default");
//run("Threshold...");
//setThreshold(0, 148);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Watershed");
run("Set Measurements...", "area mean perimeter shape display redirect=None decimal=3");
run("Analyze Particles...", "size=20-Infinity pixel circularity=0.70-1.00 show=Outlines display exclude clear add");


