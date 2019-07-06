from org.bytedeco.javacpp.opencv_core import Mat, CvMat, vconcat
 
## Typical matrices ##
 
# Identity Matrix of size (3x3) and type 8-bit
Id = Mat().eye(3,3,0).asMat()
print Id
print CvMat(Id) # handy to visualise the matrix
 
# Matrix of ones (3x3) 
One = Mat().ones(3,3,0).asMat()
 
# Matrix of zeros (3x3) 
Zero = Mat().zeros(3,3,0).asMat()
 
# Custom Matrices
# 1D-Matrix can be initialize from a list
# For 2D (or more) we have to concatenate 1D-Matrices
 
Row1 = Mat([1,2,3,4,5]) # 1D matrix 
Row2 = Mat([6,7,8,9,10])
 
TwoColumn = Mat()              # initialise output
vconcat(Col1, Col2, TwoColumn) # output stored in TwoColumn
print CvMat(TwoColumn)