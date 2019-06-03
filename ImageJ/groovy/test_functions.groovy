import ij.*
import ij.plugin.*

/* Some test IJ1 functions using Groovy
 * 
 * 
 * 
 */

IJ.run("Close All")

def make_duplicate(imp, new_title) {
	imp_new = new Duplicator().run(imp)
	imp_new.setTitle(new_title)
	return imp_new 
}

def fix_inverted_lut(imp){
	title = imp.getTitle()
	imp_new = new Duplicator().run(imp)
	imp_new.show()
	IJ.run("Invert LUT")
	imp_new.setTitle(title + "_inv_lut")
	imp_new.show()
	return imp_new
}

imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()

wrk = make_duplicate(imp, "work")
wrk.show()

tst = fix_inverted_lut(wrk)
tst.show()

