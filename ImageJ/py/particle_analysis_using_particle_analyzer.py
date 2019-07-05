"""
Particle Analysis in Jython using the ParticleAnalyzer class

from
https://imagej.net/Jython_Scripting_Examples

"""

from ij import IJ
from ij.plugin.filter import EDM, ParticleAnalyzer
from ij.process import ImageProcessor
from ij.measure import ResultsTable
from ij.plugin.frame import RoiManager
from ij.measure import Measurements
from java.lang import Double

IJ.run("Close All")

# 1 - Obtain an image
blobs = IJ.openImage("http://imagej.net/images/blobs.gif")
# Make a copy with the same properties as blobs image:
imp = blobs.createImagePlus()
ip = blobs.getProcessor().duplicate()
imp.setProcessor("blobs copy", ip)

imp_work = imp.duplicate()
imp_work.setTitle("Work")
ip_work = imp_work.getProcessor()
 
# 2 - Apply a threshold: only zeros and ones
# Set the desired threshold range: keep from 0 to 74
ip_work.setThreshold(147, 147, ImageProcessor.NO_LUT_UPDATE)
# Call the Thresholder to convert the image to a mask
IJ.run(imp_work, "Convert to Mask", "")
 
# 3 - Apply watershed
# Create and run new EDM object, which is an Euclidean Distance Map (EDM)
# and run the watershed on the ImageProcessor:
EDM().toWatershed(ip_work)
 
# 4 - Show the watersheded image:
#     Note - it includes edge particles
imp_work.show()

# Create a table to store the results
results_table = ResultsTable()
# Create a hidden ROI manager, to store a ROI for each blob or cell
roim = RoiManager()
# Create a ParticleAnalyzer, with arguments:
# 1. options (could be SHOW_ROI_MASKS, SHOW_OUTLINES, SHOW_MASKS, SHOW_NONE, ADD_TO_MANAGER, and others; combined with bitwise-or)
# 2. measurement options (see [http://imagej.net/developer/api/ij/measure/Measurements.html Measurements])
# 3. a ResultsTable to store the measurements
# 4. The minimum size of a particle to consider for measurement
# 5. The maximum size (idem)
# 6. The minimum circularity of a particle
# 7. The maximum circularity

minSize = 30.0
maxSize = 10000.0
opts = ParticleAnalyzer.EXCLUDE_EDGE_PARTICLES | ParticleAnalyzer.SHOW_OVERLAY_OUTLINES 
print(opts)
meas = Measurements.AREA | Measurements.MEAN | Measurements.CENTER_OF_MASS
print(meas)
pa = ParticleAnalyzer(opts, meas, results_table, minSize, maxSize)
# pa.setHideOutputImage(False)
pa.setRoiManager(roim)

if pa.analyze(imp_work):
  imp_out = pa.getOutputImage()
  # imp_out.show()
  roim.runCommand(blobs,"Show All with labels")
  blobs.show()
  results_table.show("Results")
  roim.show()
  print "All ok"
else:
  print "There was a problem in analyzing", blobs
 
# The measured areas are listed in the first column of the results table, as a float array:
areas = results_table.getColumn(0)