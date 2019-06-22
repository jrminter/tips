"""
ana_part_wrapper_funcs.py

A proof-of concept example using wrapper functions for three
common particle analysis functions:
1. close_open_non_image_window - close open non-image windows
                                 using their titles
                                 
2. shorten_title - change the title of an image to the short version

3. binarize_image - binarize a specified ImagePlus given the threshold
                    string and the black background Boolean

The main function resets the Results table after detecting particles using
the binarized image, draws the ROIs on the input image, and measures
the results.

Date        Who  What
----------  ---  -----------------------------------------------
2019-06-21  JRM  Initial Prototype

"""

from ij import IJ, Prefs, WindowManager
from ij.plugin.frame import RoiManager
from ij.measure import ResultsTable

def close_open_non_image_window(str):
	"""
	close_open_non_image_window(str)

	Close the specified non-image window
	if it exists

	Parameters
	==========
	str:    String
	        The window name to close
    """
	arry = WindowManager.getNonImageTitles()
	for elem in arry:
		if(elem == str):
			IJ.selectWindow(str)
			IJ.run("Close")

def shorten_title(imp):
	"""
	shorten_title(imp)

	Shorten the title on an image and return the
	ImagePlus with the shortened title
	"""
	ti = imp.getShortTitle()
	imp.setTitle(ti)
	return(imp)

def binarize_image(imp_in, str_thr, black_bkg):
	"""
	binarize_image

	Parameters
	----------
	imp_in:		ImagePlus
			The ImagePlus to binarize
	str_thr		String
			The threshold string. Example: "Default"
	black_bkg:	Boolean
			Whether the background is black (True) or not (False)

	Returns
	-------
	imp_out		ImagePlus
			The binarized image
	"""
	imp_out = imp_in.duplicate()
	ti = imp.getShortTitle()
	imp_out.setTitle(ti + "_bin")
	IJ.setAutoThreshold(imp_out, str_thr)
	Prefs.blackBackground = black_bkg
	IJ.run(imp_out, "Make Binary", "")
	IJ.run(imp_out, "Convert to Mask", "")
	return(imp_out)



# start clean
IJ.run("Close All") # gets open images...
close_open_non_image_window("Results")
close_open_non_image_window("ROI Manager")

# load input image
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp = shorten_title(imp)	
imp.show()

# binarize and watershed
imp_det = binarize_image(imp, "Default", False)
IJ.run(imp_det, "Watershed", "")
imp_det.show()

# setup measurements. Note the use of scientific notation.
IJ.run("Set Measurements...", "area mean centroid perimeter shape integrated display scientific add redirect=None decimal=3")
IJ.run(imp_det, "Analyze Particles...", "size=40-Infinity circularity=0.3-1.00 show=Overlay display exclude clear add")

# prepare the ROI manager & Results table to measure
# from the Original Image
rm = RoiManager.getInstance()
rt = ResultsTable.getResultsTable()
rt.reset()
rm.runCommand(imp,"Show All with labels")
rm.runCommand(imp,"Measure")
imp.show()






