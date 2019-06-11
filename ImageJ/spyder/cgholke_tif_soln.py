#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun 10 16:04:25 2019

@author: jrminter
"""

import os
import numpy
import tifffile

git_home = os.getenv("GIT_HOME")
print(git_home)

img_path_in = git_home + "/tips/ImageJ/tif/VS_demo.tif"
img_path_out = git_home + "/tips/ImageJ/tif/VS_demo_out.tif"


# read interleaved RGB+extrasample channels from TIFF into separate arrays
im = tifffile.imread(img_path_in)
r, g, b, ir = numpy.moveaxis(im, -1, 0)

# process arrays; make sure not to change the data type
...

# save arrays as interleaved RGB+extrasample TIFF
im = numpy.moveaxis([r, g, b, ir], 0, -1)
tifffile.imsave(img_path_out, im, photometric='rgb',
                 planarconfig='contig', extrasamples='unspecified',
                 rowsperstrip=6, metadata=None)