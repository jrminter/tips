@String(label="Output Directory", style="") out_dir
@String(label="Output File", style="") out_name
run("Blobs (25K)");
setAutoThreshold("Default");
//run("Threshold...");
//setThreshold(126, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Close");
run("Set Measurements...", "area mean perimeter shape display add redirect=None decimal=3");
run("Watershed");
run("Analyze Particles...", "display exclude clear add");
out_path = out_dir + "/blob_results.csv";
saveAs("Results", out_path + out_name + ".csv");
