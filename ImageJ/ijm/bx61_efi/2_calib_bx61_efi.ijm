@String(label="Image Directory", style="") img_dir
@String(label="Output Image Base Name", style="") img_base_name
@String(label="microns per pixel",style="") str_um_per_pix
// 2_calib_bx61 _efi.ijm
// 
// Must be run AFTER the EFI button is pressed and run...
selectWindow("Output");
rename(img_base_name + ".tif")
run("Properties...", "channels=1 slices=1 frames=1 unit=microns pixel_width=" + str_um_per_pix + " pixel_height=" + str_um_per_pix + " voxel_depth=1.0");
saveAs("Tiff", img_dir + "/" + img_base_name + ".tif");