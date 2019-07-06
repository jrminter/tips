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

