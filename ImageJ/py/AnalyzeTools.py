

"""
From Sebi06 on the ImageJ Forum
https://forum.image.sc/t/solved-save-summary-in-headlessmode/26606

Date       Who  What
---------- ---  --------------------------------------------------
2019-06-17 SEB  Entered Sebi06's script. He supplied w/o imports...
2019-07-17 JRM  Adding imports...


"""

from ij.plugin.filter import ParticleAnalyzer as PA
from ij.measure import ResultsTable
from ij import IJ, ImageStack, ImagePlus

class AnalyzeTools:

    @staticmethod
    def analyzeParticles(imp, minsize, maxsize, mincirc, maxcirc,
                         filename='Test.czi',
                         addROIManager=True,
                         headless=True,
                         exclude=True):

        if addROIManager is True:

            if exclude is False:
                options = PA.SHOW_ROI_MASKS \
                    + PA.SHOW_RESULTS \
                    + PA.DISPLAY_SUMMARY \
                    + PA.ADD_TO_MANAGER \
                    + PA.ADD_TO_OVERLAY \

            if exclude is True:
                options = PA.SHOW_ROI_MASKS \
                    + PA.SHOW_RESULTS \
                    + PA.DISPLAY_SUMMARY \
                    + PA.ADD_TO_MANAGER \
                    + PA.ADD_TO_OVERLAY \
                    + PA.EXCLUDE_EDGE_PARTICLES

        if addROIManager is False:

            if exclude is False:
                options = PA.SHOW_ROI_MASKS \
                    + PA.SHOW_RESULTS \
                    + PA.DISPLAY_SUMMARY \
                    + PA.ADD_TO_OVERLAY \

            if exclude is True:
                options = PA.SHOW_ROI_MASKS \
                    + PA.SHOW_RESULTS \
                    + PA.DISPLAY_SUMMARY \
                    + PA.ADD_TO_OVERLAY \
                    + PA.EXCLUDE_EDGE_PARTICLES

        measurements = PA.STACK_POSITION \
            + PA.LABELS \
            + PA.AREA \
            + PA.RECT \

        results = ResultsTable()
        p = PA(options, measurements, results, minsize, maxsize, mincirc, maxcirc)
        p.setHideOutputImage(True)
        particlestack = ImageStack(imp.getWidth(), imp.getHeight())   
        
        for i in range(imp.getStackSize()):
            imp.setSliceWithoutUpdate(i + 1)
            ip = imp.getProcessor()
            #IJ.run(imp, "Convert to Mask", "")
            p.analyze(imp, ip)
            mmap = p.getOutputImage()
            particlestack.addSlice(mmap.getProcessor())

        return particlestack, results

    @staticmethod
    def create_resultfilename(filename, suffix='_Results', extension='txt'):

        # create the name for the result file
        rtfilename = os.path.splitext(filename)[0] + suffix + '.' + extension

        return rtfilename