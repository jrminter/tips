import loci.formats.FormatTools
import loci.formats.ImageTools
import loci.common.DataTools

import ij.IJ
import ij.ImagePlus
import ij.ImageStack
import ij.process.ByteProcessor
import ij.process.ShortProcessor
import ij.plugin.frame.RoiManager
import ij.measure.ResultsTable
import ij.WindowManager

/*
 * For now be sure to close any open ROI Manager and Results windows before running
 */
 
IJ.log("\\Clear")
IJ.run("Close All")
IJ.run("Blobs (25K)")
imp = IJ.getImage()
imp.setTitle("Blobs")
imp.show()
IJ.run("8-bit")
IJ.run("Duplicate...", "title=work")
work = IJ.getImage()
work.setTitle("Work")
IJ.run(work, "Auto Threshold", "method=Default")
IJ.run("Convert to Mask")
IJ.run("Watershed")
IJ.run(work, "Analyze Particles...", "size=10-Infinity pixel display clear add summarize")

IJ.selectWindow("Summary")
IJ.run("Close")

IJ.selectWindow("Blobs")

/* 
roiManager("Show All with labels")
IJ.run("Flatten")



IJ.selectWindow("Results")
IJ.run("Close")
IJ.selectWindow("ROI Manager")
IJ.run("Close")

*/