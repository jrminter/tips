/* 
 *  find_edges.groovy
 *  
 *  2019-07-01
 *  
 *   
*/

import ij.*
import ij.plugin.*

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()
imp_dup = new Duplicator().run(imp)
IJ.run(imp_dup, "Median...", "radius=2")
IJ.run(imp_dup, "Find Edges", "")
imp_dup.show()