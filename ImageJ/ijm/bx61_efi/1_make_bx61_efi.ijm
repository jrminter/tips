@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") base_name
@String(label="Image Extension",style="") img_ext
@String(label="microns per pixel",style="") str_um_per_pix
@Integer(label="Number of images") num_images

// 1_make_bx61_efi.ijm
//
// load images for an extended depth of field analysis
// Do **not** use bioformats... 
// Make a stack and run Extended Depth of Field (Easy mode)...
// User must press "Run"
// 
// I could not get the scale to work from a parameter so hard coded it...
run("Close All");
for (i=1; i<(num_images+1); i++) {
	if(i < 10){
		img_name = base_name + "0" + i;
		}
	if(i > 9){
		img_name = base_name + i;
	}

	img_path = img_dir + "/" + img_name + img_ext;
	// print(img_path);

	str2 = img_dir + "/" + img_name + img_ext;
    open(str2);
    run("Properties...", "channels=1 slices=1 frames=1 unit=microns pixel_width=" + str_um_per_pix + " pixel_height=" + str_um_per_pix + " voxel_depth=1.0");
    
}
run("Images to Stack", "name=Stack title=[] use");
selectWindow("Stack");
run("Properties...", "channels=1 slices=1 frames=" + num_images + " unit=microns pixel_width=" + str_um_per_pix + " pixel_height=" + str_um_per_pix + " voxel_depth=1.0");
run("Extended Depth of Field (Easy mode)...");


