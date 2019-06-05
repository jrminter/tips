/* wayne_test.js
 * 
 * A script by Wayne Rasband (2019-05-25) here:
 * https://forum.image.sc/t/particleanalyzer-class-option-to-show-bare-outlines/26028/2
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
 * 2019-06-05  JRM  First working version. Note that Wayne's
 *                  version only had 'include' which kept 
 *                  particles touching the border. This statement
 *                  excludes the border particles and includes
 *                  holes.
 *                  
 */

 
importClass(Packages.ij.IJ);
importClass(Packages.ij.plugin.frame.RoiManager);
importClass(Packages.ij.gui.GenericDialog);

IJ.run("Close All");
img = IJ.openImage("http://wsr.imagej.net/images/blobs.gif");
img.show();
IJ.run("Auto Threshold", "method=Default white");
IJ.run("Analyze Particles...", "  show=[Bare Outlines] exclude include in_situ");
