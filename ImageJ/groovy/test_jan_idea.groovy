#@ RoiManager rm
#@ ResultsTable rt
// start with imports
import ij.*
import ij.plugin.*

def fix_inverted_lut(imp){
	/* fix_inverted_lut(imp)
	 *  
	 *  Convert an image with an inverted LUT to a standard
	 *  8-bit grayscale image
	 *  
	 *  Parameters
	 *  ==========
	 *  imp		ImagePlus
	 *  	The 8 bit grayscale image with the inverted LUT
	 *  
	 *  Returns
	 *  =======
	 *  imp_new	ImagePlus
	 *  	The image with a standard 8-bit image w a gray LUT
	 * 
	 *
	 */
	title = imp.getTitle()
	imp_new = new Duplicator().run(imp)
	IJ.run(imp_new, "Grays", "")
	IJ.run(imp_new, "Invert", "")
	imp_new.setTitle(title)
	imp_new.show()
	return imp_new
}
IJ.run("Close All")
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp = fix_inverted_lut(imp)
imp_new = new Duplicator().run(imp)
imp_new.setTitle("work")
IJ.run(imp_new, "Auto Threshold", "method=Default")
IJ.run(imp_new, "Watershed", "")
imp_new.show()
IJ.run("Set Measurements...", "area mean modal min centroid center perimeter bounding fit shape display redirect=None decimal=3")
IJ.run(imp_new, "Analyze Particles...", "size=100-100000 circularity=0.50-1.00 show=Overlay display exclude clear add")
rt.show("Results")
rm.show()
rm.moveRoisToOverlay(imp)
imp2 = imp.flatten()
imp2.show()
IJ.saveAs(imp2, "PNG", "/Users/jrminter/Desktop/blobs-segmented.png")
IJ.saveAs("Results", "/Users/jrminter/Desktop/blobs-results.csv")
imp.changes = false
imp.close()
imp2.changes = false
imp2.close()
imp_new.changes = false
imp_new.close()
rt.reset()
rm.reset()
IJ.selectWindow("Results")
IJ.run("Close")
IJ.selectWindow("ROI Manager")
IJ.run("Close")
