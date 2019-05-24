@String(label="Base Directory", style="") str_dir
@String(label="Image Title", style="") str_img_nam
@String(label="Image Extension", style="", value=".tif") str_img_ext
file = str_dir + "/" + str_img_nam + str_img_ext
# read in and display ImagePlus object(s)
from loci.plugins import BF
from loci.formats import ImageReader
from loci.formats import MetadataTools
from ij import IJ
from ome.units import UNITS

imps = BF.openImagePlus(file)
for imp in imps:
    imp.show()
    reader = ImageReader()
    omeMeta = MetadataTools.createOMEXMLMetadata()
    reader.setMetadataStore(omeMeta)
    reader.setId(file)
    seriesCount = reader.getSeriesCount()
    reader.close()
    # print out series count from two different places (they should always match!)
    imageCount = omeMeta.getImageCount()
    IJ.log("Total # of image series (from BF reader): " + str(seriesCount))
    IJ.log("Total # of image series (from OME metadata): " + str(imageCount))
    physSizeX = omeMeta.getPixelsPhysicalSizeX(0)
    physSizeY = omeMeta.getPixelsPhysicalSizeY(0)
    physSizeZ = omeMeta.getPixelsPhysicalSizeZ(0)
    IJ.log("Physical calibration:")
    if (physSizeX is not None):
    	IJ.log("\tX = " + str(physSizeX.value()) + " " + physSizeX.unit().getSymbol()
		+ " = " + str(physSizeX.value(UNITS.MICROM)) + " microns")
	if (physSizeY is not None):
		IJ.log("\tY = " + str(physSizeY.value()) + " " + physSizeY.unit().getSymbol()
		+ " = " + str(physSizeY.value(UNITS.MICROM)) + " microns")
	if (physSizeZ is not None):
		IJ.log("\tZ = " + str(physSizeZ.value()) + " " + physSizeZ.unit().getSymbol()
		+ " = " + str(physSizeZ.value(UNITS.MICROM)) + " microns")