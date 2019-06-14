@ResultsTable rt
import ij.IJ
import ij.WindowManager
import java.lang.*
import ij.plugin.Duplicator
import com.jrminter.close_open_non_image_window

IJ.run("Close All")
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp.show()
rt.show()

// test a call
close_open_non_image_window("Results")
