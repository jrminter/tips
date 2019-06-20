"""
image_math_flat_field.py

Date        Who  What
----------  ---  ----------------------------------------------------
2019-06-20  AC   Started with Albert Cardona's script here:
                 https://www.ini.uzh.ch/~acardona/fiji-tutorial/#s8

2019-06-20  JRM  1. Added "Close All" to Run Clean
                 2. Added WindowManager dependency to get the current
                    image as an ImagePlus
                 3. Enanced contrast to set gray level range, converted
                    to an 8 bit image (original range) and displayed
                    with a helpful name.
                 

"""
from script.imglib.math import Compute, Divide, Multiply, Subtract
from script.imglib.algorithm import Gauss, Scale2D, Resample
from script.imglib import ImgLib
from ij import IJ, WindowManager

# Start Clean
IJ.run("Close All")

# 1. Open an image
imp = IJ.openImage("https://imagej.nih.gov/ij/images/bridge.gif")
ti = imp.getShortTitle()
img = ImgLib.wrap(imp)

# 2. Simulate a brighfield from a Gauss with a large radius
# (First scale down by 4x, then gauss of radius=20, then scale up)
brightfield = Resample(Gauss(Scale2D(img, 0.25), 20), img.getDimensions())

# 3. Simulate a perfect darkfield
darkfield = 0

# 4. Compute the mean pixel intensity value of the image
mean = reduce(lambda s, t: s + t.get(), img, 0) / img.size()

# 5. Correct the illumination
corrected = Compute.inFloats(Multiply(Divide(Subtract(img, brightfield),
                                             Subtract(brightfield, darkfield)), mean))

# 6. ... and show it in ImageJ - it needs to be scaled. This is a 32 bit image
ImgLib.wrap(corrected).show()

# 7. JRM get the displayed image 
imp_new = WindowManager.getCurrentImage()
IJ.run(imp_new, "Enhance Contrast", "saturated=0.35")
# JRM: this will change with input image type...
IJ.run(imp_new, "8-bit", "")
imp_new.setTitle(ti + "_ff_cor")
imp_new.show()
print("done")