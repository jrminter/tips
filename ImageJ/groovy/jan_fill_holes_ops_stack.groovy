#@ Img input
#@ OpService ops
#@output filled2d
#@output filled3d

/*  Script by Jan Ellinger from this Form post:
 *  https://forum.image.sc/t/fill-holes-ops-stack/26416/10
 *  
 *  Input image:  ImageJ/tif/binary_image_XYZT.tif
 * 
 */

// convert input image to BitType
binary = ops.run("convert.bit", input)

// fill holes slice-wise 2d in the first two dimensions (usually x and y)
filled2d = ops.run("create.img", binary)
fillOp = ops.op("fillHoles", filled2d)

ops.run("slice", filled2d, binary, fillOp, [0,1] as int[])

// fill holes 3d
filled3d = ops.run("fillHoles", binary)
