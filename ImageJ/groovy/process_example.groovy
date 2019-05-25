//
// Example Groovy script to process the current image
// From here:
// http://ij-plugins.sourceforge.net/plugins/groovy/examples.html
//



import ij.IJ

IJ.run("Blobs (25K)")
IJ.run("Duplicate...", "title=work")

process()
 
def process() {
  // Get currently selected image
  def imp = IJ.image
  if (imp == null) {
    // Show error message
    IJ.noImage()
    return
  }
 
  // Do some processing
  IJ.run(imp, "Median...", "radius=4")
  // ...
}