from ij import IJ
from ij.plugin import ImageCalculator
IJ.run("Close All")
path_tif = "/Users/jrminter/Documents/git/tips/ImageJ/tif/lena-eyes.tif"
path_jpg = "/Users/jrminter/Documents/git/tips/ImageJ/jpg/lena-eyes.jpg"
lena_tif = IJ.openImage(path_tif)
lena_tif.show()
IJ.saveAs(lena_tif, "Jpeg", path_jpg)
for i in range(201):
	lena_jpg =  IJ.openImage(path_jpg)
	IJ.saveAs(lena_jpg, "Jpeg", path_jpg)

IJ.run(lena_jpg, "32-bit", "")
IJ.run(lena_tif, "32-bit", "")

lena_tif.show()
lena_jpg.show()

ic = ImageCalculator()
imp_sub = ic.run("Subtract create 32-bit", lena_jpg, lena_tif)
IJ.run(imp_sub, "Enhance Contrast", "saturated=0.35")
IJ.run(imp_sub, "8-bit", "")
imp_sub.show()