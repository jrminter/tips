@String(label="Base Directory", style="") str_dir
@String(label="Image Title", style="") str_img_nam
@String(label="Image Extension", style="", value=".dm3") str_img_ext
@String(label="Saturation", style="", value="0.25") str_sat
@Boolean(label="Close all first", value=False) do_close
"""
test_load_image_bioformats.py

Test a wrapper function to load images using BioFormats

"""
# read in and display ImagePlus object(s)
from loci.plugins import BF
from loci.formats import ImageReader
from loci.formats import MetadataTools
from ij import IJ
from ome.units import UNITS

if do_close:
	IJ.run("Close All")

file = str_dir + "/" + str_img_nam + str_img_ext
imps = BF.openImagePlus(file)
for imp in imps:
	imp.setTitle(str_img_nam)
	imp.show()
	IJ.run("Enhance Contrast", "saturated=" + str_sat);
	reader = ImageReader()
	omeMeta = MetadataTools.createOMEXMLMetadata()
	reader.setMetadataStore(omeMeta)
	reader.setId(file)
	seriesCount = reader.getSeriesCount()
	reader.close()