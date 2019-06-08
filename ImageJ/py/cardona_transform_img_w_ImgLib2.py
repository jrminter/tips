"""
Transform an image using ImgLib2

From: https://services.ini.uzh.ch/~acardona/fiji-tutorial/#imglib2-transform

  Date      Who What
----------  --- --------------------------------------------------
2019-06-08  JRM Modify to use Boats and to duplicate
                original to process... Also added call to os.getenv()
                to find GIT_HOME and save the image in my repo

"""

from net.imglib2.realtransform import RealViews as RV
from net.imglib2.img.display.imagej import ImageJFunctions as IL
from net.imglib2.realtransform import Scale
from net.imglib2.view import Views
from net.imglib2.interpolation.randomaccess import NLinearInterpolatorFactory
from ij import IJ
from ij.io import FileSaver
import os

git_home=os.environ['GIT_HOME']
# print(git_home)
str_out_png = git_home + "/tips/ImageJ/png/boats-2x.png"

# Start clean
IJ.run("Close All")

# Load an image (of any dimensions)
imp = IJ.openImage("http://imagej.nih.gov/ij/images/boats.gif")
imp.setTitle("boats")
imp.show()

imp2 = imp.duplicate()
imp2.setTitle("work")
# imp = IJ.getImage()

# Access its pixel data as an ImgLib2 RandomAccessibleInterval
img = IL.wrapReal(imp2)

# View as an infinite image, with a value of zero beyond the image edges


imgE = Views.extendZero(img)

# View the pixel data as a RealRandomAccessible
# (that is, accessible with sub-pixel precision)
# by using an interpolator
imgR = Views.interpolate(imgE, NLinearInterpolatorFactory())

# Obtain a view of the 2D image twice as big
s = [2.0 for d in range(img.numDimensions())] # as many 2.0 as image dimensions
bigger = RV.transform(imgR, Scale(s))

# Define the interval we want to see: the original image, enlarged by 2X
# E.g. from 0 to 2*width, from 0 to 2*height, etc. for every dimension
minC = [0 for d in range(img.numDimensions())]
maxC = [int(img.dimension(i) * scale) for i, scale in enumerate(s)]
imgI = Views.interval(bigger, minC, maxC)

# Visualize the bigger view
imp2x = IL.wrap(imgI, imp.getTitle() + " - 2X") # an ImagePlus
imp2x.show()

FileSaver(imp2x).saveAsPng(str_out_png)

