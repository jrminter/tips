@String(label="Image Directory", style="") img_dir
path = img_dir + "/001_003_5_11.tif";
run("Close All");
open(path);
makeRectangle(0, 0, 1024, 661);
run("Crop");
setAutoThreshold("Intermodes");
getThreshold(lower, upper);
run("Convert to Mask");

