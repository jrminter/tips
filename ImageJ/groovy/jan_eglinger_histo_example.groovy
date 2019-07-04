#@ ImagePlus imp // take e.g. M51 Galaxy sample image

// Histo example from Jan Eglinger with some JRM mods

import ij.process.StackStatistics
import ij.IJ

simpleStats = new StackStatistics(imp)

println "Image name: ${imp.getTitle()}"

println "Automatic bin size: ${simpleStats.binSize}"
println "Automatic hist min: ${simpleStats.histMin}"
println "Automatic hist max: ${simpleStats.histMax}"

binWidth = 2
min = 0
max = 1024
customStats = new StackStatistics(imp, (max-min)/binWidth as int, min, max)

println "Custom bin size: ${customStats.binSize}"
println "Custom hist min: ${customStats.histMin}"
println "Custom hist max: ${customStats.histMax}"

ij.IJ.run("Histogram", "bins=6000 x_min=0 x_max=12000")
