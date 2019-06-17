@String(label="Image Directory", style="") img_dir

"""
fun_with_the_roi_manager.py

Test capabilities of the RoiManager

Date        Who  What
----------  ---  ------------------------------------------------------------
2019-06-16  JRM  Initial start but had trouble with setting color to the ROIs
2019-06-17  JRM  Bio7 from IJ Forum provided the info I needed & added comments

img_dir macOS:
/Users/jrminter/Documents/git/tips/ImageJ/tif/blobs

I had trouble getting the color to yellow, I posted a question on the
IJ Forum:
https://forum.image.sc/t/turn-off-prompt-when-changing-roimanagers-line-color-in-a-jython-script/26680

and Bio7 provided the solution:
https://forum.image.sc/t/turn-off-prompt-when-changing-roimanagers-line-color-in-a-jython-script/26680/2

This Forum post (linked by Bio7) was helpful:
https://forum.image.sc/t/clear-selection-implementation-in-jython/5187

"""

from ij import IJ, ImagePlus
from ij.plugin.frame import RoiManager
from ij.gui import Roi
import jmFijiGen as jmg

# loading an image from the imagej site
# if you want to load an image from local, replace the URL with a file path
# Start clean...

IJ.run("Close All")
jmg.close_open_non_image_window("Results")
jmg.close_open_non_image_window("ROI Manager")

# no inverted LUT...
imp_ori = IJ.openImage(img_dir + "/blobs.tif")
imp_ori.setTitle("orig blobs")
imp_ori.show()

# create a duplicate to process
imp_det = imp_ori.duplicate()
imp_det.setTitle("work")
imp_det.show()

imp_rgb = imp_ori.duplicate()
IJ.run(imp_rgb, "RGB Color", "")
imp_rgb.setTitle("color blobs")
imp_rgb.show()


# now we have created a duplicate of original
# convert the original to RGB
# back to processing the work...

IJ.setAutoThreshold(imp_det, "Default")
imp_det.show()
IJ.run(imp_det, "Make Binary", "")
IJ.run(imp_det, "Convert to Mask", "")
IJ.run(imp_det, "Set Measurements...", "area mean perimeter shape display add redirect=[color blobs] decimal=3");
# IJ.run(imp_det, "Set Measurements...", "area mean perimeter shape display add  decimal=3")
IJ.run(imp_det, "Analyze Particles...", "size=20-Infinity circularity=0.2-1.00 show=Overlay display exclude clear add")
imp_det.show()
# jmg.close_open_non_image_window("Results")

# RoiManager should be present
rm = RoiManager.getInstance()

# find the number of ROis and make the color yellow
# based on Bio7's suggestion
count = rm.getCount()
for x in range(count):
	rm.select(x)
	rm.runCommand("Set Color", "yellow")

	
rm.allowRecording(True)
imp_ori.show()
ip = imp_ori.getProcessor()
ra = rm.getRoisAsArray()

"""
loop through ROI array and do measurements. 
here is only listing mean intensity of ROIs
if you want more, see 
http://rsbweb.nih.gov/ij/developer/api/ij/process/ImageStatistics.html

This isn't terribly helpful because in general I save directly to .csv.
Where it could be helpful is in filtering results by ROI, perhaps selecting
compliant particles...
"""

for r in ra:
	ip.setRoi(r)
	istats = ip.getStatistics()
	print istats.mean


rm.runCommand(imp_det,"Show None")
rm.runCommand(imp_det,"Show All")
rm.runCommand(imp_rgb,"Show None")
rm.runCommand(imp_rgb,"Show All with labels")
imp_ori.show()
imp_det.close()



