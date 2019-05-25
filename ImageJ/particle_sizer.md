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
