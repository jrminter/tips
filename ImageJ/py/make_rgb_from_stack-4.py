"""
make_rgb_from_stack_4.py

make a RGB image from a Weka 4 channel image

  Modifications
  Date      Who  Ver                       What
----------  --- ------  -------------------------------------------------
2019-05-17  JRM 0.1.00  Test function in to generate an RGB image

"""

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

import os
from ij import IJ, WindowManager

def convert_stack_4_to_rgb(imp):
	"""
	Convert a 4 image stack with a uniform cyan channel 4
	to a RGB image.

	Parameters
	==========
	imp ImagePlus
		The image to be converted

	Returns
	=======
	
	"""
	title = imp.getShortTitle()
	imp.setTitle(title)
	IJ.run("Stack to Images")
	impR = WindowManager.getImage("1")
	impG = WindowManager.getImage("2")
	impB = WindowManager.getImage("3")
	IJ.run("Merge Channels...", "c1=1 c2=2 c3=3 ignore")
	impRGB = WindowManager.getImage("RGB")
	# impRGB.show()
	impC = WindowManager.getImage("4")
	impC.close()
	impR.close()
	impG.close()
	impB.close()
	return (impRGB)
	
IJ.run("Close All")
imgDir = "/Users/jrminter/Desktop/"
imgNam = "jrm-screen-shot"
imgExt = ".png"
imgPath = imgDir + imgNam + imgExt
imgFullName = imgNam + imgExt
IJ.open(imgPath)
imp = IJ.getImage()
impRGB = convert_stack_4_to_rgb(imp)
impRGB.show()

