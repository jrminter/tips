"""
From here:
https://forum.image.sc/t/fiji-imagej-for-loop-for-z-stack-in-subfolders/26963
"""

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

