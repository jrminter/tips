@String(label="Image Directory", style="") img_dir
@String(label="Report Directory", style="") rpt_dir
@String(label="Image Name", style="") img_nam
@String(label="Image Extension", style="") img_tif
/*
   test_particle_analyzer_.groovy

   Test using the ParticleSizer class from ImageJ

      Date     Who   What
   ==========  ===   ===================================================
   2019-06-04  JRM   Initial groovy prototype. Remember: you want to
                     learn scripting in Groovy...
    
*/

// start with imports
import ij.IJ
import ij.plugin.filter.ParticleAnalyzer
import ij.Prefs
import ij.ImagePlus
import ij.measure.ResultsTable
import ij.plugin.filter.Analyzer
import ij.measure.Calibration
import ij.process.ImageProcessor
import ij.ImageStack
import ij.gui.Wand
import ij.process.PolygonFiller
import ij.gui.Roi
import ij.plugin.frame.RoiManager
import ij.gui.Overlay


import ij.process.FloodFiller
import java.awt.Color
import java.awt.Font
import java.awt.Polygon
import java.awt.Rectangle
import java.awt.image.IndexColorModel



def int SHOW_RESULTS = 1
def int SHOW_SUMMARY = 2
def int SHOW_OUTLINES = 4
def int EXCLUDE_EDGE_PARTICLES = 8
def int SHOW_ROI_MASKS = 16
def int SHOW_PROGRESS = 32
def int CLEAR_WORKSHEET = 64
def int RECORD_STARTS = 128
def int DISPLAY_SUMMARY = 256
def int SHOW_NONE = 512
def int INCLUDE_HOLES = 1024
def int ADD_TO_MANAGER = 2048
def int SHOW_MASKS = 4096
def int FOUR_CONNECTED = 8192
def int IN_SITU_SHOW = 16384
def int SHOW_OVERLAY_OUTLINES = 32768
def int SHOW_OVERLAY_MASKS = 65536

def OPTIONS = "ap.options"

def int BYTE=0
def int SHORT=1
def int FLOAT=2
def int RGB=3

def double DEFAULT_MIN_SIZE = 0.0
def double DEFAULT_MAX_SIZE = Double.POSITIVE_INFINITY
def double staticMinSize = 0.0
def double staticMaxSize = DEFAULT_MAX_SIZE

def boolean pixelUnits
def int staticOptions = Prefs.getInt(OPTIONS,CLEAR_WORKSHEET)
def String[] Show_Strings = ["Nothing", "Outlines", "Bare Outlines", "Ellipses", "Masks", "Count Masks", "Overlay", "Overlay Masks"]
def double staticMinCircularity=0.0
def double staticMaxCircularity=1.0
def int NOTHING=0
def int OUTLINES=1
def int BARE_OUTLINES=2
def int ELLIPSES=3
def int MASKS=4
def int ROI_MASKS=5
def int OVERLAY_OUTLINES=6
def int OVERLAY_MASKS=7
def int staticShowChoice
def ImagePlus imp
def ResultsTable rt
def Analyzer analyzer
def int slice
def boolean processStack
def boolean showResults, excludeEdgeParticles, showSizeDistribution
def boolean resetCounter,showProgress, recordStarts, displaySummary
def boolean floodFill, addToManager, inSituShow
def boolean showResultsWindow = true
def double level1, level2
def double minSize, maxSize
def double minCircularity, maxCircularity
def int showChoice
def int options
def int measurements
def Calibration calibration
def String arg
def double fillColor
def boolean thresholdingLUT
def ImageProcessor drawIP
def int width,height
def boolean canceled
def ImageStack outlines
def IndexColorModel customLut
def int particleCount
def int maxParticleCount = 0
def int totalCount
def ResultsTable summaryTable
def Wand wand
def int imageType, imageType2
def boolean roiNeedsImage
def int minX, maxX, minY, maxY
def ImagePlus redirectImp
def ImageProcessor redirectIP
def PolygonFiller pf
def Roi saveRoi
def int saveSlice
def int beginningCount
def Rectangle r
def ImageProcessor mask
def double totalArea
def FloodFiller ff
def Polygon polygon
def RoiManager roiManager
def RoiManager staticRoiManager
def ResultsTable staticResultsTable
def ImagePlus outputImage
def boolean hideOutputImage
def int roiType
def int wandMode = Wand.LEGACY_MODE
def Overlay overlay
def boolean blackBackground
def int defaultFontSize = 9
def int nextFontSize = defaultFontSize
def Color defaultFontColor = Color.red
def Color nextFontColor = defaultFontColor
def int nextLineWidth = 1
def int fontSize = nextFontSize
def Color fontColor = nextFontColor
def int lineWidth = nextLineWidth
def boolean noThreshold
def boolean calledByPlugin
def boolean hyperstack

def addRoiToOverlay(imp, roi, label=None, bDrawLabels=False, font=20,
					labCol=Color.white, linCol=Color.white){
	"""
	addRoiToOverlay(imp, roi, label="", bDrawLabels=False, font=20,
					labCol=Color.white, linCol=Color.white)

	A convenience function to draw a ROI into the overlay of an
	ImagePlus. This is useful for situations where ROIs are computed
	from a highly processed image and the analyst wants to
	draw them into the overlay of the original image (e.g. particle
	analysis after a watershed separation. Adapted from addToOverlay()
	from Analyzer.java

	Parameters
	----------
	imp: ImagePlus
		Image into which we draw the ROI
	roi: ROI
		ROI to draw
	label: string (None)
		Optional label
	bDrawLabels: Boolean (False)
		Flag to draw ROI labels
	font: int
		Font size for label
	labCol: Color (Color.white)
		Color for the label
	linCol: Color (Color.white)
		Color for the stroke/line

	Returns
	-------
	imp: ImagePlus
		Image with the updated overlay
	"""
	jFont = Font("SanSerif", Font.BOLD, font)
	roi.setIgnoreClipRect(True)
	ovl = imp.getOverlay()
	if(ovl == None){
		ovl = Overlay()
	}
	ovl.drawNames(bDrawLabels)
	ovl.drawLabels(bDrawLabels)
	ovl.setLabelFont(jFont) 
	ovl.setStrokeColor(linCol)
	ovl.setLabelColor(labCol);
	ovl.drawBackgrounds(False);
	ovl.add(roi)
	imp.setOverlay(ovl)
	imp.updateImage()
	return imp
}

def ana_particles(imp_ori, imp_wat, csv_dir, min_area_px=10, max_area_px=100000, 
                     min_circ=0.50, max_AR=1.05) {
	println csv_dir
	ti = imp_ori.getShortTitle()
	imp_ori.setTitle(ti)
	imp_ori.show()
	imp_wat.show()

    s1 = "area mean modal min centroid center perimeter bounding fit "
    s2 = "shape Feret's display redirect=None decimal=3"
    str_meas = s1 + s2
    IJ.run(imp_wat, "Set Measurements...", str_meas)
    
    def str_ana = sprintf("size=%d-%d display exclude clear add", min_area_px, max_area_px )
    IJ.run(imp_wat, "Analyze Particles...", str_ana)
    imp_wat.show()
    IJ.selectWindow("Results")
    def str_csv = sprintf("%s/%s.csv", rpt_dir, ti)
    IJ.saveAs("Results", str_csv)
    IJ.selectWindow("Results")
    IJ.run("Close")
    IJ.selectWindow("orig")
    def roim = RoiManager(true)
    // println(roiM)
    // RoiManager("Show None")
    // RoiManager("Show All")
    // RoiManager("Show All with labels")
    
    
}
        
        


IJ.run("Close All")

imp_work = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp_work.setTitle("orig")
imp_work.show()
IJ.run("Duplicate...", "title=bin")
imp_bin = IJ.getImage()
imp_bin.show()
IJ.setThreshold(128, 255)
IJ.run("Convert to Mask")
IJ.run("Watershed");
imp_bin.show()

ana_particles(imp_work, imp_bin, rpt_dir )





