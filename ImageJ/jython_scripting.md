---
title: "Jython Scripting"
author: "J. R. Minter"
date: "Started: 2019-05-23, Last modified: 2019-05-23"
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

Jython is a python scripting language that works well with Java.
It is not currently being developed but is useful for legacy 
applications/scripts.

ImageJ.net has instructions for jython scripting in 
[ImageJ1](https://imagej.net/Jython_Scripting) and in
[ImageJ2](https://imagej.net/ImageJ2_Python_Scripts).

One needs to **_explicitly_** import the java classes we need.

# ImageJ1 examples

## Using overlays on image channels

Wayne Rasband provided (2013-05-24) this useful snippet

```
imp.setMode(CompositeImage.GRAYSCALE);
overlay = new Overlay();
// add rectangle that will be displayed on channel 1 of all 10 frames
rect1 = new Roi(100, 100, 100, 100);
rect1.setPosition(1, 1, 0);
overlay.add(rect1);
```

# ImageJ2 Examples


## ApplyThreshold.py

This is from the [ImageJ2 example page](https://imagej.net/ImageJ2_Python_Scripts).

Note the use of script parameters.

```
#@ String(label="Threshold Method", required=true, choices={'otsu', 'huang'}) method_threshold
#@ Float(label="Relative threshold", required=true, value=1, stepSize=0.1) relative_threshold
#@ Dataset data
#@OUTPUT Dataset output
#@ OpService ops
#@ DatasetService ds
 
# Apply an automatic threshold from a given method. The threshold value 'threshold_value'
# can be modulated by a relative parameter called 'relative_threshold' (if equal to 1 it does
# not modify 'threshold_value')
 
from net.imglib2.type.numeric.integer import UnsignedByteType
 
# Get the histogram
histo = ops.run("image.histogram", data)
 
# Get the threshold
threshold_value = ops.run("threshold.%s" % method_threshold, histo)
 
# Modulate 'threshold_value' by 'relative_threshold'
threshold_value = int(round(threshold_value.get() * relative_threshold))
 
# We should not have to do that...
threshold_value = UnsignedByteType(threshold_value)
 
# Apply the threshold
thresholded = ops.run("threshold.apply", data, threshold_value)
 
# Create output Dataset
output = ds.create(thresholded)
```


# Unclassified examples

## A nice example from the ImageJ Forum

From [MountainMan](https://forum.image.sc/u/mountain_man) responding to
a question by [holastello](https://forum.image.sc/u/holastello):


> Let me answer your last question first.
> 
> > More generally, does anyone have any advice on translating the java docs
> > for use with python? Everyone seems to refer to these docs but it’s not
> > obvious to me how to use them for python.
> 
> Unlike, for example, the ImageJ Macro (IJM) language, jython
> (a flavor of python) doesn’t know anything specific about
> ImageJ. Instead, jython is powerful because it knows about
> java. Specifically, jython has hooks that let it access java
> classes and call their methods. Since ImageJ is written
> (nearly entirely) in java, you can use jython to script ImageJ
> by instantiating ImageJ classes and manipulating them with
> their methods.
> 
> So ImageJ’s java api documentation is pretty much precisely
> the documentation you want for scripting ImageJ with jython.
> 
> (The division of labor is that you use jython syntax for the
> “glue” – for loops, if / else, basic lists, and so on. And the
> real image processing is done by the ImageJ java classes.)
>

> First you need to poke around to get the lay of the land.
> Let’s say that you’ve figured out that ImageJ has an IJ
> class – a utility class with a bunch of static methods.
> 
> I’ll cheat by telling you that you can open a sample image
> with the `IJ.run()` method:

```
from ij import IJ
IJ.run ('Blobs (25K)')
```

> But the rest you can get pretty straightforwardly from the
> documentation.
> 
> Looking at the IJ.getImage() documentation, we see that
> you can get your hands on the open image:

```
from ij import IJ
IJ.run ('Blobs (25K)')
imp = IJ.getImage()
```
> `imp` is a jython variable that now refers to an instance of
> the java class `ImagePlus`. This is essentially the same as
> saying (in java):

```
ImagePlus imp = IJ.getImage();
 ```

> The “glue” (syntax) is jython, but the relevant documentation
> is the ImageJ java api documentation. `ImagePlus` has a
> `getProcessor()` method that returns (a reference to) an
> instance of `ImageProcessor`, and `ImageProcessor` has a
> `resize()` method that returns a new ImageProcessor containing
> a scaled copy of this image...

```
from ij import IJ
IJ.run ('Blobs (25K)')
imp = IJ.getImage()
ip = imp.getProcessor().resize (128, 127)
```

> So, `ip` is not `imp`'s `ImageProcessor` – it’s a new instance.
> We can now assign the new ip to imp, modifying the image:

```
from ij import IJ
IJ.run ('Blobs (25K)')
imp = IJ.getImage()
ip = imp.getProcessor().resize (128, 127)
imp.setProcessor (ip)
```

> > Can someone explain how ImagePlus and ImageProcessor objects interact?
> > Do I need to convert the ImageProcessor object to an ImagePlus object?
> > If so, how?
> 
> In general, the `ImageProcessor` is the actual image – it
> holds the pixels. (In fact, there are specific subclasses,
> `ByteProcessor`, `ShortProcessor`, etc., that hold the pixel
> values stored as java arrays of java primitive types.)
> 
> `ImagePlus` is a wrapper for `ImageProcessor` that knows
> things like how to display an image, and has various kinds
> of metadata like the image’s title. (It can also wrap fancier
> things like image stacks.) More concretely, `ImagePlus` has
> an `ImageProcessor` data member.
> 
> In between the downsizing and upsizing below I want to do other stuff,
> which I think requires conversion back to an ImagePlus object. Here’s
> what I have so far:

```
from ij import IJ

# Opening the image
img = IJ.openImage('path/to/image.tif')

# Downsize image
img = img.getProcessor().resize(200)

# convert img to ImagePlus
# do other stuff (e.g. apply Weka classifier)
        
# Upsize image
img = img.getProcessor().resize(2048)
```

> Not surprisingly, you can construct an `ImagePlus` from an
> `ImageProcessor (ImagePlus (String title, ImageProcessor ip))`.
> 
> Let’s upsize your downsized image and display it:

```
from ij import IJ
IJ.run ('Blobs (25K)')
imp = IJ.getImage()
ip = imp.getProcessor().resize (128, 127)
imp.setProcessor (ip)
ip2 = ip.resize (512, 508)
from ij import ImagePlus
imp2 = ImagePlus ('upsized image', ip2)
imp2.show()
```

> So you don’t convert between `ImageProcessors` and
> ImagePlus, _per se_ – the former is wrapped by the latter.
> 
> Depending on what you are doing, to modify an image you
> can construct a new ImagePlus that wraps a new or modified
> `ImageProcessor`, you can assign a new or modified
> `ImageProcessor` to an existing `ImagePlus`, or you can
> modify the pixel values of an `ImageProcessor` **in place**,
> without instantiating a new `ImageProcessor` or
> `ImagePlus`.

# Reproducible Jython Scripting

For a couple of years I have been trying to follow the ``DRY`` process (Don't Repeat Yourself) for more reproducible Jython scripting with DTSA. Recently I have been migrating my ImageJ scripts to Jython to use with Fiji. I just learned how import user functions...

1. Create a folder ``Lib`` in FIJI_ROOT/jars/
2. Create your user module. My first one is ``jmFijiGen.py`` and place it in your new ``Lib`` folder. One of the first functions is ``ensureDir``.
3. Use the following to use ``utf-8``.

```
from org.python.core import codecs
codecs.setDefaultEncoding('utf-8')
```
4. To use ``ensureDir`` in your Jython scripts, include

```
import jmFijiGen as jmg
jmg.ensureDir(imgDir)
```
5. Converting integers to bytes. Wayne Rasband notes:

>  Java's byte data type is signed and has values ranging from – 128 to 127.

Think I found this idea from Albert Cardona. Here it is encapsulated as a useful function

```
def i2b(i):
  """def i2b(i)
  Convert an integer to a byte. Useful for LUTs."""
  if i > 127:
    i -= 256
  if i < -128:
    i = 128
  return i
```

I wanted to use a hue-based LUT for X-ray maps.

First we need and HSV to RGB function. I found that this worked

```
from colorsys import hsv_to_rgb
def hueDegToRGBCol(hue):
  """hueDegToRGBCol(hue)
  Convert a hue value (0 to 360 degrees) to an RGB color.
  Useful for LUTs."""
  h = hue / 360.
  [r, g, b] =  hsv_to_rgb(h, 1.0, 1.0)
  ret = [255.0*r, 255.0*g, 255.0*b]
  return ret
```

And put it all together with

```
def applyHueLUT(imp, hueDeg, gamma=1.0):
  """applyHueLUT(imp, hueDeg, gamma=1.0)
  Create and a apply a LUT to an ImagePlus where the maximum intensity corresponds to
  the hue specified by hueDeg. Optionally apply a gamma.
  Input Parameters
  imp - the ImagePlus
  hueDeg - the hue angle, in degrees, from 0 to 360
  gamma  - an optional gamma correction, defaults to 1.0
  Returns
  an ImagePlus with the new LUT applied"""
  ret = imp.duplicate()
  r, g, b = hueDegToRGBCol(hueDeg)
  print(r,g,b)
  ra = jarray.zeros(256, 'b')
  ga = jarray.zeros(256, 'b')
  ba = jarray.zeros(256, 'b')
  
  for i in range(256):
    ra[i] = i2b(int(round(r*pow(float(i)/256., gamma))))
    ga[i] = i2b(int(round(g*pow(float(i)/256., gamma))))
    ba[i] = i2b(int(round(b*pow(float(i)/256., gamma))))

  lut = LUT(ra, ga, ba)
  ip = ret.getProcessor() 
  ip.setLut(lut)
  ret.updateImage() 
  
  return ret
```

## Using a mu in a Jython script

[Stackexchange](http://tex.stackexchange.com/questions/33965/siunitx-%C2%B5-doesnt-work) helped!!!

The usual Windows key sequence for a $\mu$ is **not** a utf-8 character. Using this gives errors in Jython scripts. Here is how to define a $\mu$
as a utf-8 character:


```
# DO NOT use GREEK SMALL LETTER MU
# a = [0xCE, 0xBC]
# DO USE MICRO SIGN
a = [0xC2, 0xB5]
mu = "".join([chr(c) for c in a]).decode('UTF-8')
units  = mu+"m"
```

But there is an easier way...

```
from ij import IJ
units = IJ.micronSymbol + "m"
print(units)
```

Note that ``IJ`` also defines ``IJ.angstromSymbol`` and ``IJ.degreeSymbol`` ...


### Getting dir() to work with Jython in Fiji

One needs to start Fiji with a command switch. On MacOSX, this works:

```
/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx -Dpython.cachedir.skip=false --
```

On Win7, this works from the ``fiji.cmd`` in ``C:\Apps\local``:

```
"C:\Apps\Fiji.app.win64\ImageJ-win64.exe" -Dpython.cachedir.skip=false --
```

And this works starting it with Java8 from the ``fiji8.cmd`` in ``C:\Apps\local``:

```
"C:\Apps\Fiji.app.win64\ImageJ-win64.exe" -Dpython.cachedir.skip=false --java-home "C:\Program Files\Java\jdk1.8.0_20"
```

Note that these command arguments may also be put in the shortcuts that start Fiji. I did this on ``ROCPW6C6XDN1``



[Back to ImageJ](ImageJ.html)
