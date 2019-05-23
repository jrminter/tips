// set minimum area to detect (in sq. px.)
min_area = "200";
str_ana_2 = "size=" + min_area + "-Infinity exclude add";
run("Close All");
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/blobs/blobs.tif");
run("Duplicate...", "title=blobs");
setAutoThreshold("Default light");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Watershed");
run("Set Measurements...", "area mean min centroid center perimeter fit shape feret's display add redirect=None decimal=3");
run("Analyze Particles...", str_ana_2);
selectWindow("blobs.tif");
roiManager("Show All with labels");

