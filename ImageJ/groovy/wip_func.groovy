/*
 * groovy function test 
 *
 *
 */
import ij.*
import ij.plugin.*
import ij.process.*
import java.awt.image.*

def proc_r_g_b_ir_to_stack(imp_r, imp_g,
                           imp_b, imp_ir){
	width = imp_r.getWidth()
	height = imp_r.getHeight()
	stack = new VirtualStack(width, height)
	stack.addSlice(imp_r)
	stack.addSlice(imp_g)
	stack.addSlice(imp_b)
	stack.addSlice(imp_ir)
	img = new ImagePlus("Virtual Stack", stack)
	// this from
	// https://forum.image.sc/t/jython-script-to-combine-images-into-a-single-hyperstack/1130
	// did not fix...
	img.setFileInfo(imp_r.getFileInfo())
	
	return img
}

// start clean
IJ.run("Close All")

// open the demo image as a stack & display
// change the path to your directory
stack = IJ.openImage("/Users/jrminter/Downloads/VS_demo.tif")
stack.show()

// successively extract and display each component...
ip_red = stack.getProcessor(1)
imp_red = new ImagePlus('red', ip_red)
imp_red.show()

ip_green = stack.getProcessor(2)
imp_green = new ImagePlus('green', ip_green)
imp_green.show()

ip_blue = stack.getProcessor(3)
imp_blue = new ImagePlus('blue', ip_blue)
imp_blue.show()

ip_ir = stack.getProcessor(4)
imp_ir = new ImagePlus('ir', ip_ir)
imp_ir.show()

// there really isn't much in the IR... so...
// create an RGB image from the three RGB channels

IJ.run("Merge Channels...", "c1=red c2=green c3=blue")
imp_rgb = IJ.getImage()
imp_rgb.show()

// trying to reconstruct the stack fro r, g,b,
// and ir fails. Haven't figgured out the error

def ImagePlus new_stack = proc_r_g_b_ir_to_stack(imp_red, imp_green,
                                       imp_blue, imp_ir)

//new_stack.show()

