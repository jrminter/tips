# @ImagePlus imp
# @OpService ops
# @UIService ui

from ij import IJ

"""
The parameters "Seed Dynamics", "Intensity threshold" and "peak flooding" can be made optional

function Signature
	resultImage = op.run("H_Watershed", inputImage, hMin, threshold, peakFlooding, outputMask, allowSplitting)
	
All parameters beyond inputImage are optional. They can be replaced by null or if at the end of the
list they can be remove completely. If the parameter is detected as missing a sensible default is used

hMin = 5(max-min)/100
threshold = min
peakflooding = 100
outputMask = False (default is to output a label image)
allowsplitting = True (default is to allow threshold to create new peaks)
"""

IJ.runMacro("close(\"\\\\Others\")")

hMin = 0
thresh = 100
peakFlooding = 50

result0 = ops.run("H_Watershed", imp)

result1 = ops.run("H_Watershed", imp, hMin)

result2 = ops.run("H_Watershed", imp, hMin, thresh)

outputMask = True
allowSplit = False
result3 = ops.run("H_Watershed", imp, hMin, thresh, peakFlooding, outputMask, allowSplit )

ui.show(result0)
ui.show(result1)
ui.show(result2)
ui.show(result3)