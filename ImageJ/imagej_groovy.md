---
title: "Scripting ImageJ using Groovy"
author: "J. R. Minter"
date: "Started: 2019-05-22, Last modified: 2019-06-13"
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

## Some hints regarding groovy

From a [youtube video](https://www.youtube.com/watch?v=B98jc8hdu9g) by
Derek Banas who gives many tips for groovy on the mac.

1. To set up groovy on the mac get some information:

    - Java versions installed:

   ```
   /usr/libexec/java_home -V
   ```
   
   on jrmFastMac this gave
   
   ```
   Matching Java Virtual Machines (3):
    11.0.1, x86_64:	"OpenJDK 11.0.1"	/Library/Java/JavaVirtualMachines/openjdk-11.0.1.jdk/Contents/Home
    10.0.2, x86_64:	"Java SE 10.0.2"	/Library/Java/JavaVirtualMachines/jdk-10.0.2.jdk/Contents/Home
    1.8.0_212, x86_64:	"AdoptOpenJDK 8"	/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
   ```
   
   In terminal I would type:
   
   ```
   export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_212, x86_64`
   ```
   
   verify with
   
   ```
   $ java -version 
   openjdk version "1.8.0_192"
   ```
   
   install groovy with
   
   ```
   brew install groovy
   ```
   
   which returned
   
   ```
   groovy 2.5.7 is already installed and up-to-date
   ```
   Install Atom for an IDE...
   
   ```
   brew cask install atom
   ```

## Why Groovy?

My "**_Go-To_**" Fiji/ImageJ scripting language has been Jython. Jython has
a problem - it **still uses** Python 2 and is not actively being updated.
Fiji and ImageJ2 are rapidly developing and have a different object model and
syntax than legacy ImageJ1. But I have a lot of Jython functions in a library
(`jmFijGen.py`) that is maintained under version control (git) and copies "live"
in `Fiji.app/jars/Lib` and so these functions can be called and reused in Jython
scripts that are run in the script editor.

## Key input from Jan Erlinger

1. Set the macro recorder to record in **_Beanshell_ mode**,
which records syntax mostly compatible with both Python and Groovy,
because most commands are calls into the Java API.

    **JRM Note 1:** Recording in Beanshell mode **_does not_** really
create a runnable beanshell script. Creating and running always
generates errors for me. I need to convert to groovy. To see a real
beanshell script, look
[here](https://imagej.nih.gov/ij/download/docs/bean-shell.html)

    **JRM Note 2:** Saving the scripts can produce odd file names with
multiple extensions. I needed to fix these manually...

2. To close any open `Results` and `ROI manager` windows at the beginning,
use `Script Parameters`. You can achieve this in two steps:

- get a reference to the current instances of `ROI Manager` and
 `Results table` (preferably using script parameters)

- call the API (`ResultsTable` and `RoiManager`) of these objects to reset
them. The following script snippet illustrates this:

```
#@ RoiManager rm
#@ ResultsTable rt

rm.reset()
rt.reset()
rt.show("Results")
```

This is the script I wrote following Jan's advice:

```
#@ RoiManager rm
#@ ResultsTable rt
// start with imports
import ij.*
import ij.plugin.*

def fix_inverted_lut(imp){
	/* fix_inverted_lut(imp)
	 *  
	 *  Convert an image with an inverted LUT to a standard
	 *  8-bit grayscale image
	 *  
	 *  Parameters
	 *  ==========
	 *  imp		ImagePlus
	 *  	The 8 bit grayscale image with the inverted LUT
	 *  
	 *  Returns
	 *  =======
	 *  imp_new	ImagePlus
	 *  	The image with a standard 8-bit image w a gray LUT
	 * 
	 *
	 */
	title = imp.getTitle()
	imp_new = new Duplicator().run(imp)
	IJ.run(imp_new, "Grays", "")
	IJ.run(imp_new, "Invert", "")
	imp_new.setTitle(title)
	imp_new.show()
	return imp_new
}

IJ.run("Close All")
imp = IJ.openImage("http://imagej.nih.gov/ij/images/blobs.gif")
imp = fix_inverted_lut(imp)
imp_new = new Duplicator().run(imp)
imp_new.setTitle("work")
IJ.run(imp_new, "Auto Threshold", "method=Default")
IJ.run(imp_new, "Watershed", "")
imp_new.show()
IJ.run("Set Measurements...", "area mean modal min centroid center perimeter bounding fit shape display redirect=None decimal=3")
IJ.run(imp_new, "Analyze Particles...", "size=100-100000 circularity=0.50-1.00 show=Overlay display exclude clear add")
rt.show("Results")
rm.show()
rm.moveRoisToOverlay(imp)
imp2 = imp.flatten()
imp2.show()
IJ.saveAs(imp2, "PNG", "/Users/jrminter/Desktop/blobs-segmented.png")
IJ.saveAs("Results", "/Users/jrminter/Desktop/blobs-results.csv")
imp.changes = false
imp.close()
imp2.changes = false
imp2.close()
imp_new.changes = false
imp_new.close()
rt.reset()
rm.reset()
IJ.selectWindow("Results")
IJ.run("Close")
IJ.selectWindow("ROI Manager")
IJ.run("Close")
```


In another thread Jan Eglinger explained the value of Groovy
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
    

- [BAR](https://github.com/tferr/Scripts/blob/master/BAR/src/main/resources/lib/BARlib.groovy) has an example script.

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
