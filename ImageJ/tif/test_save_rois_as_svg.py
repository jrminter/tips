@String(label="ROI SVG Directory", style="") roi_dir
"""
test_save_rois_as_svg.py

Save ROIs from particle analysis to an SVG file

Based on a acript by Kota Miura here:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

Download jfreesvg.3.3 from
http://repo1.maven.org/maven2/org/jfree/jfreesvg/3.3/
I keep a copy in Dropbox

Code examples are here:
https://www.programcreek.com/java-api-examples/index.php?api=org.jfree.graphics2d.svg.SVGGraphics2D

   Date     Who  What
----------  ---  -------------------------------------------------
2019-06-15  JRM  Downloaded the jfreesvg-3.3.jar and corresponding
                 javadoc file and stored in Dropbox and added the
                 main jar file to Fiji's jar directory. Modified
                 Kota's example to load the Blobs image and write
                 the results to a directory specified by a script
                 parameter. 

"""

import sys
from java.awt import Color
from java.io import File
from ij import IJ
from ij.gui import ShapeRoi
from ij.plugin.frame import RoiManager

from org.jfree.graphics2d.svg import SVGGraphics2D, SVGUtils
import jmFijiGen as jmg

# Start clean...
IJ.run("Close All")
jmg.close_open_non_image_window("Results")
jmg.close_open_non_image_window("ROI Manager")

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()
IJ.setAutoThreshold(imp, "Default")
imp.show()
IJ.setRawThreshold(imp, 126, 255, None)
# The recorder never records this...
IJ.run("Make Binary")
IJ.run("Convert to Mask")
IJ.run("Set Measurements...", "area perimeter shape display add redirect=None decimal=3")
IJ.run(imp, "Analyze Particles...", "size=20-Infinity circularity=0.2-1.00 show=Overlay display exclude clear add");
rm = RoiManager.getInstance()
if rm is None:
	print 'None'
	sys.exit()  
 
# convert ROIs in RoiManager to an array of shapeRois
jrois = rm.getRoisAsArray()
srois = [ShapeRoi(jroi) for jroi in jrois]
# http://www.jfree.org/jfreesvg/javadoc/
g2 = SVGGraphics2D(imp.getWidth(), imp.getHeight())
g2.setPaint(Color.RED)
px = 0.0
py = 0.0

for sroi in srois:
	g2.translate(px*-1, py*-1)
	px = sroi.getBounds().x
	py = sroi.getBounds().y
	g2.translate(px, py)   
	g2.draw(sroi.getShape())

se = g2.getSVGElement()
 
# writing the svg file
path = roi_dir + "/testsvg3.svg"
SVGUtils.writeToSVG(File(path), se)

# writing the csv file
path = roi_dir + "/testsvg3.csv"
IJ.saveAs("Results", path)

# writing the image as a png
imp.show()
imp.flatten()
path = roi_dir + "/testsvg3.png"
IJ.saveAs(imp, "PNG", path)


