/**
 * Request an image from QuPath as an (ImageJ) ImagePlus.
 * The aim is to avoid the (arbitrary) size threshold in v0.1.2 of QuPath.
 *
 * Date: 2018-03-07
 *
 * From here:
 * https://petebankhead.github.io/qupath/scripting/2018/03/07/script-extracting-image-regions-to-imagej.html
 *
 * @author Pete Bankhead
 *
 * Requires the qupath software
 * https://github.com/qupath/qupath/releases/tag/v0.2.0-m2
 * 
 */

import ij.IJ
import qupath.imagej.gui.IJExtension
import qupath.imagej.helpers.IJTools
import qupath.imagej.images.servers.ImagePlusServerBuilder
import qupath.lib.regions.RegionRequest
import qupath.lib.scripting.QPEx

// Access the relevant QuPath data structures
def imageData = QPEx.getCurrentImageData()
def server = imageData.getServer()

// Define how much to scale down - 1.0 means requesting the image at the full resolution
// (I'm defaulting to a large downsample because a small one often won't work...)
double downsample = 40.0

// Request the region
def region = RegionRequest.createInstance(server.getPath(), downsample, 0, 0, server.getWidth(), server.getHeight())

// Check if we are likely to have too many pixels for a Java array
long w = (server.getWidth()/downsample) as int
long h = (server.getHeight()/downsample) as int
long maxPixels = Integer.MAX_VALUE - 5 // Approximate...
if (w * h > maxPixels) {
    downsample = Math.ceil(((long)server.getWidth() * (long)server.getHeight()) / maxPixels)
    print 'This image is going to be too big!  Requires ' + (w * h) + ' pixels, while I can handle at best ' + maxPixels
    print 'Try again setting the downsample to be at least ' + downsample + ' (and preferably more)'
    return
}

// Request an ImagePlus
server = ImagePlusServerBuilder.ensureImagePlusWholeSlideServer(server)
def imp = server.readImagePlusRegion(region).getImage()

// You could save the ImagePlus here if you don't need to show it...
//IJ.save(imp, '/path/to/save.tif')

// Make sure that ImageJ is open
IJExtension.getImageJInstance()
imp.show()