# imports
import sys
import os
import glob
import shutil
import datetime
import time
import math
import csv

import os, shutil

from math import *
from math import sqrt

from colorsys import hsv_to_rgb

from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

from java.awt import Color, Font

import java.io as jio
import java.lang as jl
import java.util as ju

import jarray
from java.util import Random
from jarray import zeros

from ij import IJ, ImagePlus, WindowManager, Prefs, ImageStack

from ij.io import FileInfo, FileOpener,  DirectoryChooser, FileSaver

from ij.gui import Roi, TextRoi, ImageRoi, Overlay, ImageCanvas
from ij.gui import ShapeRoi, PointRoi

from ij.measure import ResultsTable, Calibration, Measurements
from ij.plugin import ImageCalculator, Duplicator, ChannelSplitter
from ij.plugin import MontageMaker
from ij.plugin.filter import ParticleAnalyzer, Analyzer, EDM
from ij.plugin.frame import RoiManager

from ij.process import LUT, ImageProcessor, StackProcessor, FloatProcessor, ByteProcessor
from ij.process import ImageStatistics, AutoThresholder
from ij.process.AutoThresholder import getThreshold
from ij.process.AutoThresholder import Method 


from script.imglib.math import Compute, Divide, Multiply, Subtract
from script.imglib.algorithm import Gauss, Scale2D, Resample
from script.imglib import ImgLib 

import mpicbg.imglib.image.ImagePlusAdapter
import mpicbg.imglib.image.display.imagej.ImageJFunctions
import fiji.process.Image_Expression_Parser

IJ.run("Close All")

imp = ImagePlus("my new image", FloatProcessor(512, 512))
pix = imp.getProcessor().getPixels()
print(type(pix))

n_pixels = len(pix)
print(n_pixels)

# catch width
w = imp.getWidth()
# create a ramp gradient from left to right
for i in range(len(pix)):
	pix[i] = i % w
  
# adjust min and max, since we know them
imp.getProcessor().setMinAndMax(0, w-1)
imp.show()

# Create a random 8-bit image the hard way...
width = 512
height = 512
  
pix = zeros(width * height, 'b')
Random().nextBytes(pix)

channel = zeros(256, 'b')
for i in range(256):
    channel[i] = (i -128) 
cm = LUT(channel, channel, channel)
imp_rand_hard = ImagePlus("Random", ByteProcessor(width, height, pix, cm))
imp_rand_hard.show()

# random 16 bit the hard way...
imp = IJ.createImage("An Easy Random Image 8 bit image", "8-bit", 512, 512, 1)
Random().nextBytes(imp.getProcessor().getPixels())
imp.show()

print(sys.getsizeof(int))
print(sys.getsizeof(bytes))

# 1 - Obtain an image
blobs = IJ.openImage("http://imagej.net/images/blobs.gif")
blobs.setTitle("blobs")
blobs.show()
# Make a copy with the same properties as blobs image:
imp = blobs.createImagePlus()
ip = blobs.getProcessor().duplicate()
imp.setProcessor("blobs binary", ip)
 
# 2 - Apply a threshold: only zeros and ones
# Set the desired threshold range: keep from 0 to 74
ip.setThreshold(147, 147, ImageProcessor.NO_LUT_UPDATE)
# Call the Thresholder to convert the image to a mask
IJ.run(imp, "Convert to Mask", "")
 
# 3 - Apply watershed
# Create and run new EDM object, which is an Euclidean Distance Map (EDM)
# and run the watershed on the ImageProcessor:
EDM().toWatershed(ip)
 
# 4 - Show the watersheded image:
imp.show()
