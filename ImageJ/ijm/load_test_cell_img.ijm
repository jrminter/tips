// @int(label = "Image Number") imgNo
// run("Bio-Formats", "open=[/Users/jrminter/Documents/git/tips/ImageJ/tif/C3-jw-30min 5_c5.tif] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT");
str2 = "open=[/Users/jrminter/Documents/git/tips/ImageJ/tif/C3-jw-30min " + imgNo + "_c5.tif] autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT";
run("Bio-Formats", str2);
run("Grays");
