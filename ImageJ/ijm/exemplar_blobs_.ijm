@String(label="Lower Area [px]", style="") str_min_area
run("Close All");
run("Blobs (25K)");
setAutoThreshold("Default");
//setThreshold(126, 255);
run("Convert to Mask");
run("Set Measurements...", "area mean modal min center perimeter bounding fit shape feret's display redirect=None decimal=3");
run("Analyze Particles...", "size="+ str_min_area +"-Infinity display exclude clear include add");
saveAs("Results", "/Users/jrminter/Desktop/Results.tsv");