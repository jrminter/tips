#@ Img input
#@ OpService ops
#@output horizontal
#@output vertical
#@output diagonal
#@output antidiagonal

/*
A script from Jan Eglinger

https://forum.image.sc/t/first-order-statistical-analysis/4551/8

For the Boats sample image, I get the following result:

	Name			Value
1	horizontal		1.6813396646854826
2	vertical		1.6808005706487255
3	diagonal		1.7830193644669707
4	antidiagonal	1.7913779054776953


*/



import net.imagej.ops.image.cooccurrenceMatrix.MatrixOrientation2D

numGreyLevels = 4
distance = 4

horizontal = ops.run("haralick.entropy", input, numGreyLevels, distance, MatrixOrientation2D.HORIZONTAL).get()
vertical = ops.run("haralick.entropy", input, numGreyLevels, distance, MatrixOrientation2D.VERTICAL).get()
diagonal = ops.run("haralick.entropy", input, numGreyLevels, distance, MatrixOrientation2D.DIAGONAL).get()
antidiagonal = ops.run("haralick.entropy", input, numGreyLevels, distance, MatrixOrientation2D.ANTIDIAGONAL).get()