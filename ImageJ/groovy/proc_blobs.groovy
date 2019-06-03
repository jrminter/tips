@Integer(label="Min Area px") min_area_px
@Float(label="Min Circularity") min_circ

/*
   proc_blobs.groovy

   A mininal reproducible example of problem with groovy script

      Date     Who   What
   ==========  ===   ===================================================
   2019-06-02  JRM   Initial groovy prototype. use 20 px and 0.5 circ...
    
*/

import ij.IJ
import ij.WindowManager
import ij.plugin.frame.RoiManager

IJ.log("\\Clear")
IJ.run("Close All")

/* use a 'standard' LUT... */ 
IJ.run("Blobs (25K)")

IJ.run("Duplicate...", "title=work")
def imp_wrk = IJ.image
imp_wrk.show()
IJ.setAutoThreshold(imp_wrk, "Default")

IJ.run("Duplicate...", "title=binary")
def imp_thr = IJ.image
imp_thr.setTitle("binary")
IJ.run("Convert to Mask")
imp_thr.show()

def String str_ana2 = sprintf("size=%d-Infinity pixel circularity=%f-1.00 show=Outlines display exclude add in_situ", min_area_px, min_circ)
IJ.run(imp_thr, "Set Measurements...", "area center perimeter fit shape feret's display add redirect=None decimal=3")


IJ.run("Analyze Particles...", str_ana2 )



/*

selectWindow("ROI Manager")


roiManager("Show None");
selectWindow("work");
roiManager("Show All");
roiManager("Show All with labels");
run("Flatten");
*/

