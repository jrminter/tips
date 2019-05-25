from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

import os
from ij import IJ, WindowManager

IJ.run("Close All")
img = IJ.openImage("http://wsr.imagej.net/images/blobs.gif")
IJ.setAutoThreshold(img, "Default")
IJ.run(img, "Analyze Particles...", "  show=[Bare Outlines] include in_situ")
img.show()
