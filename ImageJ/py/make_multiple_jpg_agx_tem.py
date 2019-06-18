from ij import IJ
from ij.plugin import ImageCalculator
from ij.process import ImageConverter

IJ.run("Close All")

img_dir = "/Users/jrminter/Documents/git/tips/ImageJ/tif"
path_tif = img_dir + "/qm-02424-01-cr.tif"
path_jpg = img_dir + "/qm-02424-01-cr_200_jpg.jpg"
imp_ori = IJ.openImage(path_tif)
IJ.run(imp_ori, "Enhance Contrast", "saturated=0.35")
ImageConverter.setDoScaling(True)
IJ.run(imp_ori, "8-bit", "")
imp_ori.setTitle("AgX grains")
imp_ori.show()
IJ.saveAs(imp_ori, "Jpeg", path_jpg)
for i in range(201):
	imp_jpg =  IJ.openImage(path_jpg)
	IJ.saveAs(imp_jpg, "Jpeg", path_jpg)

IJ.run(imp_jpg, "32-bit", "")
IJ.run(imp_ori, "32-bit", "")

imp_ori.setTitle("TIF")
imp_ori.show()
imp_jpg.setTitle("200 x JPG")
imp_jpg.show()

ic = ImageCalculator()
imp_sub = ic.run("Subtract create 32-bit", imp_jpg, imp_ori)
IJ.run(imp_sub, "Enhance Contrast", "saturated=0.35")
IJ.run(imp_sub, "8-bit", "")
imp_sub.setTitle("subtracted")
imp_sub.show()


