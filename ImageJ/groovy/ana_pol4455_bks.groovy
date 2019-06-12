@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Extension", style="") img_tif
@Integer(label="Gaussian Blurr size") gb_size
@String(label="min area nm^2", style="") min_area
@RoiManager rm
@ResultsTable rt

/*
   ana_pol4455_bks.groovy

   Analyze POL-4455-16bit-Img01-bks.tif image using the ParticleSizer
   plug-in.

      Date     Who   What
   ==========  ===   ===================================================
   2019-06-02  JRM   Initial groovy prototype. Remember: you want to
                     learn scripting in Groovy...
   2019-06-11  JRM   Added a string for minimum area, added a watershed
   					 and burned the detected particles into the bks image,
   					 saving the results as a png. Also saved the results
   					 to a .csv file.

   2019-06-12  JRM   1. Fixed hard-coded paths.
                     2. Saved the results in the same folder as the TIF image
                     3. Wrote a function 'close_open_non_image_window' that
                        checks if a non-image window with a speficied name is
                        open and if so, closes the window.

   TODO:
       1 - Think about how to handle a multi-image workflow.
       2 - Consider adding a minimum circularity parameter 
    
*/

import ij.IJ
import ij.WindowManager
import java.lang.*
import ij.plugin.Duplicator

def close_open_non_image_window(str){
	arry = WindowManager.getNonImageTitles()
	if(arry.contains(str) == true){
		IJ.selectWindow(str)
		IJ.run("Close")
	}
}
close_open_non_image_window("Summary")

// Start Clean.
// 1) reset ROI manager and Results table
rm.reset()
rt.reset()
// 2) clear the log
IJ.log("\\Clear")




def String img_path = img_dir + "/" + img_nam + img_tif
println(img_path)

def String img_out = img_dir + "/" + img_nam + "-det-flattened.png"
println(img_out)

def String csv_out = img_dir + "/" + img_nam + "-det.csv"
println(csv_out)

def String str_sigma = sprintf("sigma=%d", gb_size)
println(str_sigma)

// start clean
IJ.run("Close All")
imp_ori = IJ.openImage(img_path)
imp_out = imp_ori.duplicate()


IJ.run(imp_ori, "Gaussian Blur...", str_sigma)
imp_ori.show()

IJ.run("Duplicate...", "title=work")
def imp_wrk = IJ.image
imp_wrk.show()

IJ.setAutoThreshold(imp_wrk, "Default")
IJ.run(imp_wrk, "Convert to Mask", "")
IJ.run(imp_wrk, "Watershed", "")
IJ.run("Set Measurements...", "area mean min perimeter fit shape redirect=None decimal=3")

IJ.run(imp_wrk, "Analyze Particles...", "size=" + min_area + "-Infinity circularity=0.50-1.00 show=Overlay display exclude include summarize add in_situ")
imp_wrk.show()
rt.show()
rt.save(csv_out)
rm.runCommand(imp_out,"Show None");
rm.runCommand(imp_out,"Show All");
rm.runCommand(imp_out,"Show All with labels");
imp2 = imp_out.flatten();
imp2.show()
IJ.saveAs(imp2, "PNG", img_out)



