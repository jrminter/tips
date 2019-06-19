@String(label="Image Directory", style="") img_dir
"""
test_image_get_info.py

Expand on a comment by Kota Miura here:
https://forum.image.sc/t/how-to-set-image-property/9338/11

Date        Who  What
----------  ---  -----------------------------------------
2019-06-15  JRM  Initial prototype. Use a python multiline
                 string to store image processing provenance
                 in the info parameter. Note the use of a 
                 script parameter to specify the image
                 directory...

"""
from ij import IJ
import os

# start clean
IJ.run("Close All")

tif_path = img_dir + "/nalco-img-04cr.tif"

imp = IJ.openImage(tif_path)

str_info = """Analyst: J. R. Minter
Date Recorded: 2004-08-10 14:05
Sample: Nalco silica
Instrument: Philips CM20
Conditions: CryoTEM 200 kV 38,000X LowDose
Notes: Original image size 1024x1024x16 bits/px 
Comment: 2019-06-19: Rotated and cropped in Fiji to get best particles. 
"""

imp.setProperty("Info", str_info)
imp.show()
IJ.saveAs("TIF", tif_path)
imp.close()

imp2 = IJ.openImage(tif_path)
info_str = imp2.getInfoProperty()
imp2.show()
print(info_str)



