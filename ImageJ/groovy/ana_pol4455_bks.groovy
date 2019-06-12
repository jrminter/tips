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
   					 toa .csv file.

   					 TODO: 1 - remove hard-coded paths.
   					       2. think about how to handle a multi-image workflow.
    
*/

import ij.IJ
import ij.plugin.Duplicator

// Start Clean. 1) reset ROI manager and Results table and clear the log
rm.reset()
rt.reset()

IJ.log("\\Clear")

def String img_path = img_dir + "/" + img_nam + img_tif
println(img_path)

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

IJ.run(imp_wrk, "Analyze Particles...", "size="+min_area+"-Infinity circularity=0.50-1.00 show=Overlay display exclude include summarize add in_situ")
imp_wrk.show()
rt.show()
rt.save("C:/Users/jrminter/Documents/git/tips/ImageJ/groovy/pol4455_bks_results.csv");
rm.runCommand(imp_out,"Show None");
rm.runCommand(imp_out,"Show All");
rm.runCommand(imp_out,"Show All with labels");
imp2 = imp_out.flatten();
imp2.show()
IJ.saveAs(imp2, "PNG", "C:/Users/jrminter/Documents/git/tips/ImageJ/groovy/POL-4455-16bit-Img01-bks-flattened.png");

