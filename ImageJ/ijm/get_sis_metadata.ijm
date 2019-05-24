@String(label="Base Image Title", style="") str_img_nam
@String(label="Base Directory", style="") str_dir
run("Close All");
str_img_ext = ".tif";
run_str2 = "open=" + str_dir + "/" + str_img_nam + str_img_ext + " autoscale color_mode=Default display_metadata rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT";
run("Bio-Formats", run_str2);
str_win_name = "Original Metadata - " + str_img_nam + str_img_ext;
selectWindow(str_win_name);
sav_str2 = str_dir + "/" + str_img_nam + "_orig_metadata.csv";
saveAs("Text", sav_str2);
run("Close All");