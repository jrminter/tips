"""
test_new_calib_func.py

A new calibration function

  Modifications
  Date      Who  Ver                       What
----------  --- ------  -------------------------------------------------
2019-06-16  JRM 0.1.00  Test function in to calibrate an image

"""

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

import os
from ij import IJ, WindowManager
from ij.measure import Calibration
import jmFijiGen as jmg

IJ.run("Close All")
imp_test = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp_cal = jmg.calib_img_x_y_z(imp_test, 0.2, 0.2, 1.0, units=-6)
imp_test.show()
