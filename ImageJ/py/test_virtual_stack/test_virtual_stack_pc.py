"""
test_virtual_stack_pc.py

"""

from ij import IJ, VirtualStack, ImagePlus
import os

git_home = os.getenv("GIT_HOME")

img_dir = git_home + "/tips/ImageJ/py/test_virtual_stack/"
print(img_dir)


IJ.run("Close All")


filtFiles = ["spheres-1.tif", "spheres-2.tif", "spheres-3.tif"]
vs = None
for f in filtFiles:
	if vs is None:
		path = img_dir + f
		imp = IJ.openImage(path)
		print(imp)
		imp.show()
		#                                               nothing works here...
		vs = VirtualStack(imp.width, imp.height, None, "C:\\Temp\\vs.tif")
		vs.addSlice(path)
	else:
		path = img_dir + f
		vs.addSlice(path)
		
imPlus = ImagePlus("Stack from subdirectories", vs)
print imPlus
imPlus.show()