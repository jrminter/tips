@String(label="Image Directory", style="") img_dir
@String(label="Image Base Name", style="") img_name
@String(label="Image Ext", style="") img_ext

"""
from:

http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook

"""

from ij import IJ, ImagePlus
from ij.io import Opener
from loci.plugins import BF

# returned is an array of ImagePlus, in many cases just one imp.
src = img_dir + "/" + img_name + img_ext
imps = BF.openImagePlus(src)
imp = imps[0]
imp.show()
 