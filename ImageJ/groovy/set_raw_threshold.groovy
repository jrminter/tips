#@ ImagePlus imp
#@ Integer(label="Lower threshold level", value=0) min
#@ Integer(label="Upper threshold level", value=255) max

import ij.IJ
import ij.plugin.filter.Analyzer

IJ.setRawThreshold(imp, min, max, null)
Analyzer.setOption("BlackBackground", true);
IJ.run("Convert to Mask");