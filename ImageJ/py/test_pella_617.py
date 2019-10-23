"""
Needs work at line 36
"""

from ij import IJ
import jmFijiGen as jmg


IJ.run("Close All")
jmg.close_open_non_image_window("Results")
jmg.close_open_non_image_window("ROI Manager")

imp = IJ.openImage("/Users/jrminter/Desktop/Pella_617_Au_on_C_100kX_15kV_cr.tif")
imp.setTitle("Orig")
imp.show()

imp_proc = imp.duplicate()
imp_proc.setTitle("Proc")
IJ.run(imp_proc, "Median...", "radius=2")
IJ.run(imp_proc, "Invert", "")
IJ.run(imp_proc, "Enhance Contrast", "saturated=0.35")
imp_proc.show()

imp_bin = imp_proc.duplicate()
imp_bin.setTitle("Bin")
IJ.setAutoThreshold(imp_bin, "MinError")
imp_bin.show()
IJ.run("Make Binary")


imp_seg = imp_bin.duplicate()
imp_seg.setTitle("Seg")
IJ.run("Set Measurements...", "area mean perimeter fit shape display add redirect=Orig decimal=3")
IJ.run(imp_seg, "Analyze Particles...", "size=20-Infinity circularity=0.3-1.00 show=[Overlay Masks] display exclude clear add")
# rm.runCommand(imp_seg,"Show None")
rm.runCommand(imp,"Show All with labels")
imp_seg.show()
imp_ori.show()


