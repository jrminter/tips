"""
plotting_points.py

A reproducible example to illustrate an issue with
point size using ImageJ's plotting functions. Adapted
for jython  from one of Norbert Vischer's examples here:
https://imagej.nih.gov/ij/macros/examples/AdvancedPlots.txt

The issue is the small zise of the points (circles)

"""

from ij import IJ
from ij.gui import Plot
from java.awt import Color
import jarray
import os


# start clean
IJ.run("Close All")

# create example data arrays
xa = [1, 2, 3, 4]
ya = [3, 3.5, 4, 4.5]

# convert to java array
jxa = jarray.array(xa, 'd')
jya = jarray.array(ya, 'd')

# Create filled plot
plt = Plot("Line plot", "X", "Y")
plt.setLimits(0, 5, 0, 5)
plt.setFrameSize(600, 300 )
plt.setColor("blue", "#ccccff")

# the circles are small. Can't figure out how to make 
# them larger... These 2 calls are equivalent...
# plt.addPoints(jxa,jya, Plot.CIRCLE)
plt.add("circles", jxa, jya)
plt.setColor(Color.RED)
plt.setLineWidth(1)
plt.drawLine(0.0, 2.5, 4.0, 4.5) 
plt.setXYLabels("X", "Y")
plt.show()