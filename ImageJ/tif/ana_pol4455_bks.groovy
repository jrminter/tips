@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Extension", style="") img_tif
@Integer(label="Median Filter size") mf_size
@Integer(label="Min Area px") min_area_px
@Float(label="Min Circularity") min_circ


/*
   ana_pol4455_bks.groovy

   Analyze POL-4455-16bit-Img01-bks.tif image using the ParticleSizer
   plug-in.

      Date     Who   What
   ==========  ===   ===================================================
   2019-06-02  JRM   Initial groovy prototype. Remember: you want to
                     learn scripting in Groovy... It is important that
                     the image calibration be in nm/px NOT microns to
                     get sufficient precison in area.  Has problems...
    
*/

import ij.IJ
import ij.plugin.Duplicator
import ij.plugin.filter.ParticleAnalyzer
import ij.plugin.filter.Analyzer
import ij.process.ImageProcessor
import ij.measure.ResultsTable
import ij.plugin.frame.RoiManager

IJ.log("\\Clear")
IJ.run("Close All")

def String img_path = img_dir + "/" + img_nam + img_tif

imp_ori = IJ.openImage(img_path)
imp_ori.show()

IJ.run("Duplicate...", "title=work")
def imp_wrk = IJ.image
imp_wrk.show()


/* The median filter preserves edges... */
def String str_radius = sprintf("radius=%d", mf_size)
IJ.run("Median...", str_radius)
IJ.setAutoThreshold(imp_wrk, "Default")
IJ.run("Convert to Mask");


IJ.run("Erode")
IJ.run("Dilate")
IJ.run("Watershed")

imp_det = ij.IJ.getImage()

def String str_ana2 = sprintf("size=%d-Infinity pixel circularity=%f-1.00 show=Outlines display exclude add in_situ", min_area_px, min_circ)

IJ.run("Set Measurements...", "area center perimeter fit shape feret's display add redirect=None decimal=3");
IJ.run("Analyze Particles...", str_ana2 )

IJ.saveAs("Results", "/Users/jrminter/Documents/git/tips/ImageJ/csv/pol4455_groovy.csv");
IJ.selectWindow("Results") 
IJ.run("Close")

IJ.selectWindow(img_nam + img_tif)
ij.plugin.frame.RoiManager("Show All with labels")
IJ.run("Flatten");


IJ.selectWindow("ROI Manager")
IJ.run("Close")

/* 
IJ.roiManager("Show All with labels")
IJ.run("Flatten")
*/



