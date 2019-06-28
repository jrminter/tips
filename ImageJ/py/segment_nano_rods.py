from ij import IJ
import os

git_home = os.getenv("GIT_HOME")
img_name = "test-nanorods.tif"

img_dir = git_home + "/tips/ImageJ/tif/"
img_path = img_dir + img_name
print(img_path)

IJ.run("Close All")
imp = IJ.openImage(img_path)
imp.show()

imp_work = imp.duplicate();
IJ.setAutoThreshold(imp_work, "Otsu")
imp_work.show()
IJ.run("Make Binary")
IJ.run("Convert to Mask")
imp_work.show()

# cannot get a watershed to work