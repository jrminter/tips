#@ Img input1
#@ Img input2

/*
 * Jan Egliner Example from the IJ Mailing list 2019-06-04
 * 
 */

import sc.fiji.coloc.gadgets.DataContainer
import sc.fiji.coloc.algorithms.Histogram2D

container = new DataContainer(input1, input2, 0, 0, "First", "Second")

hist2d = new Histogram2D("My custom 2D histogram")
hist2d.execute(container)

result = hist2d.getPlotImage()
