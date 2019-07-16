"""
binarize_upper_lower_threshold.py

From:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

Date        Who  What
----------  ---  ---------------------------------------------------
2019-07-15  JRM  Interesting but not sure how useful this will be...


"""
# an example with lower and upper threshold values, 100 and 125.
from ij import IJ, ImagePlus
from ij.process import ImageProcessor
from ij.plugin.filter import ThresholdToSelection

def binarize_upper_lower_threshold(imp, thr_low, thr_hi):
	"""
	binarize_upper_lower_threshold

	Binarize an image using an upper & lower threshold
	Adapted from the python_imagej_cookbook
	"""
	imp.getProcessor().setThreshold(thr_low, thr_hi, ImageProcessor.NO_LUT_UPDATE)
	roi = ThresholdToSelection.run(imp)
	imp.setRoi(roi)
	imp_mask = ImagePlus("Mask", imp.getMask())
	# maskimp.show() # comment out for headless
	return(imp_mask)


imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp_mask = binarize_upper_lower_threshold(imp, 100, 125)
imp_mask.show()
imp.show()

	