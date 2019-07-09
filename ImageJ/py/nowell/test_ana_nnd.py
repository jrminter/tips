from ij import IJ, WindowManager
from ij.process import ImageProcessor
from ij.plugin.filter import EDM

import os

def watershedBinaryImage(imp):
    """watershedBinaryImage(imp)
    Perform a watershed segmentation on a binary image

    Parameters
    ----------
    imp: ImagePlus
        The Image Plus of the image to be thresholded

    Return
    ------
    wat: ImagePlus
        The image plus of a segmented image (a duplicate)

    """
    cal = imp.getCalibration()
    wat = imp.createImagePlus()
    ip = imp.getProcessor().duplicate()
    name = imp.getShortTitle() + '-wat'
    wat.setProcessor(name, ip)
    EDM().toWatershed(ip)
    wat.setCalibration(cal)
    wat.setTitle(name)
    return wat

def close_open_non_image_window(str):
    """
    close_open_non_image_window(str)

    Close the specified non-image window
    if it exists

    Parameters
    ==========
    str:    String
            The window to close
    """
    arry = WindowManager.getNonImageTitles()
    for elem in arry:
        if(elem == str):
             IJ.selectWindow(str)
             IJ.run("Close")

IJ.run("Close All")

git_home = os.getenv('GIT_HOME')
rel_dir = "/tips/ImageJ/tif/"
path = git_home + rel_dir
print(path)

img_path = path + "Nuclei.tif"
csv_path = path + "nuclei_nnd.csv"
wat_path = path + "nuclei_detected.png"


imp_ori = IJ.openImage(img_path)
imp_ori.show()

imp_work = imp_ori.duplicate()
imp_work.setTitle("work")
IJ.run(imp_work, "8-bit", "")
imp_work.show()
IJ.setAutoThreshold(imp_work, "Default dark")
ip = imp_work.getProcessor().duplicate()
ip.setThreshold(1791, 1791, ImageProcessor.NO_LUT_UPDATE)
IJ.run(imp_work, "Convert to Mask", "")
imp_work.show()

imp_wat = watershedBinaryImage(imp_work)
imp_wat.show()

IJ.run("Set Measurements...", "centroid redirect=None decimal=3")
IJ.run(imp_wat, "Analyze Particles...", "display clear")
IJ.run(imp_wat, "Nnd ", "")

imp_wat.show()
imp_work.changes = False
imp_work.close()

# This is the NND window, named 'Nearest Neighbor Distances'
win = WindowManager.getActiveWindow()
# print(win)
imp_wat.setTitle("Detected")
imp_wat.show()

IJ.saveAs(imp_wat, "PNG", wat_path)

# close the 'results' window because we don't need X & Y...
# and we need to re-use the name...
close_open_non_image_window("Results")

# get the window with the NND results
win = WindowManager.getWindow("Nearest Neighbor Distances")
# print(win)
# Change the title to 'Results' so we can get IJ to save it as a CSV file
win.setTitle("Results")
IJ.saveAs("Results", csv_path)
