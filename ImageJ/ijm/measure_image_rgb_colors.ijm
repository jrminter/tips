// Measure colors from image
// and find color name.
//
// Starting with original image
// and crop. This makes a difference
// on output. A color swatch would
// be better
//
// Based on this tweet:
// https://twitter.com/CreatorsProject/status/869931844388741120
//
// Sensitive on how one crops the image
//
// Macro by J.R. Minter 2019-04-26
//
run("Close All");
open("/Users/jrminter/Documents/git/OSImageAnalysis/ImageJ/name-that-color/start_image.jpg");
run("Set Measurements...", "mean display redirect=None decimal=3");
selectWindow("start_image.jpg");
makeRectangle(457, 148, 294, 327);
run("Crop");
rename("cropped");
run("Split Channels");
selectWindow("cropped (green)");
rename("green");
selectWindow("cropped (red)");
rename("red");
selectWindow("cropped (blue)");
rename("blue");
selectWindow("red");
run("Measure");
selectWindow("green");
run("Measure");
selectWindow("blue");
run("Measure");
// RGB (22, 48, 155 ) = hex #16309B
// http://chir.ag/projects/name-that-color/#16309B "Torea Bay"