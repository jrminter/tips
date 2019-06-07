"""
guiwitz_particle_analysis_exemplar.py

From https://forum.image.sc/t/convert-threshold-to-mask-in-python-script-question/26341/2

User `guiwitz` (Guillaume Witz, Microscopy Imaging Center, Bern University)
https://www.linkedin.com/in/guillaumewitz/?originalSubdomain=ch
writes:

The little script below creates a mask of the blobs sample
image as an example. I also added a few lines showing how
to include particle analysis directly from the API in a script

 Date       Who  What
----------  ---  ----------------------------------------
2019-06-07  JRM  Assembled example Jython script from the
                 ImageJ Forum
"""


#import packages 
from ij import IJ
from ij.measure import ResultsTable  
from ij.plugin.filter import ParticleAnalyzer

##load blobs image
IJ.run("Blobs (25K)");

##get the image processor, threshold it and update the image
imp = IJ.getImage()
ip = imp.getProcessor()
ip.threshold(100)
imp.setProcessor(ip)

##Particle analysis
new_table = ResultsTable()
#define the actions of the particle analyser
int_params = ParticleAnalyzer.ADD_TO_MANAGER+ParticleAnalyzer.DISPLAY_SUMMARY
int_params = int_params + ParticleAnalyzer.SHOW_RESULTS
#define what properties should be measured
int_measure = ParticleAnalyzer.AREA + ParticleAnalyzer.CIRCULARITY
#run the particle analyzer with size limits min=100px, max=10000000px
pa = ParticleAnalyzer(int_params, int_measure , new_table, 100, 10000000)
pa.analyze(imp);