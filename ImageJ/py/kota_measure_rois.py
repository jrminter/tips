"""
kota_measure_rois.py

From:
https://github.com/miura/HTManalysisCourse

Tif images do not seem to be available

"""


import os, sys
from ij.plugin.filter import ParticleAnalyzer as PA

# size of just nuclear region. In pixels.
RIMSIZE = 15

def roiRingGenerator(r1):
	""" Create a band of ROI outside the argument ROI.
	See Liebel (2003) Fig. 1
	"""
	#r1 = imp.getRoi()
	r2 = RoiEnlarger.enlarge(r1, RIMSIZE)
	sr1 = ShapeRoi(r1)
	sr2 = ShapeRoi(r2)
	return sr2.not(sr1)

def roiEnlarger(r1):
	""" Enlarges ROI by a defined iterations.
	"""
	return ShapeRoi(RoiEnlarger.enlarge(r1, RIMSIZE))

def measureROIs(imp, measOpt, thisrt, roiA, backint, doGLCM):		
	""" Cell-wise measurement using ROI array. 
	"""
	analObj = Analyzer(imp, measOpt, thisrt)
	for index, r in enumerate(roiA):
		imp.deleteRoi()
		imp.setRoi(r)
		analObj.measure()
		maxint = thisrt.getValue('Max', thisrt.getCounter()-1)
		saturation = 0
		if ( maxint + backint) >= 4095:
			saturation = 1
			if (VERBOSE):
				print 'cell index ', index, 'maxint=', maxint
		thisrt.setValue('CellIndex', thisrt.getCounter()-1, index)
		thisrt.setValue('Saturation', thisrt.getCounter()-1, saturation)
	if (doGLCM):
		imp.deleteRoi()
		#measureTexture(imp, thisrt, roiA)

## loading files
root = '/Volumes/data/bio-it_centres_course/data/course'
fileNuc = 'dapiSegmented.tif'
filepm = 'pm-647BackSub.tif'
filevsvg = 'vsvg-cfpBackSub.tif'

nucfull = os.path.join(root, fileNuc)
pmfull = os.path.join(root, filepm)
vsvgfull = os.path.join(root, filevsvg)
impfilteredNuc = IJ.openImage(nucfull)
impPM = IJ.openImage(pmfull)
impVSVG = IJ.openImage(vsvgfull)

wnumber = '00005'

rtallcellPM = ResultsTable()
rtjnucVSVG = ResultsTable()
rtallcellVSVG = ResultsTable()


intmax = impfilteredNuc.getProcessor().getMax()
if intmax == 0:
	#return rtallcellPM, rtjnucVSVG, rtallcellVSVG
	exit()

impfilteredNuc.getProcessor().setThreshold(1, intmax, ImageProcessor.NO_LUT_UPDATE)
nucroi = ThresholdToSelection().convert(impfilteredNuc.getProcessor())
nucroiA = ShapeRoi(nucroi).getRois()
#print nucroiA
allcellA = [roiEnlarger(r) for r in nucroiA]
jnucroiA = [roiRingGenerator(r) for r in nucroiA]

measOpt = PA.AREA + PA.MEAN + PA.CENTROID + PA.STD_DEV + PA.SHAPE_DESCRIPTORS + PA.INTEGRATED_DENSITY + PA.MIN_MAX +\
		PA.SKEWNESS + PA.KURTOSIS + PA.MEDIAN + PA.MODE

## All Cell Plasma Membrane intensity
measureROIs(impPM, measOpt, rtallcellPM, allcellA, 0, True)
meanInt_Cell = rtallcellPM.getColumn(rtallcellPM.getColumnIndex('Mean'))
print "Results Table rownumber:", len(meanInt_Cell)
# JuxtaNuclear VSVG intensity 
measureROIs(impVSVG, measOpt, rtjnucVSVG, jnucroiA, 0, False)		
meanInt_jnuc = rtjnucVSVG.getColumn(rtjnucVSVG.getColumnIndex('Mean'))

# AllCell VSVG intensity 
measureROIs(impVSVG, measOpt, rtallcellVSVG, allcellA, 0, True)		
meanInt_vsvgall = rtallcellVSVG.getColumn(rtallcellVSVG.getColumnIndex('Mean'))


for i in range(len(meanInt_Cell)):
	if meanInt_Cell[i] != 0.0:
		transportR = meanInt_jnuc[i] / meanInt_Cell[i]
		transportRall = meanInt_vsvgall[i] / meanInt_Cell[i]
	else:
		transportR = float('inf')
		transportRall = float('inf')
	rtjnucVSVG.setValue('TransportRatio', i, transportR)
	rtallcellVSVG.setValue('TransportRatio', i, transportRall)
	rtjnucVSVG.setValue('WellNumber', i, int(wnumber)) 
	rtallcellVSVG.setValue('WellNumber', i, int(wnumber))
	rtallcellPM.setValue('WellNumber', i, int(wnumber)) 

rtallcellVSVG.show('AllCell')