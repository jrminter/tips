# -*- coding: utf-8 -*-
"""
jrm_macro_prog_slide_8.py

Quiz from 06_ImageJ-macro_programming.ppt slide 8

   Date     Who What
----------  ---  ------
2019-06-08  JRM  Entered code. N.B.: needed to run `conda install tifffile` to
                 intall in base environment.  The answer is that it displays
                 the thresholded image.  Runs nicely in Spyder with tool tips.
                 
                 The spyder IDE notes that skimage.data is imported but not
                 used... I used blobs_inv_lut.tif to match the (annoying)
                 inverted LUT that IJ gives blobs to be consistent with the
                 example. Having images linked to GIT_HOME makes loading more
                 reproducible across my computers/VMs.

"""
import os
from skimage import data, io, filters
from tifffile import imread

git_home = os.getenv("GIT_HOME")
print(git_home)
img_path = git_home + "/tips/ImageJ/tif/blobs/blobs_inv_lut.tif"

image = imread(img_path)

threshold = filters.threshold_otsu(image)

# note how threshold is applied...
thresholded_image = image >= threshold

io.imshow(thresholded_image)

io.show()

