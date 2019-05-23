#@ OpService ops
#@ ImgPlus inputData
#@ double dSize
#@OUTPUT ImgPlus(label="Filtered") filtered

// This script takes an input image, applies a gaussian filter

import net.imglib2.type.numeric.real.DoubleType

// Convert the input image
img32 = ops.convert().int32(inputData)

// Apply the gaussian filter
filtered=ops.filter().gauss(img32, [dSize, dSize] as double[])

