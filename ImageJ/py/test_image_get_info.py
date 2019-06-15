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

# start clean
IJ.run("Close All")

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")

str_info = """Analyst: J. R. Minter
Date: 2019-06-15
Source: Blobs image from NIH.gov
Process: Convert to TIF from GIF
Comment: Notes are cool
"""

imp.setProperty("Info", str_info)
tif_path = img_dir + "/" + "blobs_w_info.tif"
imp.show()
IJ.saveAs("TIF", tif_path)
imp.close()

imp2 = IJ.openImage(tif_path)
info_str = imp2.getInfoProperty()
imp2.show()
print(info_str)



