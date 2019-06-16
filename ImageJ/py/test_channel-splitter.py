"""
test_channel_splitter.py

Adapted by J. R. Minter from "Channel Merge" here:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

Date        Who  What
----------  ---  ----------------------------------------------------
2019-06-16  JRM  Initial adaptation. Use the HOME environment
                 variable to get the start of the path


"""

from ij import IJ
from ij.plugin import ChannelSplitter
import os

home_dir = os.getenv("HOME")
imp = IJ.openImage(home_dir + "/Documents/git/tips/ImageJ/tif/mandrill_256.tif");
imps = ChannelSplitter.split(imp)
imps[0].show() # Channel 1
imps[1].show() # Channel 2
imps[2].show() # Channel 3