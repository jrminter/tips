import ij.IJ
import loci.plugins.in.ImporterOptions
import loci.plugins.BF

/**
 * Import the files using BioFormats
 * @param individual_file       Path to the file to open
 * @return imps                 ImagePlus of the opened file
 **/
def BFImport(String individual_file)
{
    options = new ImporterOptions()
    options.setId(individual_file)
    options.setColorMode(ImporterOptions.COLOR_MODE_COMPOSITE)
    imps = BF.openImagePlus(options)
    return imps
}

IJ.run("Close All")

imps = BFImport("/Users/jrminter/Documents/git/tips/ImageJ/tif/test.tif")
println imps.getClass()

imp = imps[0]
imp.show()
println imp.getClass()