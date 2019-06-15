@String(label="Image Directory", style="") img_dir
@String(label="Image Base Name", style="") img_name
@String(label="Image Ext", style="") img_ext

"""
from:

http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook


"""

from ij.io import TiffDecoder

# using 'mitosis (5d)' sample image. 
src = img_dir + "/" + img_name + img_ext

td = TiffDecoder(img_dir, img_name + img_ext)
imginfos = td.getTiffInfo()
print('Resolution: ', imginfos[0].unit, '/ pixel')
print('x resoluition:', imginfos[0].pixelWidth)
print('y resoluition:', imginfos[0].pixelHeight)
 
# to print various image parameters
print(imginfos[0].description)
print('---')
# to print imgage optional info
print(imginfos[0].info)

"""
For mitosis.tif, should print:


('Resolution: ', u' ', '/ pixel')
('x resoluition:', 0.08850000022125)
('y resoluition:', 0.08850000022125)
ImageJ=1.43d
images=510
channels=2
slices=5
frames=51
hyperstack=true
mode=composite
unit=um
finterval=0.14285714285714285
loop=false
min=1582.0
max=6440.0

---
Drosophila S2 cell expressing GFP-Aurora B and mCherry-tubulin
fusion protein undergoing mitosis. Courtesy of Eric Griffis.

"""