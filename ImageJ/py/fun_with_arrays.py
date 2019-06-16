"""
fun_with_arrays.py

Adapted from:
http://wiki.cmci.info/documents/120206pyip_cooking/python_imagej_cookbook


"""
from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')

# imports
import os
import jarray
from ij import IJ, ImagePlus
from ij.plugin import RGBStackMerge

git_home = os.getenv("GIT_HOME")
print(git_home)
# start clean
IJ.run("Close All")
# print(dir(os))
"""
# Arrays (Lists)

"Array" is called "List" in python. When using list in
jython, we should be very very careful whether an array
(or list) is Java array or Python list: they both are
set of numbers, but they sometimes require conversion.
This happens especially when you want to use array in
the argument of certain Java methods.

We first start with Python list (or for Kota is 
"python array"):

Concatenate Arrays

"""

a = [1, 2, 3]
b = [4, 5, 6]
a = a + b
print(a)

# Remove redundant elements in an Array

a=[1,2,3,4,5,5] 
a=list(set(a))
a.sort()
print(a)

"""
ImagePlus Array

Some arguments ask for an array of specific type. Since Python
array is not java array, one should generate a Java array. For
this, you could use jarray package.

Note the print below...
array('i', [0, 1, 2, 3])

The second argument specifies the type.

z	boolean
c	char
b	byte
h	short
i	int
l	long
f	float
d	double
"""
 
ja = jarray.array([0, 1, 2, 3], 'i')
print(ja)

"""
What if you want to make a java array of a specific class?
You could then name the class as the second argument.
For example

"""
img_dir = git_home + "/tips/ImageJ/"
imp_blobs_1 = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
IJ.run(imp_blobs_1, "Red", "");
imp_blobs_2 = imp_blobs_1.duplicate()
IJ.run(imp_blobs_2, "Green", "");
imp_blobs_3 = imp_blobs_1.duplicate()
IJ.run(imp_blobs_3, "Blue", "");
img_array = jarray.array([imp_blobs_1, imp_blobs_2, imp_blobs_3], ImagePlus)
gray_stack = RGBStackMerge().mergeHyperstacks(img_array, True)
gray_stack.show()
gray_comp = RGBStackMerge().mergeChannels(img_array, False)
gray_comp.show()

