"""
auto_threshold_wrapper.py

A test script to work out an autothreshold jython function

I find the ImageJ Autothresholding to be somewhat convoluted.
The plan is to generate a good wrapper function. I'm tired of
dealing with this in every script....

Date        Who  What
---------   ---  ---
2019-07-09  JRM  Initial protptype

"""
from fiji.threshold import Auto_Threshold
from ij import IJ, WindowManager
from ij.process import ImageProcessor, ImageConverter
from ij.plugin.filter import EDM
from ij.process.AutoThresholder import Method
import os
import jmFijiGen as jmg

def auto_threshold(imp_in, str_thresh, bScale=False):
	"""
	auto_threshold_otsu(imp_in, str_thresh="Otsu", bScale=True)

	Compute an autothreshold for an image. Adapted from
	http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

	Parameters
	----------
	imp_in		ImagePlus
		The image to threshold

	str_thresh	String (Default: Default)
		The threshold: Otsu, Huang, IsoData, Intermodes, Li,
		MaxEntropy, Mean, MinError, Minimum, Moments, Percentile,
		RenyiEntropy, Shanbhag, Triangle, Yen, or Default

	bScale		Boolean (Default: False)

	Return
	------
	imp_out		ImagePlus
		The binary image
	thr_val		integer
		The threshold value
	
	"""
	ti = imp_in.getShortTitle()
	imp = imp_in.duplicate()
	hist = imp.getProcessor().getHistogram()
	if (str_thresh == "Otsu"):
		lowTH = Auto_Threshold.Otsu(hist)
	elif (str_thresh == "Huang"):
		lowTH = Auto_Threshold.Huang(hist)
	elif (str_thresh == "Intermodes"):
		lowTH = Auto_Threshold.Intermodes(hist)
	elif (str_thresh == "IsoData"):
		lowTH = Auto_Threshold.IsoData(hist)
	elif (str_thresh == "Li"):
		lowTH = Auto_Threshold.Li(hist)
	elif (str_thresh == "MaxEntropy"):
		lowTH = Auto_Threshold.MaxEntropy(hist)
	elif (str_thresh == "Mean"):
		lowTH = Auto_Threshold.Mean(hist)
	elif (str_thresh == "MinError"):
		lowTH = Auto_Threshold.MinError(hist)
	elif (str_thresh == "Minimum"):
		lowTH = Auto_Threshold.Minimum(hist)
	elif (str_thresh == "Moments"):
		lowTH = Auto_Threshold.Moments(hist)
	elif (str_thresh == "Percentile"):
		lowTH = Auto_Threshold.Percentile(hist)
	elif (str_thresh == "RenyiEntropy"):
		lowTH = Auto_Threshold.RenyiEntropy(hist)
	elif (str_thresh == "Shanbhag"):
		lowTH = Auto_Threshold.Shanbhag(hist)
	elif (str_thresh == "Triangle"):
		lowTH = Auto_Threshold.Triangle(hist)
	elif (str_thresh == "Yen"):
		lowTH = Auto_Threshold.Yen(hist)
	else:
		lowTH = Auto_Threshold.Default(hist)
	
	imp.getProcessor().threshold(lowTH)
	imp.setDisplayRange(0, lowTH+1)
	ImageConverter.setDoScaling(bScale)
	IJ.run(imp, "8-bit", "")
	imp.setDisplayRange(0, 255)
	imp.setTitle(ti + "-bin-"+ str_thresh)
	return([imp,lowTH])



IJ.run("Close All")

git_home = os.getenv('GIT_HOME')
rel_dir = "/tips/ImageJ/tif/"
path = git_home + rel_dir
print(path)

img_path = path + "Nuclei.tif"
imp_ori = IJ.openImage(img_path)
imp_ori.show()

# note: it works from jmFijiGen.py!
ret = jmg.auto_threshold(imp_ori, "Otsu", bScale=False)

IJ.run(ret[0], "Apply LUT", "")
# ret[0].setDisplayRange(0, ret[1]+1)
ret[0].show()

print(ret[1])



