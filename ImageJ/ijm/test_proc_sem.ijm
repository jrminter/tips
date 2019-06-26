@String(label="Image Directory", style="") img_dir
path = img_dir + "/001_003_5_11.tif";

open(path);
makeRectangle(0, 0, 1024, 661);
run("Crop");
setAutoThreshold("Default");
//run("Threshold...");
//setThreshold(0, 52);
setOption("BlackBackground", false);
run("Convert to Mask");
// run("Close");
