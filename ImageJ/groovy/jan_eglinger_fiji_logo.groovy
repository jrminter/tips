#@ Double (label = "Tube thickness (in percent)", min = 2, max = 20, stepSize=0.5, value = 12) tubeThickness
#@ Double (label = "Letter distance (in percent)", min = 1, max = 10, stepSize=0.5, value = 5) letterDistance
#@ Double (label = "Outer radius of J (in percent)", min = 10, max = 30, stepSize=0.5, value = 21) jRadius
#@ Double (label = "Frame weight (in percent)", min = 0.1, max = 5, stepSize=0.1, value = 0.1) frameWeight
#@ Integer (label = "Output size (in pixels)", value = 256) outputSize
#@ Boolean (label = "Draw I", value = true) drawI
#@ Boolean (label = "Draw J", value = true) drawJ
#@ Boolean (label = "Draw slide", value = true) drawSlide
#@OUTPUT img

import net.imglib2.roi.Masks
import net.imglib2.roi.geom.GeomMasks
//import bdv.util.Bdv
//import bdv.util.BdvFunctions
import net.imglib2.FinalInterval
import net.imglib2.view.Views
import net.imglib2.FinalInterval

import net.imglib2.realtransform.AffineTransform2D

// required for rasterizing
// to avoid misalignment between J stem and bottom
offset = -0.5

// derived and fixed values
xI = 50 - jRadius
yI = 15
hI = 40
bottomJ = 90

xJbar = xI + tubeThickness + letterDistance
yJbar = 30
xJstem = 50 + jRadius - tubeThickness
yJcenter = bottomJ - jRadius


I = GeomMasks.closedBox([xI, yI] as double[], [xI + tubeThickness, yI + hI] as double[])

Jbar      = GeomMasks.closedBox([xJbar, yJbar] as double[], [50 + jRadius, yJbar + tubeThickness] as double[])
Jstem     = GeomMasks.closedBox([xJstem, yJbar] as double[], [50 + jRadius, yJcenter] as double[])
Jouter    = GeomMasks.openSphere([50, yJcenter] as double[], jRadius)
Jinner    = GeomMasks.closedSphere([50, yJcenter] as double[], jRadius - tubeThickness)
Jclipping = GeomMasks.openBox([ 0, yJcenter] as double[], [100, 100] as double[])

J = Jouter.minus(Jinner).and(Jclipping).or(Jbar).or(Jstem)

slide  = GeomMasks.closedBox([xI - letterDistance, yJcenter - 4] as double[], [xJbar, yJcenter - 3] as double[])

/* Create frame */

frame1 = GeomMasks.closedBox([ 0,  0] as double[], [100, 100] as double[])
frame2 = GeomMasks.closedBox([ frameWeight,  frameWeight] as double[], [100 - frameWeight, 100 - frameWeight] as double[])
frame  = frame1.minus(frame2)

/* Combine mask */

logoRoi = frame
if (drawI) logoRoi = logoRoi.or(I)
if (drawJ) logoRoi = logoRoi.or(J)
if (drawSlide) logoRoi = logoRoi.or(slide)

/* Translate and scale ROI */

transform = new AffineTransform2D()
transform.scale(outputSize / 100)
transform.translate(offset, offset)

transformedRoi = logoRoi.transform(transform.inverse()) // why inverse?

mask = Masks.toRealRandomAccessibleRealInterval(transformedRoi)

/* Show combined mask in BigDataViewer */

/*
BdvFunctions.show(
				mask,
				new FinalInterval(
						[mask.realMin( 0 ), mask.realMin( 1 ) ] as long[],
						[mask.realMax( 0 ), mask.realMax( 1 ) ] as long[] ),
				"2D Mask",
				Bdv.options() )
*/

/* Use Imglib2 Views to raster the mask */

img = Views.interval(Views.raster(mask), new FinalInterval(
						[mask.realMin( 0 ), mask.realMin( 1 ) ] as long[],
						[mask.realMax( 0 ), mask.realMax( 1 ) ] as long[] )
					)