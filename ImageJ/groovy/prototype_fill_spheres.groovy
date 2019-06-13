/*	prototype_fill_spheres.groovy
 * 	
 * 	A groovy script to model circular particle measurement.
 * 	The idea is to repeat Roger Button's approach from 1999.
 * 	
 * 	Fiji/IJ has some peculiar syntax that makes this difficult
 * 	to implement.
 * 	
 * 	TO DO:
 * 	
 * 	1.	Need to generate diameters with a logarithmic GMD
 * 		Considering importing a list in from R...
 * 		
 * 	2.	Figure out how to efficiently generate the images.
 * 		We need to have none touching particles and would 
 * 		like to get 50+ particles per image.
 * 		
 * 	3.	I plan to output image#, part #, x-cent, y-cent, ecd,
 * 		circ, solidity, aspect ratio,... as a .csv file.
 * 		
 * 	4.	A plugin might be better... Would be nice to get some
 * 		help from Jan Eglinger...
 * 	
 * 
 * 
 */

// required import
import ij.IJ
import ij.ImageStack
import ij.ImagePlus
import ij.gui.Line
import ij.gui.OvalRoi
import ij.gui.PolygonRoi
import java.awt.Polygon
import java.util.Arrays 
import ij.process.ByteProcessor

img_size = 1024;

def add_circ_to_img(imp, x, y, diam){
	Line.setWidth(1);
	imp.setRoi(new OvalRoi(x,y,diam,diam));
	IJ.run("Colors...", "foreground=black background=white selection=white");
	IJ.run(imp, "Fill", "slice");
	// set the ROI off screen at the end
	imp.setRoi(new OvalRoi(-10,-10,0,0));
}
IJ.run("Close All");

imp = IJ.createImage("test_image", "8-bit white", img_size, img_size, 1);
IJ.run(imp, "Properties...", "channels=1 slices=1 frames=1 unit=nm pixel_width=1.0 pixel_height=1.0 voxel_depth=1.0");
imp.show()


add_circ_to_img(imp, 254, 254, 50);
add_circ_to_img(imp, 50, 50, 30);
add_circ_to_img(imp, 90, 90, 80);
add_circ_to_img(imp, 400, 405, 100);
imp.show();
imp.flatten();
IJ.run("8-bit");
IJ.setAutoThreshold(imp, "Default");
IJ.run(imp, "Make Binary", "");
IJ.run("Convert to Mask");
imp.show();
IJ.run("Set Measurements...", "area perimeter shape display redirect=None decimal=3");
IJ.run(imp, "Analyze Particles...", "  circularity=0.50-1.00 display exclude clear add");




