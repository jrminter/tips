from ij import IJ, WindowManager

"""
test_nowell_nuclei.py

Trying to script Nowell pp.207-212

Date        Who  What
----------  ---  -------------------------------------------
2019-07-17  JRM  Prototype. Not sure it makes sense...

"""

IJ.run("Close All")

imp = IJ.openImage("/Users/jrminter/Downloads/Fiji Manual Resources/Demo Images/Widefield Images/Segmentation/Nuclei.tif")
imp.show()
IJ.setAutoThreshold(imp, "Default")
IJ.run("Make Binary")
IJ.run("Convert to Mask")
IJ.run(imp, "Watershed", "")
IJ.run(imp, "Options...", "iterations=1 count=1 black edm=16-bit do=Nothing")
IJ.run(imp, "Invert", "")
IJ.run(imp, "Distance Map", "")

edm = WindowManager.getImage("EDM of Nuclei")
edm.show()
# IJ.run(edm, "8-bit", "")
IJ.run(edm, "16_colors", "")
IJ.run(edm, "Apply LUT", "")
edm.updateAndRepaintWindow()
IJ.setAutoThreshold(edm, "Default light")
IJ.setRawThreshold(edm, 1, 65535, None)
edm.show()
IJ.run(edm, "Measure", "")
