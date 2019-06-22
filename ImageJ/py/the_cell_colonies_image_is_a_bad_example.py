"""
the_cell_colonies_image_is_a_bad_example.py

This is an example segmenting the "Cell Colony" Image.
That image is a disgrace to image processing. The magnification
needed to be much higher to get reliable measurement.
To make matters worse, the image is in jpeg format...

Blobs is MUCH better.

Date        Who  What
----------  ---  -----------------------------------------------
2019-06-22  JRM  Initial prototype.


"""
from ij import IJ, Prefs, WindowManager
from ij.plugin import Duplicator
from ij.plugin.frame import RoiManager
from ij.measure import ResultsTable

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


IJ.run("Close All")

offset = 70
imp = IJ.openImage("http://imagej.nih.gov/ij/images/Cell_Colony.jpg")
imp.setRoi(offset, offset,256, 256)
IJ.run(imp, "Crop", "")
imp.setTitle("cropped_cell_colonies")
imp.show()
imp_det = binarize_image(imp, "Default", False)

# setup measurements. Note the use of scientific notation.
IJ.run("Set Measurements...", "area mean centroid perimeter shape integrated display scientific add redirect=None decimal=3")
IJ.run(imp_det, "Analyze Particles...", "size=5-Infinity circularity=0.1-1.00 show=Overlay display exclude clear add")
rm = RoiManager.getInstance()
rt = ResultsTable.getResultsTable()
rt.reset()
rm.runCommand(imp,"Show All with labels")
rm.runCommand(imp,"Measure")
imp.show()
imp_det.show()

n = rm.getCount()
for i in range(0, n):
	rm.select(i)
	IJ.run("Enlarge...", "enlarge=2")
	rm.runCommand("Update")
	rm.select(i)
	rm.runCommand("Measure")