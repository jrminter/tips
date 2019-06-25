from ij import IJ
from ij.process import ImageStatistics
IJ.run("Close All")
imp = IJ.openImage("/Users/jrminter/Downloads/HEK293T JUNO Fcrl3 PHALLOIDIN488 ii.czi - C=0.tif");
imp.show()
stats = imp.getRawStatistics()
print(stats.histMax)


