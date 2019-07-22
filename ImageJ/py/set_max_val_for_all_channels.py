from ij import IJ

def calc_max_val(n_bits):
	"""
	calc_max_val(n_bits)

	calculate the maximum value for an integer with n_bits

	Parameters
	----------
	n_bits	integer
		The number of bits in an integer image. Typically
		8, 12, or 16 in ImageJ

	Returns
	-------
	max_val	double
		The maximum value
	
	"""
	max_val = ((2.0**n_bits) - 1)
	return(max_val)

max_val = calc_max_val(16)

IJ.run("Close All")
imp = IJ.openImage("http://imagej.nih.gov/ij/images/Rat_Hippocampal_Neuron.zip")
# imp.setDefault16bitRange(16)
imp.show()
print(type(imp))


dims = imp.getDimensions()
n_channels = dims[2]
print(n_channels)

for i in range(0, n_channels-1):
	imp.setChannel(i)




	
	# IJ.setMinAndMax(ImagePlus, 0.0, max_val) 
	print(i)

