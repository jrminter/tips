"""
open_cv_matrices.py

From here:
https://imagej.net/Jython_Scripting (matrices section)

"""
from org.bytedeco.javacpp.opencv_core   import Mat, CvMat, vconcat, Scalar

## Typical matrices ##
 
# Identity Matrix of size (3x3) and type 8-bit
Id = Mat().eye(3,3,0).asMat()
print("Id")
print Id
print("CvMat(Id)")
print CvMat(Id) # handy to visualise the matrix
 
# Matrix of ones (3x3) 
One = Mat().ones(3,3,0).asMat()
print("One")
print CvMat(One)
 
# Matrix of zeros (3x3) 
Zero = Mat().zeros(3,3,0).asMat()
print("Zero")
print CvMat(Zero)
 
# Custom Matrices
# 1D-Matrix can be initialize from a list
# For 2D (or more) we have to concatenate 1D-Matrices
 
Row1 = Mat([1,2,3,4,5]) # 1D matrix 
Row2 = Mat([6,7,8,9,10])
 
TwoColumn = Mat()              # initialise output
vconcat(Row1, Row2, TwoColumn) # output stored in TwoColumn
print("TwoColumn")
print CvMat(TwoColumn)

# Real scalar can be initiated with a float parameters
print("Create a scalar")
Number = Scalar(5.0)
Number = Scalar(float(5))
print Number
 
# Using an integer as parameter has a different meaning
print("Create an empty scalar")
Empty = Scalar(5) # This initiate an empty Scalar object of size 5
print Empty
 
# Alternatively one can set the other values of the Scalar
# Real scalar can be initiated with a float parameters
print("Create a Real scalar")
Number = Scalar(5.0)
Number = Scalar(float(5))
print Number
 
# Using an integer as parameter has a different meaning
print("Create an empty scalar")
Empty = Scalar(5) # This initiate an empty Scalar object of size 5
print Empty
 
# Alternatively one can set the other values of the Scalar
print("Create a Complex scalar")
Complex = Scalar(1,2,3,4)
print Complex
