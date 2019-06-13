// load Boats
run("Bridge (174K)");
run("Out [-]");
rename("Original");
 
// convert to JPEG
run("Duplicate...", " ");
run("Out [-]");
run("Save As JPEG... [j]", "jpeg=85");
run("Revert");
rename("JPEG");
 
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