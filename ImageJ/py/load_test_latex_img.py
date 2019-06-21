import os
from ij import IJ, WindowManager

img_dir = "/Users/jrminter/Documents/git/tips/ImageJ/tif"
img_fil = "test.tif"

img_path = img_dir + "/" + img_fil

IJ.run("Close All")
imp = IJ.openImage(img_path)
imp.setTitle("latex")
imp.show()