from ij import IJ
IJ.run("Close All")
IJ.run ('Blobs (25K)')
imp = IJ.getImage()
imp.setTitle("original")
imp.show()
imp2 = imp.duplicate()
# note this is a new processor with scaled image
ip = imp2.getProcessor().resize (128, 127)
imp2.setProcessor(ip)
imp2.setTitle("resized")
imp2.show()
