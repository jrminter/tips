@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") base_name
@String(label="Image Extension",style="") img_ext
@Integer(label="Number of images") num_images

// load_images.ijm
// load images for an extended depth of field analysis

// img_dir = "/Users/jrminter/dat/images/key-test/efi-test/50X-1";
// base_name = "Step";
// img_ext = ".tif";
// num_images = 21
for (i=1; i<(num_images+1); i++) {
	if(i < 10){
		img_name = base_name + "0" + i;
		}
	if(i > 9){
		img_name = base_name + i;
	}

	img_path = img_dir + "/" + img_name + img_ext;
	print(img_path);
}
