from ij import IJ
from net.imglib2.img.display.imagej import ImageJFunctions as IL
from net.imglib2.view import Views

# Load an image (of any dimensions) such as the clown sample image
imp = IJ.getImage()

# Convert to 8-bit if it isn't yet, using macros
IJ.run(imp, "8-bit", "")

# Access its pixel data from an ImgLib2 RandomAccessibleInterval
img = IL.wrapReal(imp)

# View as an infinite image, with a value of zero beyond the image edges
imgE = Views.extendZero(img)

# Limit the infinite image with an interval twice as large as the original,
# so that the original image remains at the center.
# It starts at minus half the image width, and ends at 1.5x the image width.
minC = [int(-0.5 * img.dimension(i)) for i in range(img.numDimensions())]
maxC = [int( 1.5 * img.dimension(i)) for i in range(img.numDimensions())]
imgL = Views.interval(imgE, minC, maxC)

# Visualize the enlarged canvas, so to speak
imp2 = IL.wrap(imgL, imp.getTitle() + " - enlarged canvas") # an ImagePlus
imp2.show()