from ij import IJ, WindowManager

IJ.run("Close All")

def close_others():
	IJ.runMacro("close(\"\\\\Others\")")

imp = IJ.createImage("Untitled", "8-bit noise", 512, 512, 1)
imp.show()
IJ.run(imp, "Gaussian Blur...", "sigma=2")
IJ.setAutoThreshold(imp, "Huang dark")
# recorder records useless
# imp2 = imp.duplicate()
# need to add below:
IJ.run("Make Binary")
IJ.run("Convert to Mask")
imp2 = WindowManager.getCurrentImage()
imp2.show()
