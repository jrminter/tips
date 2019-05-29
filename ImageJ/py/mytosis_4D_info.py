from ij.io import TiffDecoder

#
# From EMBL examples
#
# using 'mitosis (5d)' sample image. 
directory = '/Users/jrminter/dat/images/embl/'
filename = 'mitosis_4D.tif'
td = TiffDecoder(directory, filename)
imginfos = td.getTiffInfo()
print 'Resolution: ', imginfos[0].unit, '/ pixel' 
print 'x resoluition:', imginfos[0].pixelWidth
print 'y resoluition:', imginfos[0].pixelHeight
 
# to print various image parameters
print imginfos[0].description
print '---'
# to print imgage optional info
print imginfos[0].info