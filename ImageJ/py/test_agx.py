# test_agx.py
#
# Test detection of large and small matte beads from an exemplar image
#
#  Modifications
#   Date      Who  Ver                       What
# ----------  --- ------  -------------------------------------------------
# 2019-06-03  JRM 0.1.00  Initial test of image of AgX grains on max

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

import os
import glob
import time
from math import sqrt
from java.awt import Color

from ij import IJ
from ij import ImagePlus
from ij.gui import Overlay, PointRoi
from ij.measure import ResultsTable, Measurements
from ij.plugin.filter import ParticleAnalyzer
from ij.plugin.frame import RoiManager
import jmFijiGen as jmg

def load_img_num(base_dir, base_name, ext, nseq, verb=False):
	"""
	load_img_num(base_dir, base_name, ext, nseq)

	Load an image from a sequence

	Parameters
	==========
	base_dir:	string  The path w/o final '/' for the directory
				Example: /Users/jrminter/dat/images/key-test/AgX/qm-03965-KJL-027/dm3
	base_name:	string	The base name for the image
				Example: qm-03695-KJL-027
	ext:		string	The file extension
				Example: ".dm3"
	nseq:		Integer	The sequence number between 1 and n
				Example: 1
	verb		Boolean	Default - False Whether to print diagnostic info

	Returns
	=======
	imp			ImagePlus for the image
	"""

	if n_seq < 10:
		str_num =   "0%d" % (n_seq)
	else:
		str_num =   "%d" % (n_seq)
		
	img_base = base_nam + "-" + str_num
	img_file = base_nam + "-" + str_num + ".dm3"
	img_path = base_dir + "/" + img_file
	if(verb):
		print(img_path)
	orig = ImagePlus(img_path)
	orig.setTitle(img_base)
	return (orig)

def ana_particles_watershed(imp, strThrMeth="method=Default white", minPx=10, minCirc=0.35, labCol=Color.white, linCol=Color.green, bDebug=False, sl=0.005):
	"""ana_particles_watershed(imp, strThrMeth="method=Default white", minPx=10, minCirc=0.35, labCol=Color.white, linCol=Color.green, bDebug=False, sl=0.005)
	A wrapper function to do particle analysis from an image after a watershed transformation and draw the detected
	features into the overlay of the original image.
	Inputs:
	imp        - the ImagePlus instance that we will process
	strThrMeth - a string specifying the threshold method
	minPx      - the minimum pixels to detect
	minCirc    - the minimum circularity to detect
	labCol     - the color for labels in the overlay (default white)
	linCol     - the color for line/stroke in the overlay (default green)
	bDebug     - a flag (default False) that, if true, keeps the work image open
	sl         - a time (default 0.005) to sleep when adding ROIs to not overload
	
	This adds the detected features to the overlay and returns the result table for
	processing for output.
	"""
	
	title = imp.getTitle()
	shortTitle = imp.getShortTitle()
	typ = imp.getType()
	imp.setTitle(shortTitle)
	imp.show()
	IJ.run(imp,"Duplicate...", "title=work")
	wrk = IJ.getImage()
	# if this is a 16 bit image, convert to 8 bit prior to threshold
	if typ == ImagePlus.GRAY16:
		IJ.run(wrk, "Enhance Contrast", "saturated=0.35")
		IJ.run(wrk, "8-bit", "")
		IJ.run(wrk, "Threshold", strThrMeth)
		IJ.run(wrk, "Watershed", "")
		
	wrk.show()
	strMeas = "area mean modal min center perimeter bounding fit shape feret's display redirect=%s decimal=3" % shortTitle
	IJ.run(wrk, "Set Measurements...", strMeas)
	strAna = "size=%d-Infinity circularity=%g-1.00  exclude clear include add" % (minPx, minCirc)
	IJ.run(wrk, "Analyze Particles...", strAna)
	rt = ResultsTable().getResultsTable()
	rm = RoiManager.getInstance()
	ra = rm.getRoisAsArray()
	# Draw the particles into the overlay of the original
	i=0
	for r in ra:
		i += 1
		rLab = "%d" % i
		r.setName(rLab)
		imp = jmg.addRoiToOverlay(imp, r, labCol=labCol, linCol=linCol)
		# needed to put in sleep here on crunch to let this complete and not overrun buffer
		time.sleep(sl)
		
	# let's put a PointRoi outside the image to get the overlays all the same color
	r = PointRoi(-10, -10)
	imp = jmg.addRoiToOverlay(imp, r, labCol=labCol, linCol=linCol)
	# clear the roi manager and return the results table
	rm.reset()
	rm.close()
	imp.setTitle(title)
	if bDebug == False:
		wrk.changes = False
		wrk.close()
	return r

def ana_particles(imp, minSize, maxSize, minCirc, bHeadless=True):
	"""ana_particles(imp, minSize, maxSize, minCirc, bHeadless=True)
	Analyze particles using a watershed separation. If headless=True, we cannot
	redirect the intensity measurement to the original image because it is never
	displayed. If we display the original, we can and get the mean gray level. We
	may then compute the particle contrast from the measured Izero value for the image.
	No ability here to draw outlines on the original.
	"""
	strName = imp.getShortTitle()
	imp.setTitle("original")
	ret = imp.duplicate()
	ret.setTitle("work")
	IJ.run(ret, "Enhance Contrast", "saturated=0.35")
	IJ.run(ret, "8-bit", "")
	IJ.run(ret, "Threshold", "method=Default white")
	IJ.run(ret, "Watershed", "")
	rt = ResultsTable()
	# strSetMeas = "area mean modal min center perimeter bounding fit shape feret's redirect='original' decimal=3"
	# N.B. redirect will not work without a displayed image, so we cannot use a gray level image
	if bHeadless == True:
		strSetMeas = "area mean modal min center perimeter bounding fit shape feret's decimal=3"
	else:
		imp.show()
		strSetMeas = "area mean modal min center perimeter bounding fit shape feret's redirect='original' decimal=3"
	
	IJ.run("Set Measurements...", strSetMeas)
	# note this does not get passed directly to ParticleAnalyzer, so
	# I did this, saved everything and looked for the measurement value in ~/Library/Preferences/IJ_Prefs.txt
	# measurements=27355
	# meas = Measurements.AREA + Measurements.CIRCULARITY + Measurements.PERIMETER + Measurements.SHAPE_DESCRIPTORS
	# didn't work reliably
	meas = 27355
	pa = ParticleAnalyzer(0, meas, rt, minSize, maxSize, minCirc, 1.0)
	pa.analyze(ret)
	rt.createTableFromImage(ret.getProcessor())
	return [ret, rt]
	


# Test code starts here...

IJ.run("Close All")
b_verbose = True
n_seq = 1
base_dir = "/Users/jrminter/dat/images/key-test/AgX/qm-03965-KJL-027/dm3"
base_nam = "qm-03695-KJL-027"
dm3 = ".dm3"
imp = load_img_num(base_dir, base_nam, dm3, n_seq, verb=False)
imp.show()

[ret, rt] = ana_particles(imp, 100, 10000, 0.5, True)
ret.show()
# does this do it? Yes it does!!!
ret.changes = False
ret.close()
roi = ana_particles_watershed(imp, bDebug=False)
imp.show()
nMeas = rt.getCounter()
print("%d particles detected in image %d" % (nMeas,1) )
nCols = rt.getLastColumn()

if b_verbose == True:
	for j in range(nCols+1):
		print(rt.getColumnHeading(j))


print("Area     = %d" % rt.getColumnIndex("Area"))
print("Mean     = %d" % rt.getColumnIndex("Mean"))
print("Mode     = %d" % rt.getColumnIndex("Mode"))
print("Perim.   = %d" % rt.getColumnIndex("Perim."))
print("Major    = %d" % rt.getColumnIndex("Major"))
print("Minor    = %d" % rt.getColumnIndex("Minor"))
print("Circ     = %d" % rt.getColumnIndex("Circ."))
print("FeretX   = %d" % rt.getColumnIndex("FeretX"))
print("FeretY   = %d" % rt.getColumnIndex("FeretY"))
print("AR       = %d" % rt.getColumnIndex("AR"))
print("Round    = %d" % rt.getColumnIndex("Round"))
print("Solidity = %d" % rt.getColumnIndex("Solidity"))

rt.show("Results")