from ij import IJ
import struct

"""
from:

http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook


"""

 
def s2u8bit(v):
    return struct.unpack("B", struct.pack("b", v))[0]

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
 
# imp = IJ.getImage()
signedpix = imp.getProcessor().getPixels()
 
pix = map(s2u8bit,signedpix)
 
#check that the conversion worked. 
# this example was made for binary image, to print only values 255  
for j in range(len(pix)):
        curval = pix[j]
        #curval = s2u8bit(curval)
        if curval is 0:
            print '--'
        else:
            print curval