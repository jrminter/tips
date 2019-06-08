from __future__ import with_statement

"""
IMPORTANT: imports from __future__ must go at the top of the file.


Counting cells: difference of Gaussian peak detection with ImgLib2

From: https://services.ini.uzh.ch/~acardona/fiji-tutorial/#measurements-CSV

  Date      Who What
----------  --- --------------------------------------------------
2019-06-08  JRM Cached local copy as cardona_save_meas_csv_peak.py
Counting cells: difference of Gaussian peak detection with ImgLib2

From: https://services.ini.uzh.ch/~acardona/fiji-tutorial/#find-cells-with-DoG

  Date      Who What
----------  --- --------------------------------------------------
2019-06-08  JRM Cached local copy as cardona_DoG_peak_detection.py

"""

from ij import IJ
from ij.gui import PointRoi
from ij.measure import ResultsTable
from net.imglib2.img.display.imagej import ImageJFunctions as IL
from net.imglib2.view import Views
from net.imglib2.algorithm.dog import DogDetection
from jarray import zeros
from operator import add
import csv


# Start clean (JRM)
IJ.run("Close All")

# Load a greyscale single-channel image: the "Embryos" sample image
imp = IJ.openImage("https://imagej.nih.gov/ij/images/embryos.jpg")
# Convert it to 8-bit
IJ.run(imp, "8-bit", "")

# Access its pixel data from an ImgLib2 data structure: a RandomAccessibleInterval
img = IL.wrapReal(imp)

# View as an infinite image, mirrored at the edges which is ideal for Gaussians
imgE = Views.extendMirrorSingle(img)

# Parameters for a Difference of Gaussian to detect embryo positions
calibration = [1.0 for i in range(img.numDimensions())] # no calibration: identity
sigmaSmaller = 15 # in pixels: a quarter of the radius of an embryo
sigmaLarger = 30  # pixels: half the radius of an embryo
extremaType = DogDetection.ExtremaType.MAXIMA
minPeakValue = 10
normalizedMinPeakValue = False

# In the difference of Gaussian peak detection, the img acts as the interval
# within which to look for peaks. The processing is done on the infinite imgE.
dog = DogDetection(imgE, img, calibration, sigmaSmaller, sigmaLarger,
  extremaType, minPeakValue, normalizedMinPeakValue)

peaks = dog.getPeaks()

# Create a PointRoi from the DoG peaks, for visualization
roi = PointRoi(0, 0)
# A temporary array of integers, one per dimension the image has
p = zeros(img.numDimensions(), 'i')
# Load every peak as a point in the PointRoi
for peak in peaks:
	# Read peak coordinates into an array of integers
	peak.localize(p)
	roi.addPoint(imp, p[0], p[1])

imp.setRoi(roi)

# Now, iterate each peak, defining a small interval centered at each peak,
# and measure the sum of total pixel intensity,
# and display the results in an ImageJ ResultTable.
table = ResultsTable()

for peak in peaks:
	# Read peak coordinates into an array of integers
	peak.localize(p)
	# Define limits of the interval around the peak:
	# (sigmaSmaller is half the radius of the embryo)
	minC = [p[i] - sigmaSmaller for i in range(img.numDimensions())]
	maxC = [p[i] + sigmaSmaller for i in range(img.numDimensions())]
	# View the interval around the peak, as a flat iterable (like an array)
	fov = Views.interval(img, minC, maxC)
	# Compute sum of pixel intensity values of the interval
	# (The t is the Type that mediates access to the pixels, via its get* methods)
	s = sum(t.getInteger() for t in fov)
	# Add to results table
	table.incrementCounter()
	table.addValue("x", p[0])
	table.addValue("y", p[1])
	table.addValue("sum", s)

imp.show()
table.show("Embryo intensities at peaks")

# The minimum and maximum coordinates, for each image dimension,
# defining an interval within which pixel values will be summed.

minC = [-sigmaSmaller for i in xrange(img.numDimensions())]
maxC = [ sigmaSmaller for i in xrange(img.numDimensions())]

def centerAt(p, minC, maxC):
	""" Translate the minC, maxC coordinate bounds to the peak. """
	return map(add, p, minC), map(add, p, maxC)

def peakData(peaks, p, minC, maxC):
	""" A generator function that returns all peaks and their pixel sum, 
	one at a time.
	"""
	for peak in peaks:
		peak.localize(p)
		minCoords, maxCoords = centerAt(p, minC, maxC)
		fov = Views.interval(img, minCoords, maxCoords)
		s = sum(t.getInteger() for t in fov)
		yield p, s

# Save as CSV file
with open('/tmp/peaks.csv', 'wb') as csvfile:
	w = csv.writer(csvfile, delimiter=',', quotechar="\"", quoting=csv.QUOTE_NONNUMERIC)
	w.writerow(['x', 'y', 'sum'])
	for p, s in peakData(peaks, p, minC, maxC):
		w.writerow([p[0], p[1], s])

# Read the CSV file into an ROI
roi = PointRoi(0, 0)
with open('/tmp/peaks.csv', 'r') as csvfile:
	reader = csv.reader(csvfile, delimiter=',', quotechar="\"")
	header = reader.next() # advance reader by one line
	for x, y, s in reader:
		roi.addPoint(imp, float(x), float(y))

imp.show()
imp.setRoi(roi)
