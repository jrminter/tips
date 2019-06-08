#@ RoiManager rm
#@ ResultsTable rt

/*   test_img_bks.groovy
 *   
 *   Date        Who  What
 *   ----------  ---  -------
 *   2019-06-07  JRM  Initial prototype as a groovy script.
 *  
 *  A script to process an image from the ImageJ Forum:
 *  https://forum.image.sc/t/request-help-for-brightfield-segmentation/24660
 *  
 *  This is a **very low contrast** image and needed background
 *  correction. I could not get Trainable Weka Segmentation to
 *  properly train. I tried a typical segmentation
 * 
 */

// required import
import ij.*
import ij.plugin.*
import ij.process.*

// start clean
IJ.run("Close All")
imp_ori = IJ.openImage("/Users/jrminter/Downloads/sqzhang.jpeg")
imp_ori.setTitle("original")
imp_ori.show()
// make a background image
imp_bkg = imp_ori.duplicate()
imp_bkg.setTitle("background")
imp_bkg.show()
IJ.run(imp_bkg, "Gaussian Blur...", "sigma=8")
// convert to 32 bit prior to division
IJ.run(imp_ori, "32-bit", "")
IJ.run(imp_bkg, "32-bit", "")
imp_ori.show()
imp_bkg.show()
// Make the bks image
IJ.run("Calculator Plus", "i1=original i2=background operation=[Divide: i2 = (i1/i2) x k1 + k2] k1=1 k2=0 create")
// close images we don't need anymore
imp_ori.changes = false
imp_ori.close()
imp_bkg.changes = false
imp_bkg.close()
// get and rename the background subtracted image
imp_cor = WindowManager.getImage("Result")
imp_cor.setTitle("Background subtracted")
imp_cor.show()
// make a duplicate for segmentation
imp_seg = imp_cor.duplicate()
IJ.run(imp_seg, "Median...", "radius=1")
IJ.setAutoThreshold(imp_seg, "Moments dark")
IJ.run(imp_seg, "Convert to Mask", "")
IJ.run(imp_seg, "Fill Holes", "")
IJ.run(imp_seg, "Fill Holes", "")
// Set up the measurements
IJ.run("Set Measurements...", "area mean perimeter shape display redirect=None decimal=3")
IJ.run(imp_seg, "Analyze Particles...", "size=10-Infinity circularity=0.0-1.00 show=Overlay display exclude clear add")
rt.show("Results")
rm.show()
// Add the ROIs to the original image
rm.moveRoisToOverlay(imp_cor)
imp_out = imp_cor.flatten()
imp_out.setTitle("detected")
imp_out.show()
// save the output as a PNG and CSV file
IJ.saveAs(imp_out, "PNG", "/Users/jrminter/Desktop/patches-segmented.png")
IJ.saveAs("Results", "/Users/jrminter/Desktop/patches-segmented.csv")
// clean up
imp_seg.changes = false
imp_seg.close()
imp_cor.changes = false
imp_cor.close()
rt.reset()
rm.reset()
IJ.selectWindow("Results")
IJ.run("Close")
IJ.selectWindow("ROI Manager")
IJ.run("Close")



