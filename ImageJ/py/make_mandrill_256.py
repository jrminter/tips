"""
make_mandrill_256.py

Make a cropped Mandrill Image

Date        Who  What
----------  ---  ----------------------------------------------------
2019-06-16  JRM  Initial adaptation. Use the HOME environment
                 variable to get the start of the path


"""

from ij import IJ
import os

home_dir = os.getenv("HOME")
print(home_dir)
IJ.run("Close All")
imp = IJ.openImage(home_dir + "/dat/images/key-test/mandrill.tif");
imp.setRoi(0,0,256,256);
imp.show()
IJ.run("Crop")
imp.show()
IJ.saveAs(imp, "Tiff", home_dir + "/Documents/git/tips/ImageJ/tif/mandrill_256.tif");
