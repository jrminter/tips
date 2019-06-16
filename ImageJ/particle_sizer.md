---
title: "Using the ParticleSizer Plugin"
author: "J. R. Minter"
date: "Started: 2019-05-25, Last modified: 2019-05-25"
output:
  html_document:
    keep_md: yes
    css: ../theme/jm-gray-vignette.css
    number_sections: yes
    toc: yes
    toc_depth: 3
---

[Back to ImageJ](ImageJ.html)


# Introduction

The [ParticleSizer](https://imagej.net/ParticleSizer) plug-in was written by
[Thorsten Wagner](https://github.com/thorstenwagner) wraps a `particleSizer`
function that will size nanoparticles and has an interface to R that works
on Windows. The mechanism to set the path to R does not work on Mac or
Linux.

## One `gotcha`

On 2019-05-26 I noticed that the circularity values from the ParticleSizer
plugin were very different from what I was used to (12+ instead of 0-1).
I initiated a discussion on the
[ImageJ Forum](https://forum.image.sc/t/circularity-measure-in-particlesizer-plug-in/26068). Thorsten Wagner used this definition in lines 996-1012 in
[Blob.java](https://github.com/thorstenwagner/ij-blob/blob/master/src/main/java/ij/blob/Blob.java):

```
/**
	 * Method name of getCircularity (for filtering).
	 */
	public final static String GETCIRCULARITY = "getCircularity";
	/**
	 * Calculates the circularity of the outer contour: (perimeter*perimeter) / (enclosed area). If the value approaches 0.0, it indicates that the polygon is increasingly elongated.
	 * @return Circularity (perimeter*perimeter) / (enclosed area)
	 */
	public double getCircularity() {
		if(circularity!=-1){
			return circularity;
		}
		double perimeter = getPerimeter();
		double size = getEnclosedArea();
		circularity = (perimeter*perimeter) / size;
		return circularity;
	}
```

Wayne Rasband uses this definition in line 867-871 in
[ParticleAnalyzer.java](https://raw.githubusercontent.com/imagej/imagej1/master/ij/plugin/filter/ParticleAnalyzer.java):

```
if (minCircularity>0.0 || maxCircularity!=1.0) {
  double perimeter = roi.getLength();
  double circularity = perimeter==0.0?0.0:4.0*Math.PI*(stats.pixelCount/(perimeter*perimeter));
  if (circularity>1.0 && maxCircularity<=1.0) circularity = 1.0;
  if (circularity<minCircularity || circularity>maxCircularity) include = false;
}
```


# Configuration

To configure the PlugIn select


> Plugins > NanoDefine > Settings Manager


![The ParticleSizer Settings Manager in Windows. Note that the "Set R install directory" box does **not** appear in MacOS. ](png/ParticleSizerSettingsManager.png)

# Example use

Thorsten Wagner supplied an image of nano-gold particles for analysis

![The exemplar Au image. This image is not calibrated, so all measurements are in px.](png/Gold_no_overlay.png)

Processing the image produces this image:

![Processed image. The overlay was burned into the input image.](png/Gold_w_overlay.png)

The script is [here](ijm/particle_sizer_au.ijm).


[Back to ImageJ](ImageJ.html)
