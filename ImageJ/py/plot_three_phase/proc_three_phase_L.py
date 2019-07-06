"""
proc_three_phase_L.py

2019-07-05 J. R. Minter

This script originated from a discussion on the ImageJ Forum
here:
https://forum.image.sc/t/three-phase-separation-and-analysis/27412

I have some concerns:
1. people are suggesting analyses based on images wit no reported provenance or standards
2. In this case I wanted to check for variation across the field.
   I thought I saw a change in the background areas. I was right.
   I used the opportunity to separate into CIELAB.
3. I would suggest getting some standard test patches and measure
   to validate the analysis procedure/script/setup


"""

from ij import IJ, WindowManager
from ij.gui import Line

IJ.run("Close All")
imp = IJ.openImage("/Users/jrminter/Downloads/three_phase.jpeg")
IJ.run(imp, "RGB to CIELAB", "")
IJ.run("Stack to Images", "")
imp_L = WindowManager.getImage("L")
imp_a = WindowManager.getImage("a")
imp_b = WindowManager.getImage("b")
the_line = Line(0,178,690,178)
the_line.setWidth(20) 
imp_L.setRoi(the_line)
imp_L.show()
IJ.run(imp_L, "Plot Profile", "")
imp_a.setRoi(Line(0,231,690,220))
IJ.run(imp_a, "Plot Profile", "")
imp_a.show()

