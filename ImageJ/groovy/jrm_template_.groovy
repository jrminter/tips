/**
 * Script Name here...
 * 
 * Groovy script to do something
 *
 * Why?
 * 
 * 
 *   Date      Who  What
 * ----------  ---  --------------------------------------------------------------
 * 2019-06-04  JRM  Start Script
 *
 *
 */

import ij.IJ
import ij.ImagePlus
// import ij.ImageStack
import ij.Prefs
// import ij.process.ByteProcessor
// import ij.process.ShortProcessor
// import ij.process.FloatProcessor
// import ij.process.FloodFiller
import ij.plugin.Duplicator
import ij.plugin.frame.RoiManager
import ij.measure.ResultsTable
import ij.WindowManager

// Start clean...
IJ.log("\\Clear")
IJ.run("Close All")