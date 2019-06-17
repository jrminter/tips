@String(label="Image Directory", style="") img_dir
"""
image_remove_at_border.py

2019-07-17

This example is from an IJ Forum post here:
https://forum.image.sc/t/exclude-image-edge-from-perimeter-measurement-fiji/26688/2

The image "827C3_100_1_se2.tif" is a very noisy segmentation...
I would clean that up before more analysis...

evenhuis got a workable script to help the original poster (BD_94).

The image is in $GIT_HOME/tips/ImageJ/tif


"""

from ij import IJ
from ij.plugin.frame import RoiManager
from ij.measure import ResultsTable

img_path = img_dir + "/827C3_100_1_se2.tif"

IJ.run("Close All")
print(img_path)

imp = IJ.openImage(img_path)
imp.show()

# grab the image
# imp=IJ.getImage()
w = imp.getWidth()     # use these to work out the border
h = imp.getHeight()	   # of the image

IJ.run(imp, "Analyze Particles...", "display exclude clear add")

cal = imp.getCalibration()
px2um = cal.pixelWidth  # we need this convert pixels to lengths

# get the roi manager (this needs to conatins the roi from a threshold)
roim = RoiManager.getInstance()

# Make a new results table

rt = ResultsTable()

for i in range(roim.getCount()):
	roi = roim.getRoi(i)
	
	# these ore the points in the roi
	points = roi.getContainedPoints()
	 
	# this is an array of True,False if the pixel is on the border
	border = [ (p.x==0) or(p.x==w-1) or (p.y==0) or (p.y==h-1) for p in points]

	# this is the length of parts of the roi touching a border
	length_border = sum(border)*px2um 


	perim = roi.getLength()
	stats = roi.getStatistics()
	rt.setValue("Label",i,i+1)
	rt.setValue("Area", i, stats.area*px2um**2)
	rt.setValue("Perim",i,perim)
	rt.setValue("Border Length",i, length_border)
	rt.setValue("Perim non-border", i, perim-length_border)

	rt.setValue("Width",  i,stats.roiWidth*px2um)
	rt.setValue("Height", i,stats.roiHeight*px2um)
	rt.setValue("Major",  i,stats.major*px2um)
	rt.setValue("Minor",  i,stats.minor*px2um)


rt.show("Corrected perimeter")