"""
load_blobs.py
"""

from ij import IJ

IJ.run("Close All")
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()
