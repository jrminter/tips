/* 
 *  line_profile_rgb_example.groovy
 *  
 *  2019-07-02
 *  
 *   
*/

import ij.*
import ij.plugin.*
import ij.gui.*

IJ.run("Close All");
imp = IJ.openImage("/Users/jrminter/Downloads/blue_gradient.jpeg");
IJ.run(imp, "Line Width...", "line=60");
imp.setRoi(new Line(0,52,420,48));
IJ.run(imp, "Plot Profile", "");
imp.setTitle("Plot Profile RGB")
imp.show();


