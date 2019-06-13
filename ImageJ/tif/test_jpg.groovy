// required import
import ij.IJ
import ij.plugin.ImageCalculator
import ij.WindowManager
import ij.ImageStack
import ij.ImagePlus

IJ.run("Close All")
imp_tif = IJ.openImage("/Users/jrminter/Documents/git/tips/ImageJ/tif/POL-4455-8bit-bks-512.tif")
imp_tif.setTitle("TIF")
imp_tif.show()
imp_jpeg = imp_tif.duplicate()
imp_jpeg.setTitle("JPEG")
imp_jpeg.show()
IJ.run(imp_jpeg, "Save As JPEG... [j]", "jpeg=85");
//IJ.saveAs(imp_jpeg, "Jpeg", "/Users/jrminter/Documents/git/tips/ImageJ/tif/JPEG.jpg")
imp_jpeg.close()
imp_jpeg = IJ.openImage("/Users/jrminter/Documents/git/tips/ImageJ/tif/JPEG.jpg")
imp_jpeg.setTitle("JPEG")
imp_jpeg.show()
ic = new ImageCalculator()
imp_dif = ic.run("Subtract create 32-bit", imp_tif, imp_jpeg)
imp_dif.setTitle("Difference")
imp_dif.show()




IJ.run("Duplicate...", "title=JPEG")
def imp_jpg = IJ.image
imp.jpg.show()

