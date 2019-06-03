/*
 * 
 * From: http://ij-plugins.sourceforge.net/plugins/groovy/
 * 
 * An ImageJ1 Groovy script
 * 
 * N.B. IJ1 includes are:
 * 
 * import ij.*
 * import ij.gui.*
 * import ij.io.*
 * import ij.macro.*
 * import ij.measure.*
 * import ij.plugin.*
 * import ij.plugin.filter.*
 * import ij.plugin.frame.*
 * import ij.process.*
 * import ij.text.*
 * import ij.util.*
 * 
*/

import ij.*
import ij.plugin.*

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
/* Note: Duplicator is: ij.plugin.Duplicator  */
imp = new Duplicator().run(imp)
imp.setTitle("blobs")
IJ.run(imp, "Median...", "radius=2")
IJ.run(imp, "Find Edges", "")
imp.setTitle("blob edges")
imp.show()
