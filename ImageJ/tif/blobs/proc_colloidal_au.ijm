min_area = "200";
min_circ = "0.7";
imgDir = "/Users/jrminter/Documents/git/tips/ImageJ/tif/blobs/";
imgNam = "10nm-colloidal-gold-1-no-sb.tif"
imgPat = imgDir + imgNam;

str_ana_2 = "size=" + min_area + "-Infinity pixel circularity=" + min_circ + "-1.00 exclude add";
run("Close All");
open(imgPat);
selectWindow("10nm-colloidal-gold-1-no-sb.tif");
rename("original");
run("Duplicate...", "title=work");
selectWindow("work");

run("Gaussian Blur...", "sigma=.3 scaled");
setAutoThreshold("Default light");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Watershed");
run("Set Measurements...", "area mean min centroid center perimeter fit shape feret's display add redirect=None decimal=3");
run("Analyze Particles...", str_ana_2);
selectWindow("original");
roiManager("Show All with labels");
selectWindow("ROI Manager");
roiManager("Deselect");
roiManager("Measure");
