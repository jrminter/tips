/**
 * jrm_test_analysis_.groovy
 * 
 * Create a particle analysis pipeline using groovy
 * 
 *   Date      Who  What
 * ----------  ---  --------------------------------------------------------------
 * 2019-06-04  JRM  Initial prototype
 *
 *
 */

import ij.IJ
import ij.ImagePlus
// import ij.ImageStack
import ij.Prefs
// import ij.process.ByteProcessor
// import ij.process.ShortProcessor
// import ij.process.FloatProcessor
// import ij.process.FloodFiller
import ij.plugin.Duplicator
import ij.plugin.frame.RoiManager
import ij.measure.ResultsTable
import ij.WindowManager

def default_auto_threshold_black(imp){
	/**
	 * default_auto_threshold_black(imp)
	 * 
	 * Segment the image using the default autothreshold
	 * with a black background
	 * 
	 * Input
	 * ===== 
	 * imp		ImagePlus
	 * 				The input image
	 * 				
	 * Returns
	 * =======
	 * imp_seg	ImagePlus
	 * 				The segmented image
	 */
	 imp_seg = new Duplicator().run(imp)
	 imp_seg.setTitle(imp.getShortTitle() + "_seg")
	 IJ.setAutoThreshold(imp_seg, "Default")
	 IJ.setOption("BlackBackground", true)
	 IJ.run("Convert to Mask");
	 return imp_seg
	 
	
}

def start_clean(){
	/**
	 * start_clean
	 * 
	 * reset the log and close existing images
	 */
	 
	 IJ.log("\\Clear")
	 IJ.run("Close All")
}

def make_duplicate(imp, new_title) {
	/**
	 * make_duplicate(imp, new_title)
	 * 
	 * Make a duplicate image with a title 
	 * 
	 * Input
	 * ===== 
	 * imp		ImagePlus
	 * 				The input image
	 * title	String
	 * 				The title for the output image
	 * 				
	 * Returns
	 * =======
	 * imp_dup	ImagePlus
	 * 				The duplicate imafe
	 */
	imp_dup = new Duplicator().run(imp)
	imp_dup.setTitle(new_title)
	return imp_dup 
}
def fix_inverted_lut(imp){
	/**
	 * fix_inverted_lut(imp)
	 * 
	 * Convert an image with an inverted LUT to a normal image
	 * and return the corrected ImagePlus
	 * 
	 * Input
	 * =====
	 * imp		ImagePlus
	 * 				The input image
	 * 
	 * Returns
	 * =======
	 * imp_new	ImagePlus
	 * 				The corrected image
	 */
	title = imp.getTitle()
	IJ.run("Invert LUT")
	def imp_new = IJ.getImage()
	imp_new.setTitle(title + "_inv_lut")
	IJ.run("Invert")
	imp_new.show()
	return imp_new
}

/*
 * This is the main execution
 */

start_clean()


// Load blobs and get the ImagePlus
IJ.run("Blobs (25K)")
// Request the current image
def imp = IJ.getImage()
imp.setTitle("original")
imp.show()

def dup = make_duplicate(imp, "work")

def wrk = fix_inverted_lut(dup)
wrk.show()

def seg = default_auto_threshold_black(imp)
seg.show()


