import ij.IJ
import ij.ImagePlus
import ij.Prefs
import ij.WindowManager

// Request the current image
def imp = IJ.getImage()
def ip = imp.getProcessor()
int w = ip.getWidth()
int h = ip.getHeight()

println h
// Calculate area of a pixel
def cal = imp.getCalibration()
double pixelArea = cal.pixelWidth * cal.pixelHeight
println pixelArea
