#@ ImagePlus imp
"""
test_matrices.py

From here: https://imagej.net/Jython_Scripting
Section: Using openCV in Jython

Had to install the ij-OpenCV-plugins site
also added IJPB-plugins site


"""

from ijopencv.ij      import ImagePlusMatConverter
from ijopencv.opencv  import MatImagePlusConverter
from ij               import ImagePlus

imp.show()
 
# Convert ImagePlus (actually the contained ImageProcessor) to Matrix object
imp2mat = ImagePlusMatConverter()
ImMat = imp2mat.toMat(imp.getProcessor())
print ImMat
 
# Convert Matrix object to ImageProcessor
mat2ip = MatImagePlusConverter()
NewIP  = mat2ip.toImageProcessor(ImMat)
NewImp = ImagePlus("Matrix converted back to ImagePlus", NewIP)
print NewImp

NewImp.show()
