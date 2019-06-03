@String(label="Image Directory", style="") img_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Extension", style="") img_tif
@Integer(label="Gaussian Blurr size") gb_size
/*
   ana_pol4455_bks.groovy

   Analyze POL-4455-16bit-Img01-bks.tif image using the ParticleSizer
   plug-in.

      Date     Who   What
   ==========  ===   ===================================================
   2019-06-02  JRM   Initial groovy prototype. Remember: you want to
                     learn scripting in Groovy...
    
*/

import ij.IJ
import ij.plugin.Duplicator

IJ.log("\\Clear")

def String img_path = img_dir + "/" + img_nam + img_tif

def String str_sigma = sprintf("sigma=%d", gb_size)
IJ.run("Gaussian Blur...", str_sigma)

/*

def String currentDir = new File(".").getAbsolutePath()
def str_size = sprintf( formatted, name, pass )

IJ.log(img_path)

IJ.run("Close All")

imp_ori = IJ.openImage(img_path)
imp_ori.show()

IJ.run("Duplicate...", "title=work")
def imp_wrk = IJ.image
imp_wrk.show()

String formatted = "sigma=$gb_size"
/*
IJ.setAutoThreshold(img, "Default")
IJ.run(img, "Analyze Particles...", "  show=[Bare Outlines] include in_situ")
img.show()
*/
