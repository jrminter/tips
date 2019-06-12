/*
 * Process VueScan image
 * 
 * From Wayne Rasband 2019-06-10
 * 
 * https://forum.image.sc/t/create-tif-with-4-channels-per-pixel/26457/10
 * 
 * He notes: 
 * ...the following JavaScript code opens the RGBA demo image, displays each of the
 * four channels and saves it as a tiff stack. It is unlikely that VueScan can open
 * tiff stacks created by ImageJ and ImageJ is not able to save in RGBA tiff format.
 * 
 */
importClass(Packages.ij.IJ)
importClass(Packages.ij.ImagePlus)
importClass(Packages.ij.VirtualStack)
importClass(java.io.File)

dir = "C:/Users/jrminter/Documents/git/tips/ImageJ/tif/"
fi = "VS_demo.tif"
path = dir + fi
img = IJ.openImage(path) 

img.setDisplayMode(IJ.COLOR)

img.show()

for (i=1;i<=img.getStackSize(); i++) {
	img.setSlice(i)
	IJ.wait(1000)
}

IJ.saveAs(img, dir+"VS_demo2.tif")