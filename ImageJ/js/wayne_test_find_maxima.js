/* wayne_test_find_maxima.js
 * 
 * A script by Wayne Rasband (2019-05-30) here:
 * https://forum.image.sc/t/maximumfinder-getmaxima-always-return-0-with-image1-52n/24349/3
 * 
 * To get this to run on Fiji, I (John Minter) needed
 * to add the first importClass line.
 * 
 * I added the three lines as recommended here:
 * https://imagej.net/JavaScript_Scripting
 * even though I only really needed the first...
 * 
 *    Date     Who  What
 * ==========  ===  ========================================
 * 2019-06-05  JRM  First working version. Requires IJ1
 *                  version 1.5.2.0
 *                  
 * 
 *                  
 */

 
importClass(Packages.ij.IJ);
importClass(Packages.ij.plugin.frame.RoiManager);
importClass(Packages.ij.gui.GenericDialog);
importClass(Packages.ij.plugin.filter.MaximumFinder);

imp = IJ.openImage("http://wsr.imagej.net/images/Dot_Blot.jpg");
ip = imp.getProcessor();
ip.invert();
prominence = 35;
excludeOnEdge=false;
polygon = new MaximumFinder().getMaxima(ip, prominence, excludeOnEdge);
print("npoints="+polygon.npoints);

// Add this example from:
// https://forum.image.sc/t/find-maxmia-sorted/10986/2
// Create an empty image
IJ.newImage("Untitled", "8-bit black", 100, 100, 1);

// Create five spots with different intensities
IJ.makeOval(20, 20, 5, 5);
IJ.setForegroundColor(10, 10, 10);
IJ.run("Fill", "slice");
IJ.makeOval(75, 10, 5, 5);
IJ.setForegroundColor(50, 50, 50);
IJ.run("Fill", "slice");
IJ.makeOval(10, 75, 5, 5);
IJ.setForegroundColor(80, 80, 80);
IJ.run("Fill", "slice");
IJ.makeOval(70, 60, 5, 5);
IJ.setForegroundColor(120, 120, 120);
IJ.run("Fill", "slice");
IJ.makeOval(80, 80, 5, 5);
IJ.setForegroundColor(200, 200, 200);
IJ.run("Fill", "slice");
IJ.run("Select None");

// Blur a bit
IJ.run("Gaussian Blur...", "sigma=2");

// Let's get a list of the maxima
IJ.run("Find Maxima...", "noise=2 output=List");
IJ.run("Enhance Contrast", "saturated=0.35");
