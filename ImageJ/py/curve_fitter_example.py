"""
curve_fitter_example.py

Plot some points and save the plot as a PNG from jython

From here:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

and here:
https://imagej.nih.gov/ij/developer/api/ij/measure/CurveFitter.html

This helps too:
https://imagej.nih.gov/ij/developer/api/index.html

"""


from ij.measure import CurveFitter
from ij.gui import Plot
from ij import IJ
from java.awt import Color
import jarray
import os

git_home = os.getenv("GIT_HOME")
plt_path = git_home + "/tips/ImageJ/py/curve_fitter_example_plt.png"
print(plt_path)

# start clean
IJ.run("Close All")
 
# create example data arrays
xa = [1, 2, 3, 4]
ya = [3, 3.5, 4, 4.5]
 
# convert to java array
jxa = jarray.array(xa, 'd')
jya = jarray.array(ya, 'd')
 
# construct a CurveFitter instance
cf = CurveFitter(jxa, jya)
 
# actual fitting
# fit models:
# see http://rsb.info.nih.gov/ij/developer/api/constant-values.html#ij.measure.CurveFitter.STRAIGHT_LINE
cf.doFit(CurveFitter.STRAIGHT_LINE)
 
#print out fitted parameters.
print(cf.getParams()[0], cf.getParams()[1])

print(cf.getFormula())

plt = cf.getPlot()
plt.draw()

left = 0
right = 5
bottom = 0
top = 5
nPoints = 4
rng = right - left

# Create filled plot
plt = Plot("Line plot", "X", "Y")
plt.setLimits(left, right, bottom, top)
plt.setFrameSize(600, 300 );
plt.setColor("blue", "#ccccff")
# the circles are small. Can't figure out how to make 
# them larger...
plt.add("circles", jxa, jya)
plt.setColor(Color.RED)
plt.setLineWidth(2)
plt.drawLine(0.0, 2.5, 4.0, 4.5) 
plt.setXYLabels("X", "Y")
plt.show()

plt_imp = plt.getImagePlus()
IJ.saveAs(plt_imp, "PNG", plt_path)

