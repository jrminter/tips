from ij import IJ

# IJ.close("\\Others");

def close_others():
	IJ.runMacro("close(\"\\\\Others\")")


close_others()
