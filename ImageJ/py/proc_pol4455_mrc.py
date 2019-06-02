@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Extension in", style="") img_mrc
@String(label="Image Extension out", style="") img_tif
@String(label="microns per pixel", style="") um_per_px

from ij import IJ, ImagePlus, WindowManager, Prefs, ImageStack

"""
Load a .mrc file exported by Digital Micrograph.
Scale the 32 bit real data values to 16 bits/per pix
to be stored as a TIFF image. Apply the known scale
factor from DM to the TIF image. Use String parameters
to import the needed values. I was unable to easily
conbert from DM3 to TIF, so I used the MRC format as
an easy intermediate. 

  Date      Who  What
==========  ===  ==================================== 
2019-06-01  JRM  Initial prototype of a Jython script


img_dir = "D:/Data/images/key-test/pol4455"
img_nam = "POL-4455-16bit-Img01-bks"
img_mrc = ".mrc"
img_tif = ".tif"
um_per_px = "0.0015276"
"""

IJ.run("Close All")
IJ.open(img_dir + "/" + img_nam + img_mrc);
imp = IJ.getImage()
ip = imp.getProcessor()
min_v = ip.getMin()
max_v = ip.getMax()
ip.subtract(min_v)
delta = max_v - min_v
factor = 65535/delta;
ip.multiply(factor)
ip.setMinAndMax(0.0,65535.0)
print(factor)
imp.updateAndRepaintWindow()
imp.setTitle(img_nam)
imp.show()
IJ.run("16-bit");
IJ.run("Properties...", "channels=1 slices=1 frames=1 unit=um pixel_width=" + um_per_px + " pixel_height=" + um_per_px + " voxel_depth=1.000000");
IJ.saveAs("TIF", img_dir + "/" + img_nam + img_tif);