from ij import IJ

from inra.ijpb.binary import BinaryImages
from inra.ijpb.morphology import MinimaAndMaxima3D
from inra.ijpb.morphology import Morphology
from inra.ijpb.morphology import Strel3D
from inra.ijpb.watershed import Watershed
from inra.ijpb.data.image import Images3D

IJ.run("Close All")
imp = IJ.openImage("/Users/jrminter/Downloads/C_5000X_COMP_cal.tif")
imp.show()


call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientRadius", "2")
