/*
    A groovy implementation of Brian Northan's RGBtoPCA.ijm
    macro generated from a beanshell script.

       Date     Who  What
    ----------  ---  ------------------------------------------
    2019-06-07  JRM  Initial port. I needed to remember that
                     indexing in groovy starts with 0...
*/

import ij.*
import ij.plugin.*

IJ.run("Close All")

// Use the clown image...
imp = IJ.openImage("http://imagej.nih.gov/ij/images/clown.jpg")
imp2 = imp.duplicate()
def ImagePlus[] channels = ChannelSplitter.split(imp)
// Nota Bene: indexing starts with 0 in groovy
imp_stack = Concatenator.run(channels[0], channels[1], channels[2])
IJ.run(imp_stack, "PCA", "")