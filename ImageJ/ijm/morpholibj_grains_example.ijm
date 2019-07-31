#@ String (label="Image directory", description="image dir") img_dir
// start clean
run("Close All");
open(img_dir + "/C_5000X_COMP_cal.tif");
// run the plugin
run("Morphological Segmentation");
// wait for the plugin to load
wait(1000);
call("inra.ijpb.plugins.MorphologicalSegmentation.setInputImageType", "object");
call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientRadius", "2");
call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientType", "Morphological");
call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=20.0", "calculateDams=true", "connectivity=4");
call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Watershed lines");
call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");

