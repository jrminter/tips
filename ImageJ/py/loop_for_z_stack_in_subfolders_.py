#@ File (label="Select a directory", style="directory") myDir
from __future__ import print_function
from ij import IJ

"""
loop_for_z_stack_in_subolders_.py

From here:
https://forum.image.sc/t/fiji-imagej-for-loop-for-z-stack-in-subfolders/26963/2

"""

def main():
	root = myDir.getPath() # get the root out the java file object
	
	import os, glob

	# set up bioformats
	from loci.plugins import BF
	from loci.plugins.in import ImporterOptions
	options = ImporterOptions()
	options.setColorMode(ImporterOptions.COLOR_MODE_COMPOSITE)
	options.setGroupFiles(True)  # if the files are named logically if will group them into a stack
  	
	# this will do the maximum intensity projection
	from ij.plugin import ZProjector
	Zproj = ZProjector()

	for path, subdirs, files in os.walk(root):
		# just get the one of the files that matches your image pattern
		flist = glob.glob(os.path.join(path,"*_?.tif"))
		if( flist ):
			file = flist[0]
			print("Processing {}".format(file))
			options.setId(file)
			imp = BF.openImagePlus(options)[0]

			# show the image if you want to see it
			imp.show()

			imp_max = Zproj.run(imp,'max')
			imp_max.show()

			# save the Z projection
			IJ.save(imp_max,file.rsplit('_',1)[0]+'_processed.tif')

			# closes the windows if they are open
			imp.close()
			imp_max.close()
if( __name__ == '__builtin__'):
	main()