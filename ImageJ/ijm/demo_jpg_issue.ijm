// load Boats
run("Close All");
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/POL-4455-16bit-Img01-bks.tif");
makeRectangle(200, 200, 512, 512);
run("Crop");
run("8-bit");
rename("OrigTif");
setOption("ScaleConversions", true);
saveAs("Tiff", "/Users/jrminter/Documents/git/tips/ImageJ/tif/orig_tif.tif");
rename("OrigTif");
run("Duplicate...", " ");
rename("JPEG");
run("Save As JPEG... [j]", "jpeg=85")
run("Close");
open("/Users/jrminter/Documents/git/tips/ImageJ/tif/JPEG.jpg");
rename("JPEG");
imageCalculator("Subtract create 32-bit", "OrigTif","JPEG");



run("Boats (356K)");
// run("Out [-]");
rename("Original");

// convert to JPEG
run("Duplicate...", " ");
rename("JPEG");
// run("Out [-]");
run("Save As JPEG... [j]", "jpeg=85");
run("Close");
open("/Users/jrminter/Documents/git/tips/ImageJ/jpg/JPEG.jpg");
rename("JPEG");
// run("Revert");
// rename("JPEG");
 
// compute the difference
imageCalculator("Subtract create 32-bit", "Original","JPEG");
run("Out [-]");
rename("Difference");
 
// display windows side by side
run("Tile");
 
// highlight artifacts using Glasbey LUT
selectWindow("Original");
run("glasbey");
selectWindow("JPEG");
run("glasbey");
selectWindow("Difference");