// From Wayne Rasband

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