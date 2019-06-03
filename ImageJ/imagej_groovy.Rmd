---
title: "Scripting ImageJ using Groovy"
author: "J. R. Minter"
date: "Started: 2019-05-22, Last modified: 2019-06-03"
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

## Why Groovy?

My "**_Go-To_**" Fiji/ImageJ scripting language has been Jython. Jython has
a problem - it **still uses** Python 2 and is not actively being updated.
Fiji and ImageJ2 are rapidly developing and have a different object model and
syntax than legacy ImageJ1. But I have a lot of Jython functions in a library
(`jmFijGen.py`) that is maintained under version control (git) and copies "live"
in `Fiji.app/jars/Lib` and so these functions can be called and reused in jython
scripts that are run in the script editor.

I would like to migrate to Groovy or Python if possible.

- Note that there is
[fijibin](https://github.com/arve0/fijibin/tree/master/fijibin)
on github which is supposed to be a python interface, but it has not been
updated since 2015-04-22. It also runs in headless mode. It did run under
Python 3.4... 

- There is also
[PyimageJ](https://nbviewer.jupyter.org/github/imagej/tutorials/blob/master/notebooks/1-Using-ImageJ/6-ImageJ-with-Python-Kernel.ipynb) which lets the user interact 
with ImageJ.

- Jan Eglinger (imagejan on the forum.image.sc) is a proponent of Groovy
for understandable scripting in Fiji/ImageJ. He wrote:

    > In Groovy, you can just as well write:
    >
    >   ```
    >   image = IJ.getImage()
    >   ```
    >
    > Isn’t that simple enough?
    >
    > You can even write:
    > 
    >    ```
    >    image1 = IJ.openImage("/path/to/image/One.tif")
    >    image2 = IJ.openImage("/path/to/image/Two.tif")
    >    
    >    results = []
    >
    >    [image1, image2].each { image ->
    >       statistics = image.getStatistics()
    >       results << statistics.mean
    >    }
    >    
    >    println results
    >    ```

- The main site for Groovy is [groovy-lang.org](http://groovy-lang.org/).

- There is a [Groovy Scripting](https://imagej.net/Groovy_Scripting) page on
ImageJ.net that refers to the Groovy
[Getting Started](http://groovy-lang.org/documentation.html#gettingstarted)
page.

- Source Forge example scripts
**From [here](http://ij-plugins.sourceforge.net/plugins/groovy/examples.html)**
listed as **retired**... These are useful template examples. There is an
accompanying PDF that I archived
[here](pdf/Tutorial_Recording_Groovy_Scripts.pdf).

- [Groovy Syntax](http://groovy-lang.org/syntax.html)

I had a **_terrible_** time installing Groovy on my Win 7 system (crunch).
I could not get the installer file to choose a 64 bit java and when it
used my 32 bit JDK the program crashed on start up.

I ended using the brute force approach: I downloaded the
[zip file](https://dl.bintray.com/groovy/maven/apache-groovy-binary-2.5.7.zip)
unzipped it and installed it in `C:/Apps/groovy\groovy-2.5.7`
(I 7-zipped the installation and
stored it in`Dropbox/groovy/groovy-2.5.7.7z` I created a batch file
`start_groovy_console.bat`
that I install in `C:/Apps/local/path`. I created a Windows shortcut
`start_groovy_console` that sits on my desktop. It works...

I have a simple groovy script [here](groovy/gaussian_blur.groovy) that uses
a 32 bit image of my head shot.

![John's 32 bit/px head shot](groovy/john_32.png).



## Batch Processing

This script batch processes all images with extension ".png" in the input directory. Applies a median filter to each, and saves them in the output directory.

```
import ij.*
 
//
// Process files with given extension.
//
 
// Names with extension .png
def nameFilter = ~/.*.png/
 
// Input directory
def inputDir = new File("my_input_dir");
 
// Output directory
def outputDir = new File("my_output_dir");
outputDir.mkdirs();
 
// List all files with extension ".png"
def inputFiles = new ArrayList<File>()
inputDir.eachFileMatch(nameFilter) {inputFiles.add(it)}
 
// Iterate through all input files
inputFiles.each { inputFile ->
  def src = IJ.openImage(inputFile.absolutePath)
  def dest = process(src)
  def outputFile = new File(outputDir, inputFile.name)
  IJ.saveAs(dest, "tif", outputFile.absolutePath)
}
 
 
def ImagePlus process(ImagePlus src) {
  // Do some processing
  IJ.run(src, "Median...", "radius=4")
  return src
}
```


## Process Current ImageJ Image

This IJ1 script gets a reference to currently selected image in ImageJ then applies median filter to it. If no image is opened shows "No image" error message.

```
import ij.IJ
 
process()
 
def process() {
  // Get currently selected image
  def imp = IJ.image
  if (imp == null) {
    // Show error message
    IJ.noImage()
    return
  }
 
  // Do some processing
  IJ.run(imp, "Median...", "radius=4")
  // ...
}
```

## Save Image with a Transparency

Example of using Java API to create and save an image with an alpha channel (translucent).

```
import ij.process.*
import java.awt.*
import java.awt.color.*
import java.awt.image.*
import javax.imageio.ImageIO
 
def ColorProcessor cp // = ...
def ByteProcessor alpha // = ...
def BufferedImage bi = createTransparent(cp, alpha)
ImageIO.write(bi, "PNG", new File("transparent-image.png"))
 
// Pixels with alpha equal 0 will be transparent, pixels with alpha=255 will
// be opaque, values between 0 and 255 will vary transparency.
 
def createTransparent(ColorProcessor src, ByteProcessor alpha) {
  def cs = ColorSpace.getInstance(ColorSpace.CS_sRGB)
  def bits = [8, 8, 8, 8] as int[]
  def cm = new ComponentColorModel(cs, bits, true, false,
                                   Transparency.BITMASK, DataBuffer.TYPE_BYTE)
  def raster = cm.createCompatibleWritableRaster(src.width, src.height)
  def dataBuffer = raster.dataBuffer as DataBufferByte
 
  final data = dataBuffer.data
  final n = (src.pixels as int[]).length
  final r = new byte[n]
  final g = new byte[n]
  final b = new byte[n]
  final a = (byte[]) alpha.pixels
  src.getRGB(r, g, b)
  for (int i = 0; i < n; ++i) {
    final int offset = i * 4
    data[offset] = r[i]
    data[offset + 1] = g[i]
    data[offset + 2] = b[i]
    data[offset + 3] = a[i]
  }
 
  return new BufferedImage(cm, raster, false, null)
}
```


[Back to ImageJ](ImageJ.html)
