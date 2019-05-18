"""
Start a Trainable Weka Segmmentation

  Modifications
  Date      Who  Ver                       What
----------  --- ------  -------------------------------------------------
2019-05-17  JRM 0.1.00  Start a segmentation

"""
from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')
import os
from ij import IJ, WindowManager

IJ.run("Close All")

"""
# MacOS
str_path = "/Users/jrminter/Documents/git/tips/ImageJ/jpg/aggregates_w_TWS.jpg" 
"""
# Windows
str_path = "C:/Users/jrminter/Documents/git/tips/ImageJ/jpg/aggregates_w_TWS.jpg"
IJ.open(str_path)
IJ.run("Trainable Weka Segmentation")
