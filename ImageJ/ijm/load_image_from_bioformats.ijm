@String(label="Directory",style="") str_directory
@String(label="Image Name",style="") str_img_name
@String(label="Image Extension",style="") str_img_ext
//
// load image using bioformats
// 2019-05-31 J. R. Minter
//
// print(str_directory + "/" + str_img_name + str_img_ext);
//
str2 = "open=" + str_directory + "/" + str_img_name + str_img_ext + " autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT";
run("Bio-Formats", str2);