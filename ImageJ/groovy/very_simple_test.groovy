import ij.IJ
import ij.ImagePlus

ver = IJ.getVersion()
println(ver)
ImagePlus im = IJ.createImage("test", 512, 512, 1, 8)

im.show()