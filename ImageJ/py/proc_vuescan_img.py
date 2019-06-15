@String(label="Image Directory", style="") img_dir

"""
Rewrote in python from:
https://forum.image.sc/t/create-tif-with-4-channels-per-pixel/26457/8

The only thing I can't figure out how to do is apply
a different LUT to each slice in a stack...

"""

from ij import IJ, ImagePlus, ImageStack

# start clean
IJ.run("Close All")

# returned is an array of ImagePlus, in many cases just one imp.
src = img_dir + "/VS_demo.tif"
stack = IJ.openImage(src)
stack.show()

ip_red = stack.getProcessor(1)
imp_red = ImagePlus('red', ip_red)
imp_red.show()
imp_r = imp_red.duplicate()
# IJ.saveAs(imp_red, "Tiff", img_dir + "/R.tif")

ip_green = stack.getProcessor(2)
imp_green = ImagePlus('green', ip_green)
imp_green.show()
imp_g = imp_green.duplicate()

ip_blue = stack.getProcessor(3)
imp_blue = ImagePlus('blue', ip_blue)
imp_blue.show()
imp_b = imp_blue.duplicate()

ip_ir = stack.getProcessor(4)
imp_ir = ImagePlus('ir', ip_ir)
imp_ir.show()
imp_irr = imp_ir.duplicate()

# there really isn't much in the IR... so...
# create an RGB image from the three RGB channels

IJ.run("Merge Channels...", "c1=red c2=green c3=blue")
imp_rgb = IJ.getImage()
imp_rgb.show()

width = imp_red.getWidth()
height = imp_red.getHeight()
stack = ImageStack(width, height)
stack.addSlice("red", ip_red)
stack.addSlice("green", ip_green)
stack.addSlice("blue", ip_blue)
stack.addSlice("ir", ip_ir)

imp_stack = ImagePlus("IJ Stack", stack)
IJ.run(imp_stack, "Grays", "")
imp_stack.show()

"""
output for ImageMagick - Jossie noted this would work...

from:
https://forum.image.sc/t/create-tif-with-4-channels-per-pixel/26457/10

runs from dir as
./magick.sh

$ tiffinfo magick.tif
TIFF Directory at offset 0x250d78 (2428280)
  Image Width: 657 Image Length: 462
  Bits/Sample: 16
  Compression Scheme: None
  Photometric Interpretation: RGB color
  Extra Samples: 1<unassoc-alpha>
  FillOrder: msb-to-lsb
  Orientation: row 0 top, col 0 lhs
  Samples/Pixel: 4
  Rows/Strip: 462
  Planar Configuration: single image plane
  Page Number: 0-1
  ImageDescription: ImageJ=1.52n
min=1212.0
max=59384.0

  White Point: 0.3127-0.329
  PrimaryChromaticities: 0.640000,0.330000,0.300000,0.600000,0.150000,0.060000

"""
IJ.saveAs(imp_r, "Tiff", img_dir + "/R.tif")
IJ.saveAs(imp_g, "Tiff", img_dir + "/G.tif")
IJ.saveAs(imp_b, "Tiff", img_dir + "/B.tif")
IJ.saveAs(imp_irr, "Tiff", img_dir + "/IR.tif")

IJ.saveAs(imp_stack, "Tiff", img_dir + "/IJ_stack.tif")

"""
$ tiffinfo IJ_stack.tif
TIFFReadDirectory: Warning, Unknown field with tag 50838 (0xc696) encountered.
TIFFReadDirectory: Warning, Unknown field with tag 50839 (0xc697) encountered.
TIFF Directory at offset 0x8 (8)
  Subfile Type: (0 = 0x0)
  Image Width: 657 Image Length: 462
  Bits/Sample: 16
  Compression Scheme: None
  Photometric Interpretation: min-is-black
  Samples/Pixel: 1
  Rows/Strip: 462
  Planar Configuration: single image plane
  ImageDescription: ImageJ=1.52n
images=4
slices=4
loop=false
min=1212.0
max=59384.0

  Tag 50838: 12,6,10,8,4
  Tag 50839: 73,74,73,74,108,97,98,108,0,0,0,4,0,114,0,101,0,100,0,103,0,114,0,101,0,101,0,110,0,98,0,108,0,117,0,101,0,105,0,114
TIFF Directory at offset 0x250e8c (2428556)
  Subfile Type: (0 = 0x0)
  Image Width: 657 Image Length: 462
  Bits/Sample: 16
  Compression Scheme: None
  Photometric Interpretation: min-is-black
  Samples/Pixel: 1
  Rows/Strip: 462
  Planar Configuration: single image plane
  ImageDescription: ImageJ=1.52n
images=4
slices=4
loop=false
min=1212.0
max=59384.0

TIFF Directory at offset 0x250f0a (2428682)
  Subfile Type: (0 = 0x0)
  Image Width: 657 Image Length: 462
  Bits/Sample: 16
  Compression Scheme: None
  Photometric Interpretation: min-is-black
  Samples/Pixel: 1
  Rows/Strip: 462
  Planar Configuration: single image plane
  ImageDescription: ImageJ=1.52n
images=4
slices=4
loop=false
min=1212.0
max=59384.0

TIFF Directory at offset 0x250f88 (2428808)
  Subfile Type: (0 = 0x0)
  Image Width: 657 Image Length: 462
  Bits/Sample: 16
  Compression Scheme: None
  Photometric Interpretation: min-is-black
  Samples/Pixel: 1
  Rows/Strip: 462
  Planar Configuration: single image plane
  ImageDescription: ImageJ=1.52n
images=4
slices=4
loop=false
min=1212.0
max=59384.0

"""


