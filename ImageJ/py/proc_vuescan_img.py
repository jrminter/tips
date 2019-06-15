@String(label="Image Directory", style="") img_dir

"""
Rewrote in python from:
https://forum.image.sc/t/create-tif-with-4-channels-per-pixel/26457/8

The only thing I can't figure out how to do is apply
a different LUT to each slice in a stack...

"""

from ij import IJ, ImagePlus, ImageStack

# start clean
IJ.run("Close All")

# returned is an array of ImagePlus, in many cases just one imp.
src = img_dir + "/VS_demo.tif"
stack = IJ.openImage(src)
stack.show()

ip_red = stack.getProcessor(1)
imp_red = ImagePlus('red', ip_red)
imp_red.show()

ip_green = stack.getProcessor(2)
imp_green = ImagePlus('green', ip_green)
imp_green.show()

ip_blue = stack.getProcessor(3)
imp_blue = ImagePlus('blue', ip_blue)
imp_blue.show()

ip_ir = stack.getProcessor(4)
imp_ir = ImagePlus('ir', ip_ir)
imp_ir.show()

# there really isn't much in the IR... so...
# create an RGB image from the three RGB channels

IJ.run("Merge Channels...", "c1=red c2=green c3=blue")
imp_rgb = IJ.getImage()
imp_rgb.show()

width = imp_red.getWidth()
height = imp_red.getHeight()
stack = ImageStack(width, height)
stack.addSlice("red", ip_red)
stack.addSlice("green", ip_green)
stack.addSlice("blue", ip_blue)
stack.addSlice("ir", ip_ir)

imp_stack = ImagePlus("IJ Stack", stack)
IJ.run(imp_stack, "Grays", "")
imp_stack.show()

imp_stack.show()

