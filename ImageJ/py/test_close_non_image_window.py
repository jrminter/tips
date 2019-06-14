from ij import IJ, ImagePlus, WindowManager, Prefs, ImageStack
import jmFijiGen as jmg

IJ.run("Close All")

# load an image and create a Result Window and a ROI Manager
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()
IJ.setAutoThreshold(imp, "Default");
IJ.run("Convert to Mask")
IJ.run(imp, "Analyze Particles...", "display exclude clear add")
    		
jmg.close_open_non_image_window("Results")
jmg.close_open_non_image_window("ROI Manager")
