"""

test_enhance_contrast.py

From here:
https://forum.image.sc/t/jython-enhance-contrast-function-does-not-apply/27847

"""

from ij import IJ
from ij.gui import WaitForUserDialog

# open blobs sample image
IJ.run ('Blobs (25K)')
imp = IJ.getImage()

# and reduce its contrast
ip = imp.getProcessor()
ip.multiply (0.5)
imp.setTitle ('blobs_div2')

# make a duplicate
impenh = imp.duplicate()
impenh.setTitle ('blobs_div2_enh')
impenh.show()

# run "Enhance Contrast..."
IJ.run(impenh, "Enhance Contrast...", "saturated=0.35")

# for comparison, make another duplicate
impadj = imp.duplicate()
impadj.setTitle ('blobs_div2_adj')
impadj.show()

# and run "Adjust Brightness/Contrast" -- needs some user clicks
IJ.selectWindow ('blobs_div2_adj')
IJ.run ('Brightness/Contrast...')
WaitForUserDialog ('Mouse clicks needed!', 'Click "Auto" and "Apply" in "B&C" window').show()
IJ.selectWindow ('B&C')
IJ.run ('Close')

# compare pixel values
print 'imp: getPixel (65, 40) =', imp.getProcessor().getPixel (65, 40)
print 'enh: getPixel (65, 40) =', impenh.getProcessor().getPixel (65, 40)
print 'adj: getPixel (65, 40) =', impadj.getProcessor().getPixel (65, 40)

# compare display ranges
print 'imp: getDisplayRangeMin,Max() =', imp.getDisplayRangeMin(), imp.getDisplayRangeMax()
print 'enh: getDisplayRangeMin,Max() =', impenh.getDisplayRangeMin(), impenh.getDisplayRangeMax()
print 'adj: getDisplayRangeMin,Max() =', impadj.getDisplayRangeMin(), impadj.getDisplayRangeMax()

# save as .tifs
IJ.saveAsTiff (imp, 'blobs_div2')
IJ.saveAsTiff (impenh, 'blobs_div2_enh')
IJ.saveAsTiff (impadj, 'blobs_div2_adj')
