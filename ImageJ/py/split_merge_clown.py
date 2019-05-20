from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')
import os
from ij import IJ, WindowManager
from ij.plugin import ImageCalculator, RGBStackMerge
from ij.plugin.filter.Analyzer import setOption
import jmFijiGen as jmg


def rgb_from_r_g_b(r, g, b, title):
	"""
	rgb_from_r_g_b(r, g, b, title)

	Generate an RGB image from three 8/bit per pixel
	gray scale images

	Parameters
    ----------
    r:	An ImagePlus
        The red channel
    g:	An ImagePlus
        The green channel
    b:	An ImagePlus
        The blue channel
    title: a string
    	The title for the image
    
    Returns
    -------
    impRGB:	An ImagePlus
    	The RGB image
	"""
	tiR = r.getTitle()
	tiG = g.getTitle()
	tiB = b.getTitle()

	strTwo = "c1=[%s] c2=[%s] c3=[%s]" % (tiR, tiG, tiB)
	IJ.run("Merge Channels...", strTwo)
	impRecon = IJ.getImage()
	impRecon.show()
	return(impRecon)  
	

IJ.run("Clown (14K)")
impC = IJ.getImage()
impC.setTitle("clown")

[impR, impG, impB] = jmg.separate_colors(impC)

impR.show()
impG.show()
impB.show()


impRecon = jmg.rgb_from_r_g_b(impR, impG, impB, "new_clown")
impRecon.show()

