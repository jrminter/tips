from ij import IJ, ImagePlus, WindowManager
from ij.gui import Roi
from java.awt import Color

import jmFijiGen as jmg

def set_roi_color_and_stroke(int_width, int_R, int_G, int_B):
	"""
	set_roi_color_and_stroke(str_color, int_R, int_G, int_B)

	Set the color and stroke of the current ROI
	Add to image with Image > Overlay > Add Selection (CMD B)

	Parameters
	==========
	int_width:	integer
				the width of the stroke, i.e. 6
				
	int_R:		integer between 0 and 255
				the red component, i.e. 255
				
	int_G		integer between 0 and 255
				the green component, i.e. 0

	int_B		integer between 0 and 255
				the blue component, i.e. 0
	

	Returns
	=======
	None
	
	"""
	imp = IJ.getImage()
	roi = imp.getRoi()
	print(roi)
	if roi != None:
		roi.setStrokeWidth(int_width)		
		roi.setStrokeColor(Color(int_R, int_G, int_B))
		imp.updateAndRepaintWindow()

# NOTE: this uses the version in Fiji.app/jars/lib
jmg.set_roi_color_and_stroke(6, 255, 0, 0)