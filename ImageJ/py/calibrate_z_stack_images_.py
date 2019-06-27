from ij import IJ;

IJ.run("Close All")

img_dir = "/Users/jrminter/Documents/git/tips/ImageJ/tif/zstack/"

for i in range(0, 23):
	if(i < 9):
		img_name = "Step0%i.tif" % (i + 1)
	else:
		img_name = "Step%i.tif" % (i + 1)

	print(img_name)
	img_path = img_dir + img_name
	imp = IJ.openImage(img_path)
	IJ.run(imp, "Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=0.0147023 pixel_height=0.0147023 voxel_depth=0.0147023")
	IJ.saveAs(imp, "Tiff", img_path)
	imp.close()