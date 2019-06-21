"""
test_proc_thresholded_img.py
"""

import os
from ij import IJ, WindowManager, Prefs

imp = WindowManager.getImage("output")
Prefs.blackBackground = False
IJ.run(imp, "Make Binary", "")
IJ.run(imp, "Erode", "")
IJ.run(imp, "Dilate", "")
IJ.run(imp, "Fill Holes", "")
IJ.run(imp, "Watershed", "")
IJ.run("Set Measurements...", "area mean perimeter shape display add redirect=None decimal=3")
IJ.run(imp, "Analyze Particles...", "size=40-Infinity circularity=0.30-1.00 show=Overlay display exclude clear add")
