@String(label="Image Directory", style="") img_dir
@String(label="median filter size", style="") mf_px
@String(label="min_area_px", style="") min_px
@String(label="min circularity", style="") min_circ

from ij import IJ, ImagePlus, WindowManager # , Prefs, ImageStack
from ij.plugin.frame import RoiManager
import time


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


def run_closing(imp):
	IJ.run(imp, "Dilate", "")
	IJ.run(imp, "Erode", "")
	return imp

tic = time.time()	

close_open_non_image_window("Results")
close_open_non_image_window("ROI Manager")
IJ.run("Close All")
imp = IJ.openImage(img_dir + "/nalco-img-04cr.tif")
ti = imp.getShortTitle()
imp.setTitle(ti)
imp.show()

imp_work = imp.duplicate()
imp_work.setTitle("Processed")
imp_work.show()
IJ.run(imp_work, "Median...", "radius=" + mf_px)
IJ.setAutoThreshold(imp_work, "Default dark")
IJ.setAutoThreshold(imp_work, "Huang")
IJ.setRawThreshold(imp_work, 0, 813, None)
imp_work.show()
IJ.run("Make Binary")
IJ.run(imp_work, "Fill Holes", "")
imp_work = run_closing(imp_work)
# imp_work = run_closing(imp_work)
imp_work = run_closing(imp_work)
IJ.run(imp_work, "Dilate", "")
IJ.run("Make Binary")
IJ.run("Fill Holes", "")
imp_work.show()
IJ.run("Watershed", "")
IJ.run("Set Measurements...", "area perimeter fit shape display add redirect=None decimal=3")

ana_str_2 = "size=" + min_px + "-Infinity pixel circularity=" + min_circ + "-1.00 display exclude clear add"
IJ.run("Analyze Particles...", ana_str_2)
imp_work.show()

rm = RoiManager.getInstance()
rm.runCommand(imp_work,"Show All with labels")

imp = WindowManager.getImage(ti)
imp.show()
rm.runCommand(imp,"Show All with labels")
imp.show()

toc = time.time()

delta = toc - tic


print("Elapsed time = %g sec" % (delta))


