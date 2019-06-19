@String(label="Output Directory", style="") out_dir
@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Ext", style="") img_ext

from ij import IJ, WindowManager
from ij.plugin.frame import RoiManager
from ij.measure import ResultsTable

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

# Start clean
IJ.run("Close All")
close_open_non_image_window("Results")
close_open_non_image_window("ROI Manager")

img_path = img_dir + "/" + img_nam + img_ext

imp = IJ.openImage(img_path)
ti = imp.getShortTitle()
# work
imp_work = imp.duplicate()
IJ.setAutoThreshold(imp_work, "Default")
imp_work.show()
IJ.run("Convert to Mask")
imp_work.show()
IJ.run(imp_work, "Watershed", "")

imp_work.setTitle(ti)
imp_work.show()
IJ.run("Set Measurements...", "area mean perimeter shape display add redirect=None decimal=3")
IJ.run(imp_work, "Analyze Particles...", "size=20-Infinity show=Overlay display exclude clear add")
IJ.saveAs("Results", out_dir +  "/blob_results.csv")


