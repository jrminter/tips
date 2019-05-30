
// mac
// "open=/Users/jrminter/Documents/git/tips/ImageJ/dm3/EN-SPS-20060001-01.dm3 autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT"
//
// pc
//

str_sat = "0.25";
img_dir = "/Users/jrminter/Documents/git/tips/ImageJ/dm3";
img_nam = "EN-SPS-20060001-01";
img_ext = ".dm3";
txt = "open=";
aft_img = " autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT";
min_size = "0.0000032"; // sq um -> 
min_circ = "0.50";


str_bf2 = txt + img_dir + "/" + img_nam + img_ext + aft_img;
//print(str2)
run("Close All");
run("Bio-Formats", str_bf2);
run("Enhance Contrast", "saturated=" + str_sat);
selectWindow(img_nam+img_ext);
run("Duplicate...", "title=work");
run("Median...", "radius=10");
setAutoThreshold("Default");
run("Make Binary");
run("Convert to Mask");
run("Watershed");
run("Convert to Mask");
run("Set Measurements...", "area center perimeter fit shape feret's display add redirect=None decimal=3");
ap_str2 = "size=" + min_size + "-Infinity circularity=" + min_circ + "-1.00 show=Overlay display exclude add in_situ";
run("Analyze Particles...", ap_str2);
selectWindow(img_nam + img_ext);
roiManager("Deselect");
roiManager("Show All with labels");
