/**
 * Groovy script to convert a binary image into one in which every foreground pixel
 * has a value equal to the area of the (8-connected) region containing it.
 *
 * Why?
 *
 * Well, this gives a way to apply an area-based threshold quickly and intuitively.
 * Simply set a threshold on the area map, and apply it to create a new binary image.
 *
 * Created by Pete Bankhead on 2016-11-22.
 */

import ij.IJ
import ij.ImagePlus
import ij.Prefs
import ij.process.FloatProcessor
import ij.process.FloodFiller

// Request the current image
def imp = IJ.getImage()
def ip = imp.getProcessor()
int w = ip.getWidth()
int h = ip.getHeight()

// For now, be fussy... require a binary image (this could be made more general if needed)
if (!ip.isBinary()) {
    IJ.error("A binary image is needed for this script!")
    return
}

// Figure out what the foreground value is
// (Warning: This could be wrong... consider changing this if the script does the opposite of what's expected)
int foreground = Prefs.blackBackground ? 255 : 0
if (ip.isInvertedLut())
    foreground = 255 - foreground

// Create a labelled image, with foreground pixels set to -1
def ipLabels = new FloatProcessor(w, h)
for (int i = 0; i < w*h; i++) {
    if (ip.get(i) == foreground)
        ipLabels.setf(i, -1f)
}

// Loop through image and flood fill with distinct labels for each object
def ff = new FloodFiller(ipLabels)
float counter = 0
for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
        if (ipLabels.getf(x, y) == -1f) {
            // Increment counter for next label
            counter++
            // Fill connected pixels
            ipLabels.setValue(counter)
            ff.fill8(x, y)
        }
    }
}

// Calculate area of a pixel
def cal = imp.getCalibration()
double pixelArea = cal.pixelWidth * cal.pixelHeight

// Loop again to compute a histogram (really, we could have done this last time... though didn't know how many bins we needed)
double[] histogram = new double[counter+1]
for (int i = 0; i < w*h; i++) {
    int label = (int)ipLabels.getf(i)
    if (label > 0)
        histogram[label] += pixelArea
}

// Finally, loop through and replace each pixel with the computed area
for (int i = 0; i < w*h; i++) {
    int label = (int)ipLabels.getf(i)
    if (label > 0)
        ipLabels.setf(i, (float)histogram[label])
}

// Show the area map
new ImagePlus(imp.getTitle() + " - areas", ipLabels).show()