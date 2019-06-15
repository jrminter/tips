"""
test_set_row_numbers_on_rt

This was an adaptation of a macro by Kota Miura here:
https://forum.image.sc/t/row-numbers-disappeared-from-resulttable-in-fiji/19699/6

On my version of ImageJ (1.52n99) 2019-06-15 setting
res.showRowNumbers() as True or False made no difference

"""
from ij.measure import ResultsTable
from ij import IJ
from ij.plugin.filter import Analyzer
import jmFijiGen as jmg

# start cean
IJ.run("Close All")
jmg.close_open_non_image_window("Results")
jmg.close_open_non_image_window("ROI Manager")

# open our image
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
Analyzer.setOption("BlackBackground", True)
imp.show()
IJ.run("Convert to Mask")
imp.show()
IJ.run("Set Measurements...", "area perimeter shape display redirect=None decimal=3")
IJ.run("Analyze Particles...", "size=20-Infinity circularity=0.2-1.00 display exclude clear add")
# Note that this showed the result numbers independent of T/F below
res = ResultsTable.getResultsTable()
res.showRowNumbers(True)
res.updateResults()
print("ImageJ version " + IJ.getFullVersion())
