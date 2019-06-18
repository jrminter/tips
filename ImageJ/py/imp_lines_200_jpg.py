from ij import IJ
from ij.plugin import ImageCalculator
from ij.process import ImageConverter
IJ.run("Close All")

img_dir = "/Users/jrminter/Documents/git/tips/ImageJ/tif"
path_tif = img_dir + "/qm-05131-cd1435I-2-102.tif"
path_jpg = img_dir + "/sem_lines_200_jpg.jpg"

print(path_tif)

imp_ori = IJ.openImage(path_tif)
imp_ori.show()
imp_ori.setRoi(373,164,600,300)
IJ.run("Crop")
IJ.run(imp_ori, "Enhance Contrast", "saturated=0.35")
imp_ori.show()
ImageConverter.setDoScaling(True)
IJ.run(imp_ori, "8-bit", "")
imp_ori.setTitle("SEM lines")
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
