"""
test_virtual_stack.py

"""

from ij import IJ, VirtualStack, ImagePlus



IJ.run("Close All")

filtFiles = ["C:\\Users\\jrminter\\Downloads\\images\\spheres-1.tif",
"C:\\Users\\jrminter\\Downloads\\images\\spheres-2.tif",
"C:\\Users\\jrminter\\Downloads\\images\\spheres-3.tif"]
vs = None
for f in filtFiles:
	if vs is None:
		imp = IJ.openImage(f)
		print(imp)
		imp.show()
		vs = VirtualStack(imp.width, imp.height, None, "C:\\Users\\jrminter\\Downloads")
		vs.addSlice(f)
		
imPlus = ImagePlus("Stack from subdirectories", vs)
print imPlus
imPlus.show()