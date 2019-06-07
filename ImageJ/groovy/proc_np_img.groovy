@String(label="Image Directory", style="") img_dir
@String(label="Input Image Name", style="") in_img_base_name
@String(label="Intermediate Image Name", style="") int_img_base_name
@String(label="Output Image Name", style="") out_img_base_name

/*
 * proc_np_img.groovy
 * 
 * J. R. Minter 2019-06-06
 * 
 * Demonstrate the problems in processing low contrast
 * TEM image of nanoparticles
 * 
 * See the screen shot for how to set the script parameters
 *
 */

import ij.*
import ij.plugin.*

IJ.run("Close All")

str_inp_tif = img_dir + "/" + in_img_base_name + ".tif"
str_int_tif = img_dir + "/" + int_img_base_name + ".tif"
str_out_png = img_dir + "/" + out_img_base_name + ".png"

println(str_inp_tif)
println(str_int_tif)
println(str_out_png)

imp = IJ.openImage(str_inp_tif)
imp.show()
imp_new = new Duplicator().run(imp)
imp_new.setTitle("work")
/* I tried ROF denoising which required a 32 bit image */
IJ.run(imp_new, "32-bit", "");
IJ.run(imp_new, "ROF Denoise", "theta=70")
/* The use a median filter */
IJ.run(imp_new, "Median...", "radius=2")
/* Convert back to 8 bits per pc*/
IJ.run(imp_new, "8-bit", "")
IJ.saveAs(imp_new, "TIFF", str_int_tif)
/* I had trouble with the recorder here, so had to split the analysis */
IJ.run("Close All")
imp_load = IJ.openImage(str_int_tif)
imp_load.show()
IJ.run(imp_load, "Auto Threshold", "method=Default")
/* Clean up the binary image before running a watershed*/
IJ.run(imp_load, "Erode", "")
IJ.run(imp_load, "Dilate", "")
IJ.run(imp_load, "Open", "")
IJ.run(imp_load, "Close-", "")
IJ.run(imp_load, "Watershed", "")
/* Define the measurements for the particle analysis*/
IJ.run("Set Measurements...", "area perimeter fit shape display redirect=None decimal=3")
IJ.run(imp_load, "Analyze Particles...", "size=20-Infinity pixel circularity=0.50-1.00 show=Overlay display exclude clear add");
imp_load.show()
/* Save the output as a PNG...*/
IJ.saveAs(imp_load, "PNG", str_out_png )
