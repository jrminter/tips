"""
test_channel_merge.py

Adapted by J. R. Minter from "Channel Merge" here:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

Date        Who  What
----------  ---  ----------------------------------------------------
2019-06-16  JRM  Initial adaptation. Use the GIT_HOME environment
                 variable to get the start of the path


"""

import os
from ij import IJ, ImagePlus
from ij.plugin import RGBStackMerge, RGBStackConverter

# use a path relative to the GIT_HOME environment variable
git_home = os.getenv("GIT_HOME")
print(git_home)

# start clean
IJ.run("Close All")

# Load the R, G, and B color separation images. These were created
# using make_mandrill_256.py
impc1 = ImagePlus(git_home + "/tips/ImageJ/tif/mandrill_256_red.tif")
impc2 = ImagePlus(git_home + "/tips/ImageJ/tif/mandrill_256_green.tif")
impc3 = ImagePlus(git_home + "/tips/ImageJ/tif/mandrill_256_blue.tif")

# merge my three images
imp_merge = RGBStackMerge.mergeChannels([impc1, impc2, impc3], True)
 
# convert the composite image to the RGB image
RGBStackConverter.convertToRGB(imp_merge)

imp_merge.show()