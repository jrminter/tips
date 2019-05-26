/* ParticleAnalyzer class option to show bare outlines

   Wayne Rasband wrote:
   https://forum.image.sc/t/particleanalyzer-class-option-to-show-bare-outlines/26028/2
    
*/

import ij.IJ

IJ.run("Close All")
img = IJ.openImage("http://wsr.imagej.net/images/blobs.gif")
IJ.setAutoThreshold(img, "Default")
IJ.run(img, "Analyze Particles...", "  show=[Bare Outlines] include in_situ")
img.show()