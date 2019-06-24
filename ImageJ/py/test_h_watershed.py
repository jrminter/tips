#@ OpService ops

from ij import IJ
from ij import ImagePlus
from net.imglib2.img.display.imagej import ImageJFunctions
from net.imglib2.img.imageplus import ImagePlusImgs
from net.imglib2.type.numeric import RealType
from net.imglib2.roi import Regions;
from net.imglib2.roi.labeling import LabelRegions, ImgLabeling

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
print type(imp)

# set up and run H-watershed
hMin = 40
thresh = 100
peakFlooding = 100
outputMask = False
allowSplit = True

# H-watershed returns a label map as an ImagePlus
labelmap = ops.run("H_Watershed", imp, hMin, thresh, peakFlooding, outputMask, allowSplit )
labelmap.show()
print "labelmap: ", type(labelmap) # is 32bits

# convert to 16-bits as ImgLabeling expects Int not not Float
IJ.run("Conversions...", " ");
IJ.run(labelmap, "16-bit", "")

# fist convert ImagePlus to img as suggested by curtis:
# from https://forum.image.sc/t/how-to-wrap-any-kind-of-imageplus-to-an-imglib2-img-floattype/178/6
wrapImg = ImageJFunctions.wrap(labelmap)
print "wrapImg: ", type(wrapImg)

# then convert img to ImgLabeling (net.imglib2.roi.labeling.ImgLabeling)
labeling = ImgLabeling(wrapImg)
print "labeling: ", type(labeling)

# get regions from ImgLabeling
regions =  LabelRegions(labeling)
print "regions: ", type(regions)

existing_labels = regions.getExistingLabels()
print "existingLabels: ", type(existing_labels)