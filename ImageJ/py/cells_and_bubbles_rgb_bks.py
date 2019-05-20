"""
cells_and_bubble_rgb_bks.py

Originally from:
https://forum.image.sc/t/finding-ellipses-with-incomplete-boundaries/843

Ellen Arena highlighted this problem in the Segmentation lecture.

Compute and subtract the background from an image (RGB) of a cell and some
bubbles. To make things faster, I used a test image I had binned by two to
533x400 pixels and saved it to a PNG file. This image still has the artifacts
from the JPEG compression in the original image.

The code was written in Jython and I encapsulated the major operations into
functions. It is easier (for me, John Minter, at least) to read and understand
that way. 

  Modifications
  Date      Who  Ver                       What
----------  --- ------  -------------------------------------------------
2019-05-20  JRM 0.1.00  An attempt to make a Gaussian Blur background
                        subtraction script to process a test
                        cells_and_bubbles RGB image

"""

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

import os
from ij import IJ, WindowManager
from ij.plugin import ImageCalculator
from ij.plugin.filter.Analyzer import setOption
from ij.process import ImageConverter
import jmFijiGen as jmg

def divide_img_by_bkg(impImg, impBkg, name):
	"""
	divide_img_by_bkg(impImg, impBkg, title)

	Divide an image by its background and set title

	Parameters
	==========
	impImg:	ImagePlus
		An 8 bit image from a channel
	impBkg:	ImagePlus
		An 8-bit image of the background
	title:
		A string for the image title
	
	Return
	======
	impRet:	ImagePlus
		The ImagePlus containing a 32 bit/px background
		subtracted image
	
	"""
	ic = ImageCalculator()
	impRet = ic.run("Divide create 32-bit", impImg, impBkg)
	impRet.setTitle(name)
	return impRet

def cvt_32_bit_to_8_bit(imp):
	"""
	cvt_32_bit_to_8_bit(imp)

	Convert a 32 bit image to an 8-bit grayscale

	Parameters
	==========
	imp:	ImagePlus
		The ImagePlus of a 32 bit/px image to convert

	Returns
	=======
	wrk:	ImagePlus
		The ImagePlus with the 8-bit/px image
		
	"""
	imp.show()
	wrk = imp.duplicate()
	ic = ImageConverter(wrk)
	ic.convertToGray8()
	title = imp.getTitle()
	wrk.setTitle(title + "_g8")
	wrk.updateImage()
	return wrk
	

def close_without_prompt(imp):
	"""
	close_without_prompt(imp)

	Close an image w/o a prompt to save changes

	Parameters
	==========
	imp:	ImagePlus
		The image to close

	Return
	======
	None
	
	"""
	imp.changes = False
	imp.close()

# The size of the Gaussian Blur. Should be on the order of 30% of image width
size = 50

# A boolean to determine if we want to close - without warning - intermediate
# images
closeIntermediate = True

# The base title to give the image
strTitle = "small_rgb_bubbles"

IJ.run("Close All")
strImgPath = "/Users/jrminter/Documents/git/tips/ImageJ/png/small_rgb_bubbles.png"
IJ.open(strImgPath)
impOri = IJ.getImage()
impOri.setTitle(strTitle)
impOri.show()
[impR, impG, impB] = jmg.separate_colors(impOri)
impR.show()
impG.show()
impB.show()

impRb = jmg.gaussian_blur_8_bks(impR, size)
impRb.setTitle("rb")
impRb.show()

impGb = jmg.gaussian_blur_8_bks(impG, size)
impGb.setTitle("gb")
impGb.show()

impBb = jmg.gaussian_blur_8_bks(impB, size)
impBb.setTitle("bb")
impBb.show()

impRbks = divide_img_by_bkg(impR, impRb, "R-bks")
impRbks.show()

impGbks = divide_img_by_bkg(impG, impGb, "G-bks")
impGbks.show()

impBbks = divide_img_by_bkg(impB, impBb, "B-bks")
impBbks.show()

impRbks8 = cvt_32_bit_to_8_bit(impRbks)
impRbks8.show()

impGbks8 = cvt_32_bit_to_8_bit(impGbks)
impGbks8.show()

impGbksB = cvt_32_bit_to_8_bit(impBbks)
impGbksB.show()

IJ.run("Merge Channels...", "c1=R-bks_g8 c2=G-bks_g8 c3=B-bks_g8 create")
IJ.run("Flatten")

impFinal = WindowManager.getImage("Composite (RGB)")
impFinal.setTitle(strTitle + "_bks")


if closeIntermediate:
	close_without_prompt(impR)
	close_without_prompt(impRb)

	close_without_prompt(impG)
	close_without_prompt(impGb)

	close_without_prompt(impB)
	close_without_prompt(impBb)

	close_without_prompt(impRbks)
	close_without_prompt(impGbks)
	close_without_prompt(impBbks)

