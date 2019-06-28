from ij import IJ

img_dir = "/Volumes/Data/images/key-test/other/clin-sem-2008-06-23/"
img_nam = "96-01"
img_ext = ".tif" 
img_path = img_dir + img_nam + img_ext


IJ.run("Close All")
print(img_path)

imp = IJ.openImage(img_path)
imp.show()
IJ.run(imp, "Median...", "radius=2");
IJ.setAutoThreshold(imp, "Triangle dark");
IJ.run("Make Binary")
IJ.run("Convert to Mask")
IJ.run(imp, "Watershed", "")
imp.show()
# Not a good segmentation...

