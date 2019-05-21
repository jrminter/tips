// @int(label = "Minimum size px") minSize

// setBatchMode(true); // This stops windows from opening! Streamined code... Comment in/out

originalImageID = getImageID();
run("Duplicate...", " "); // note the space between 2 quotes...


run("Gaussian Blur...", "sigma=2");
//run("Threshold...");
setAutoThreshold("Default dark");
run("Create Mask");
run("Watershed");
run("Analyze Particles...", "size=" + minSize + "-Infinity exclude add");

run("Clear Results"); // get rid of previous results...
selectImage(originalImageID); // get the one we want...
roiManager("show all with labels"); // (29:02)
roiManager("Deselect"); // Start clean
roiManager("Measure"); // (29:42)


