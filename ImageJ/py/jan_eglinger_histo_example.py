#@ ImagePlus imp  # take e.g. M51 Galaxy sample image

"""
Histo example from Jan Eglinger with some JRM mods
converted from groovy to python

"""


from ij.process import StackStatistics
from ij import IJ


simpleStats = StackStatistics(imp)

print("Image name: %s" % (imp.getTitle()))
print("Automatic bin size: %s" % (simpleStats.binSize))
print("Automatic hist min: %s" % (simpleStats.histMin))
print("Automatic hist max: %s" % (simpleStats.histMax))

binWidth = 2
min = 0
max = 1024

customStats = StackStatistics(imp, (int(max-min)/binWidth), min, max)

print("Custom bin size: %s" % (customStats.binSize))
print("Custom hist min: %s" % (customStats.histMin))
print("Custom hist max: %s" % (customStats.histMax))

IJ.run("Histogram", "bins=6000 x_min=0 x_max=12000")

