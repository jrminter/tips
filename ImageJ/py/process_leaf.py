"""
process_leaf.py

Date        Who  What
----------  ---  ---
2019-06-17  JRM  Initial prototype. This is based on an example from the
                 ImageJ Forum (see URL below). The objective was to measure
                 the R, G, and B gray levels on an image of a leaf.
                 Christian Evenhuis posted a sample but did not show code
                 or upload a leaf image. I found a suitable PNG image
                 (credit below). It was a 1600x1200 pixel RGB image, so I
                 downsampled to 800x600 pixels. I set this up to use the
                 GIT_HOME variable to set a relative path to my github
                 repository so this should work cross-platform...
                 

working as expected

IJ Forum Link:
https://forum.image.sc/t/measure-vs-particle-analyser/26682/2

Source of my leaf image:
https://www.kisspng.com/png-sugar-maple-autumn-leaf-color-green-green-leaves-634432/preview.html
                  


"""

from ij import IJ, ImagePlus, WindowManager, Prefs, ImageStack
from ij.plugin import ChannelSplitter
from ij.plugin.frame import RoiManager
from ij.plugin.filter import Analyzer
from ij.gui import Roi

import os

def add_roi_and_update(imp, rm, roi_num):
	rm.select(roi_num)
	rm.selectAndMakeVisible(imp, roi_num) 
	imp.updateAndRepaintWindow()
	

IJ.run("Close All")
# RoiManager should be present
rm = RoiManager.getInstance()
# rm.reset()
git_home = os.getenv("GIT_HOME")
leaf_path = git_home + "/tips/ImageJ/png/maple-leaf.png"
leaf_csv_path = git_home + "/tips/ImageJ/png/maple-leaf.csv"
print(leaf_path)
imp_leaf = IJ.openImage(leaf_path)
imp_leaf.show()
channels = ChannelSplitter.split(imp_leaf)
# red
channels[0].show()
# green
channels[1].show()
# blue
channels[2].show()
# work
imp_bin = channels[2].duplicate()
imp_bin.setTitle("binary")
IJ.setAutoThreshold(imp_bin, "Huang")
IJ.setRawThreshold(imp_bin, 0, 233, None);
IJ.run(imp_bin, "Set Measurements...", "area mean perimeter shape display add redirect=None decimal=3")
IJ.run(imp_bin, "Analyze Particles...", "display clear add")
imp_bin.show()



roi_num = 0
add_roi_and_update(channels[0], rm, roi_num)
add_roi_and_update(channels[1], rm, roi_num)
add_roi_and_update(channels[2], rm, roi_num)
add_roi_and_update(imp_leaf, rm, roi_num)
imp_leaf.show()

rt = Analyzer.getResultsTable()
rt.reset()

IJ.run(channels[0], "Measure", "")
IJ.run(channels[1], "Measure", "")
IJ.run(channels[2], "Measure", "")

rt.save(leaf_csv_path)



