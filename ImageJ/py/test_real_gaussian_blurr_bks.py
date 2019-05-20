"""
test_real_gaussian_blur_bks.py

  Modifications
  Date      Who  Ver                       What
----------  --- ------  -------------------------------------------------
2019-05-19  JRM 0.1.00  Prototype a RGB Gaussian Blurr BKS


"""

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')
import os, time
from ij import IJ, WindowManager
from ij.plugin import ImageCalculator, RGBStackMerge
from ij.plugin.filter.Analyzer import setOption
import jmFijiGen as jmg

def gaussian_blur_8_bks(imp, size):
	"""
	gaussian_blur_8_bks(imp, size)

	Perform a Gaussian Blur on an 8 bit gray scale
	image, use that to do a background correction,
	and return the background corrected image. The
	blur size is 0.3*image width

	Parameters
	==========
	imp:	ImagePlus
			The 8 bit gray scale input image

	Returns
	=======
	bks:	The image plus of the backround-subtracted
			gray scale image
	size:	The size in px of the blur. Should be about
			40% of the image size	
	"""
	strSize = "sigma=%i" % (size)
	imp.show()
	IJ.run("Gaussian Blur...", strSize)
	ti = imp.getShortTitle()
	ti += "_gb"
	imp.setTitle(ti)
	return(imp)
	

def rgb_gaussian_blur_bks(imp, size):
	"""
	rgb_gaussian_blur_bks(imp, size)

	Split an RGB image into channels, create a background
	image for each channel with a Gaussian Blurr, correct
	each channel and construct/return the background-corrected
	image.

	Parameters
	==========
	imp:	ImagePlus
			The input image

	size:	The size in px of the blur. Should be about
			40% of the image size	

	Returns
	=======
	bks:	The image plus of the background-subtracted
			image.
	"""
	title = imp.getShortTitle()
	imp.setTitle(title)
	[impR, impG, impB] = jmg.separate_colors(imp)
	impRb = jmg.gaussian_blur_8_bks(impR, size)
	impRb.setTitle("rb")
	impGb = jmg.gaussian_blur_8_bks(impG, size)
	impGb.setTitle("gb")
	impBb = jmg.gaussian_blur_8_bks(impB, size)
	impBb.setTitle("bb")
	return([impG, impGb])



	
	# ic = ImageCalculator()
	# impRbks = ic.run("Divide create 8-bit", impR, impRb)
	# print(type(impRbks))
	# impR.show()
	# impRb.show()
	# time.sleep(5)

	
	# return(impRbks)
"""
	setOption("ScaleConversions", True)
	IJ.run("8-bit");
	impRbks.setTitle("rbks")
	impRbks.show()
	return(impRbks)

	ic = ImageCalculator()
	impRbks = ic.run("Divide create 32-bit", impR, impRb)
	setOption("ScaleConversions", True)
	IJ.run("8-bit");
	impRbks.setTitle("rbks")
	impRbks.show()
	
	
	impG = WindowManager.getImage(strNameG)
	impG.setTitle("g")
	impGb = gaussian_blur_8_bks(impG, size)
	impGb.setTitle("gb")
	ic = ImageCalculator()
	impGbks = ic.run("Divide create 32-bit", impG, impGb)
	setOption("ScaleConversions", True)
	IJ.run("8-bit")
	impGbks.setTitle("gbks")
	impGbks.show()
	
	impB = WindowManager.getImage(strNameB)
	impB.setTitle("b")
	impBb = gaussian_blur_8_bks(impB, size)
	impBbks = ic.run("Divide create 32-bit", impB, impBb)
	setOption("ScaleConversions", True)
	IJ.run("8-bit")
	impBbks.setTitle("bbks")
	impBbks.show()

	# str2 = "c1=[%s] c2=[%s] c3=[%s]" % ("rbks")
	str2 = "c1=[rbks] c2=[gbks] c3=[bbks]"

	ret = IJ.run("Merge Channels...", str2);

	# lChan = [impRbks, impGbks, impBbks]
	# ret = RGBStackMerge.mergeChannels(lChan, True) 

	str2 = "c1=[rbks] c2=[gbks] c3=[bbks]"
	print(str2)
	IJ.run(ret, "Merge Channels...", str2);
	"""



IJ.run("Close All")
strImgPath = "/Users/jrminter/Documents/git/tips/ImageJ/png/small_rgb_bubbles.png"
IJ.open(strImgPath)
impOri = IJ.getImage()
impOri.show()
[impG, impGb] = rgb_gaussian_blur_bks(impOri, 100)
impG.show()
impGb.show()

# impRet = rgb_gaussian_blur_bks(impOri, 400)
# impRet.show()



