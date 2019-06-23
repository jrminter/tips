# Analysis of High-Throughput Microscopy Image Data

BioIT-EMBL Centres Joint Training Week, Mar. 26, 2014

Place: ATC Computer Teaching Lab

Kota Miura (CMCI, EMBL)

- [Course Web Page](https://bio-it.embl.de/joint-training) (only internal access)

##Contents

- [Instructors](#instructors)
- [Course Outline](#course-outline)
- [Introduction](#introduction)
- [Configuration for March 24](#configuration-for-march-24)
  - [Install Fiji on your desktop](#install-fiji-on-your-desktop)
  - [Configure access to the Fiji in the network](#configure-access-to-the-fiji-in-the-network)
  - [ Check if Fiji is working](#Check if Fiji is working)
- [Methods (Image Analysis)](#methods-image-analysis)
- [Resources](#resources)
  - [Fiji](#fiji)
  - [Data](#data)
  - [Scripts](#scripts)  
- [Workflow: GUI](#workflow-gui)
- [Workflow: Python Primer](#workflow-python-primer)
- [Workflow: Fiji Jython Scripting](#workflow-fiji-jython-scripting)
- [Workflow: Implementing Image Analysis](#workflow-implementing-image-analysis)
- [Final Code](#final-code)
- [Generating Job Array](#generating-job-array)


## Instructors

- Kota Miura
  - Centre for Molecular and Cellular Imaging (CMCI), EMBL
  - <miura@embl.de>

- Christoph Schiklenk
  - Haering Lab, Cell Biology & Biophysics, EMBL
  - Christoph has been using Fiji/Jython for a year and he now is a quite literate Fiji scripting guy. He is volunteering to assist your learning. 

- Clemens Lakner
  - Bio-IT, EMBL
  - Clemens wrote the job-array generator scripts for image analysis. He will explain to you how his shell script is working.
  
- Christian Tischer
  - ALMF, EMBL
  - Tischi will be partially appearing to assist you. Imaging expert and not only an Jython-Fiji expert, but also a Cell Profiler expert.

- Aliaksandr Halavatyi
  - Pepperkok Lab, Cell Biology & Biophysics, EMBL
  - Aliaksandr will be partially appearing to assist you. He has been coding image analysis tools in Matlab, but knows ImageJ/Fiji pretty well and coding in Jython.   
  
- Acknowledgements
  - Thanks to Fatima Verissimo, Faba Neumann, Rainer Pepperkok and Jean-Karim Hériché for providing data, sharing their experiences and giving advices on these data. 
  - Thanks to Bernd Klaus, Matt Rogon and Aidan Budd (the course team) for their effort in starting up this course and working together.   

##Course Outline

1. **Aim: Learn how to process and analyze high content image data by Fiji scripting**
2. Introduction: the background of data, setting up.
3. Processing and analyzing using Fiji GUI
   - We first try to segment nucleus image and do measurement using GUI, to know how the algorithm works.    
4. Python Crash Course
   - We want to write a script that does processing and measurements: for this we first need to learn  basics of python syntax.   
5. Fiji scripting in Jython
   - Jython is a Java-implemented Python, allows to use full functionality of Fiji by scripting. We learn how to write Jython script to do our task automatically.  
6. Submitting Jobs (executing Jython script) to the cluster.
   - As there are many images, we use cluster to parallelize the computation, to get results in a short time. 

## Introduction

Image based screening (high content screening) is one of the modern methods for screening genes involved in a biological process. The main idea is to systematically acquire a huge amount of data with various treatments, and try to isolate treatments that affects the target biological process. 

Dataset we use in this course is from a secretory pathway screening. Proteins synthesised in endoplasmic reticulum are transported first to the Golgi, where proteins are added with modifications, and then to the plasma membrane or other destined intracellular structures. 

VSVG is a model protein used for studying this transport system and is a heat-sensitive protein.  This protein could be accumulated in / released from ER by temperature shifting, to experimentally analyze the process of intracellular transport from ER to the plasma membrane. 

To study the transport process, it is desirable to take time lapse sequence to follow the changes in VSVG localization within cell. However, it is sufficient to assess the transport process by taking a snapshot at a defined time point after releasing the protein from ER and check where the protein is located. In control condition, proteins should be localized in the plasma membrane after successful transports. If the transport out from the ER is interfered due to suppression of the component of transport, proteins should be stably located in the ER. Likewise, finding proteins in the Golgi suggests that transport machinery from Golgi to the plasma membrane is blocked. 

With this snapshot strategy, it is possible to systematically prepare a set of siRNAs and drug treatments to test their effect on vesicle transport system: the high content image screening. 

In this course, we will try to analyze all images from different types of treatments automatically, evaluate and compare the difference in the efficiency of transport. This COULD be done manually, but we have huge number of various treatments: approximately 700,000 of images to analyze. To not to end the rest of our life clicking images, we will completely automate the image processing and  analysis to extract transport parameters and output results as a huge list of parameter table. 

This table then is studied using statistical techniques to distinguish treatments that are largely affecting the transport system. 

Followings are the literatures published with this dataset. 

- Liebel, U., Starkuviene, V., Erfle, H., Simpson, J.C., Poustka, A., Wiemann, S., Pepperkok, R., 2003. A microscope-based screening platform for large-scale functional protein analysis in intact cells. FEBS Lett. 554, 394–8. <http://www.ncbi.nlm.nih.gov/pubmed/17275941>

- Simpson, J.C., Cetin, C., Erfle, H., Joggerst, B., Liebel, U., Ellenberg, J., Pepperkok, R., 2007. An RNAi screening platform to identify secretion machinery in mammalian cells. J. Biotechnol. 129, 352–65. <http://www.ncbi.nlm.nih.gov/pubmed/17275941>

- Simpson, J.C., Joggerst, B., Laketa, V., Verissimo, F., Cetin, C., Erfle, H., Bexiga, M.G., Singan, V.R., Hériché, J.-K., Neumann, B., Mateos, A., Blake, J., Bechtel, S., Benes, V., Wiemann, S., 
Ellenberg, J., Pepperkok, R., 2012. Genome-wide RNAi screening identifies human proteins with a regulatory function in the early secretory pathway. Nat. Cell Biol. 14, 764–74. <http://www.ncbi.nlm.nih.gov/pubmed/22660414>

## Configuration for March 26, 2014

Here is what you should do to use Fiji locally and via network. We learn GUI and scripting using local Fiji (one that you will install in your machine) and the network Fiji (resides in ALMF server and run it headlessly using command line). 

In brief, 

* For desktop Fiji, you just need to download the installer. 
* For the network Fiji, you need to set path both for the network Fiji and Java virtual machine (Java should be 1.6).

Just a note: if you try to run Fiji from sshint.embl.de, it fails because the Java version there is 1.4. 

### Install Fiji on your desktop

Access the following page

```
http://fiji.sc/Downloads
```

then install "Life-Line Version", Linux 64-bit. Place the Fiji folder on your desktop. 

###  Configure access to the Fiji in the network 

For using Fiji in the network from command line, do the following. 

#### Add an alias in your local bash profile.

Open ~/.bash_profile

```
open ~/.bash_profile
```

Add the following line in your bash profile (.bash_profile). 

```
alias cluster='ssh -t <YOUR UNIX USERNAME>@submaster '\''bsub -M 5000 -Is bash'\'''
```

By the way, this will allow you to execute the command below as an alias 'cluster'

```
ssh -t <YOUR UNIX USERNAME>@submaster \bsub -M 5000 -Is bash
```
If you have time, try the above command directly and see that it works. 

Reload the .bash_profile by 

```
source .bash_profile
```

to validate your changes. 

#### Add several paths to your .bash_profile in the network.

If your are ready with the above new alias, try

```
cluster
```

You will then be asked for your password, and then will be connected to one of the cluster nodes in an interactive mode. 

Open your .bash_profile:

```
vim ~/.bash_profile
```

If you are not use to vi editor, you could use others such as


```
nano ~/.bash_profile

```

Otherwise, it might be able to edit the .bash_profile directly from your course Linux machine. 


Add the following lines in your .bash_profile

```
export PATH=/g/software/bin:$PATH
export PATH=/g/almf/software/bin2:$PATH
export PATH=/g/almf/software/bin/java/jdk1.6.0_45/bin/:$PATH
export JAVA_HOME=/g/almf/software/bin/java/jdk1.6.0_45
```

This is just to run Fiji from your command line (the one that I am maintaining) and to use the right Java version. You could delete these lines after the course. 

Reload the profile

```
source .bash_profile
```

### Check if Fiji is working 

If you are still connected to one of the nodes, do

```
java -version
```

The output should look like

```
[miura@compute083]~ $
java -version
java version "1.6.0_45"
Java(TM) SE Runtime Environment (build 1.6.0_45-b06)
Java HotSpot(TM) 64-Bit Server VM (build 20.45-b01, mixed mode)
```

If your Java version is OK (same as above), then 

```
fiji --help
```
 The output should be
 
 ```
 [miura@compute083]~ $
fiji --help
Usage: fiji [<Java options>.. --] [<ImageJ options>..] [<files>..]

Java options are passed to the Java Runtime, ImageJ
options to ImageJ (or Jython, JRuby, ...).

In addition, the following options are supported by ImageJ:
General options:
--help, -h
	show this help
--dry-run
	show the command line, but do not run anything
--debug
	verbose output
--system
	do not try to run bundled Java
--java-home <path>
	specify JAVA_HOME explicitly
--print-java-home
	print ImageJ's idea of JAVA_HOME
--print-ij-dir
	print where ImageJ thinks it is located
--headless
	run in text mode
--ij-dir <path>
	set the ImageJ directory to <path> (used to find
	 jars/, plugins/ and macros/)
--heap, --mem, --memory <amount>
	set Java's heap size to <amount> (e.g. 512M)
--class-path, --classpath, -classpath, --cp, -cp <path>
	append <path> to the class path
--jar-path, --jarpath, -jarpath <path>
	append .jar files in <path> to the class path
--pass-classpath
	pass -classpath <classpath> to the main() method
--full-classpath
	call the main class with the full ImageJ class path
--dont-patch-ij1
	do not try to runtime-patch ImageJ1
--ext <path>
	set Java's extension directory to <path>
--default-gc
	do not use advanced garbage collector settings by default
	(-Xincgc -XX:PermSize=128m)
--gc-g1
	use the G1 garbage collector
--debug-gc
	show debug info about the garbage collector on stderr
--debugger=<port>
	start the JVM in a mode so Eclipse's debugger can attach to it
--no-splash
	suppress showing a splash screen upon startup

Options for ImageJ:
--ij2
	start ImageJ2 instead of ImageJ1
--ij1
	start ImageJ1
--allow-multiple
	do not reuse existing ImageJ instance
--plugins <dir>
	use <dir> to discover plugins
--run <plugin> [<arg>]
	run <plugin> in ImageJ, optionally with arguments
--compile-and-run <path-to-.java-file>
	compile and run <plugin> in ImageJ
--edit [<file>...]
	edit the given file in the script editor

Options to run programs other than ImageJ:
--update
	start the command-line version of the ImageJ updater
--javah
	start javah instead of ImageJ
--javap
	start javap instead of ImageJ
--javadoc
	start javadoc instead of ImageJ
--main-class <class name> (this is the
	default when called with a file ending in .class)
	start the given class instead of ImageJ
--retrotranslator
	use Retrotranslator to support Java < 1.6
 ```
 
## Methods (Image Analysis)

As we are interested in the attenuation or the enhancement of the protein transport machinery from ER to the plasma membrane via the Golgi apparatus, we compare the protein density in ER, the Golgi and the plasma membrane. For this, we use three different images. 

The minimal dataset consists of three images:

1. Dapi signal: nucleus image
2. cy3 signal: VSVG signal
3. Immunostaining signal: VSVG signal exposed to the extracellular space. 

Dapi signal is used for locating individual cells and marking them. VSVG signal tells us where the VSVG protein is located within the cell. When they are at the Golgi, they are concentrated close to the nucleus. When they are in ER and the plasma membrane, they are evenly distributed within the cell. To check the VSVG protein specifically localized to the plasma membrane, the third image from immunostaining of the VSVG protein is used: the signal only appears when the protein is exposed to the extracellular space.

###Pre-screening

There are bad images just because of simple failures during acquisition, such as

- out of focus
- over exposure

We exclude these images by pre-screening images. Standard deviation of pixel intensity in each image is measured, and those with extreme values will be excluded from the analysis. For this, a black list of file names which will be used in the main analysis is created.

We probably will not explain this part in detail, just show you how it was done.  

###Nucleus Segmentation

To measure these values, we first segment each nucleus using automatic local intensity thresholding (Bernsen algorithm). Then the rim of the nucleus is dilated outwards to define an approximate area to define the region of **Cell Area**. Within this region, we call the dilated region (Cell Area - Nucleus Area) as the **Juxta-Nuclear** cytoplasmic region. 

(Figure required here)

By measuring the intensity ratio of those at the plasma membrane and those at the Golgi (the transport ratio **T**), we assess the efficiency of transport.

### Transport Ratio
The transport ratio (T) calculated in Simpson (2007) is as follows:

Mean intensity of PM signal / Mean Intensity of VSVG signal. 

If **T** is smaller than control cells, transport is blocked. If it is larger than control, then the transport is accelerated. 

## Resources

###Fiji

Fiji is located at

	/g/almf/software/bin2/fiji

Please put the following lines in your .bashrc or .bash_profile

	export PATH=/g/almf/software/bin2:$PATH
	export PATH=/g/almf/software/bin/java/jdk1.6.0_45/bin:$PATH

Then 

	source .bashrc

or

	source .bash_profile
	
###Data

All data are located under

	/g/data/bio-it_centres_course/data/VSVG/

Plates are numbered such that

	plateID-Number--year-month-date

For example:

	0001-03--2005-08-01

This means that this is the plate ID 1, third experiment (same plate configuration is repeated at least three times each). We analyze plateID from 1 to 159. There are 703 folders so the cluster job array will be composed of 703 jobs.  

Within each of these folders, images are stored under 
	
	data/

###Example Image

Example image set for learning image processing and analysis is in

	/g/data/bio-it_centres_course/data/course

There are three files from single spot in a plate. 


###Scripts

The script for processing images for a single plate is

	/g/almf/software/scripts2/measTransportBatch3.py
	
To process a plate, for example the first plate '0001-03--2005-08-01', the plate folder name is given as an argument to a command like below:

	fiji --headless --mem=1000m /g/almf/software/scripts2/measTransportBatch3.py '0001-03--2005-08-01'
   
Pre-screening script is 

	/g/almf/software/scripts2/listFocusedImagesV2.py
	
A script for generating job array written by Clemens Lakner is
	
	/g/data/bio-it_centres_course/data/VSVG/fiji-sub/fiji_script.sh
	
The code:

<>


## Workflow: GUI

The protocol below is described in Simpson (2007).

###Background subtraction 

Background subtraction will only be done with PM and VSVG images. In the final script, the function name is **backgroundSubtraction**

Get minimum and mean intensity of the image.

	[Analyze > Set measurements…] : min and max, mean
	[Analyze> Measure]
		
Results will be shown in the Results Table. We use min and mean values. We call them min1, mean1. 

Then calculate mean of the pixels those with values greater than min1 and less than the mean1. 

	[Analyze > Set measurements…]
		:select min and max, mean, limit to threshold
	[Image > Adjust > threshold…]
		click "Set" and put 
			Lower Threshold Level: min1
			Upper Threshold level: mean1
	[Analyze> Measure]
		results: mean2
	Click "Reset" in Threshold GUI.      

Subtract mean2 value from the image. 
     
	[Process > Math > Subtract]: use "mean2". 

###nucleus segmentation

Nucleus segmentation. We only do this with Dapi image. Corresponding function in the script is **nucleusSegmentation(imp2)**.
 
	[Image > Type > 8bit]
	[Process > Filters > Gaussian Blur...]
		: radius=2.0
	[Image . Adjust > Auto Local Threshold]
		: algorithm, Bernsen, other parameters stay same
   
Pre-filtering by size and circularity

	[Analyze > Set Measurements]
          :select  area, standard deviation, shape descriptors, integrated density
	[Analyze > Analyze Particles…]
		:set area 20 - 1000
		:set circularity 0.8 - 1.0
		:show: Masks
		:check Display Results, Clear results, Exclude on Edges, Include Holes
Rename the resulted image as impNuc

	[Image > Rename]

Duplicate the resulted image and then invert LUT

	[Image > Duplicate…]
	[Image > Lookup Tables > Invert LUT]
          
Dilate segmented nucleus by 15 pixels (to check if nucleus will merge)
	
	[Process > Binary > Options] set iterations to 15, Check "Black Background"
	[Process > Binary > Dilate]

(called imp2)


Particle analysis 1 (with imp2) 

	[Analyze > Analyze Particles…]
		:set area 20 - 10000
		:set circularity 0.8 - 1.0
		:show: None
		:check Display Results, Clear results, Exclude on Edges, Include Holes

q1, q3, offset calculation: Copy and paste <https://gist.github.com/miura/9641262>

     Example results: 2926.0 3854.0 1392.0
     min2 = q1 - offset (= 2462)
     max2 = q3 + offset (= 5246)


Particle analysis 2 (remove outlier)

	with imp2, 
	[Analyze > Analyze Particles…]
		:set area min2 - max2
		:set circularity 0.8 - 1.0
		:show: Mask
		:check Display Results, Clear results, Exclude on Edges, Include Holes
     
	output: the mask. rename it as impDilatedNuc

Filter original nucleus

     [Process > Image Calculator …]
          AND operation for impNuc and impDilatedNuc


###Check Segmentation Results. 

     Visual inspection. We terminate analysis if there is no nucleus segmented. 


###Generate nucleus ROIs from segmented nucleus. Store them as a list. 

     [Edit > Selection > Create Selection]
     [Edit > Selection > Make Inverse]
     [Edit > Selection > To ROImanager]

###Roi modifications

     In ROI manager
     a. Generate All Cell ROIs (enlarge)
         Activate the ROI above, then 
         [Image > Selection > Enlarge…] : 15 pixels
          click "Add". Second ROI appears in the ROI manager list. 
          this will be the "All cell"
     b. Generate JuxtaNuclear ROIs (enlarged minus nucleus)
          select both ROIs, and then [More >> XOR]. 
          click "Add". Third ROI appears in the listing. 
          This ail be the zone surrounding nucleus. 


### Measurements
Do measurements using modified ROIs (measureROIs).

     select corresponding ROI and 
     
     [Analyze > Measure]
     
     a. enlarged: all cell plasma membrane
     b. ring rois: juxtanuclear signal for VSVG
     c. all cell VSVG intensity


### Transport Efficiency

Calculate transport efficiency and add the results to results table. All results from single plate are merged and placed in a file, but we do not do this manually. 

## Workflow: Python Primer

Jython is Java-implemented Python, allowing us to access Java classes in Python syntax. To write Jython scripts in Fiji, we use Script Editor. 

	[File > New > Script]

This command launches the editor and a new script file. 

Script Editor has its own menu, and one of them is 

	[Language > Python]
	
To set the language to Python (Jython).

 The editor has two panels. Upper one is the input field, and the lower one is the output field. Output field has two types, standard output and error output. You could toggle this by clicking "error" or "output".
 
We learn the basics of Python commands interactively. Below is a list of Python functions we go over.

````
print
print with comma separated

variables

functions
     return
     multiple returns
     
list
     initialization
     range
     sorted(list)
     slicing
     l.append()
     len

for

     allcellA = [roiEnlarger(r) for r in nucroiA]

     enumerate
     extend()

if, else, break

String
     concatenation
     f.endswith()
     
dictionary
     initialization
     d['a'] = 3

Accessing files
     path / file managements
          os.listdir
          os.path.isfile
          os.path.join

Python regex
          re.compile
          re.search
          re.group
          
I/O 
f = open(path, 'rb')
sys.argv

csv.reader

````

Codes used in this interactive session assembled in a file and in 

<https://gist.github.com/miura/9687511>

### File access

```python
import os

root = '/Volumes/data/bio-it_centres_course/data/course'
#filename = 'dapi.tif'
files = os.listdir(root)

print 'file 1: ', files[0]
fullpath = os.path.join(root, files[0])
print fullpath

print 'file 2: ', files[1]
fullpath = os.path.join(root, files[1])
print os.path.isfile(fullpath)

```

### Writing CSV

```python
import csv

f = open('/Users/miura/tmp/test.csv', 'wb')
writer = csv.writer(f)
writer.writerow(['id', 'mean', 'sd'])
writer.writerow([1, 10.5, 3.3])
f.close()
```

### Reading CSV

```python
import csv
 
filepath = '/Users/miura/tmp/test.csv'
f = open(filepath, 'rb')
data = csv.reader(f)
for row in data:
    print ', '.join(row)
```

###For more information

see

<http://www.jython.org/docs/library/indexprogress.html>

<http://www.jython.org/docs/library/functions.html>


## Workflow: Fiji Jython Scripting

### IJ.log

Let's first try accessing Java classes. Try the following. 

````
IJ.log("Hello World!")
````

This will print the argument "Hello World!" in the Log window (in ImageJ macro, similar job can be done by print(string) command).

We could add another line

````
IJ.log("Hello World!")
IJ.log("\\Clear")
````
Run this code, and compare with the output of 

````
IJ.log("\\Clear")
IJ.log("Hello World!")
````

The double back-slash

	\\ 

is called escape sequence, and is a command send to the interpreter. Instead of printing the following string in the Log window, it is interpreted as a command. In case of "\\Clear", texts in the Log window will be cleared. 

### Javadoc

Now, let's see a bit more of details about "IJ.log". Click the following link and see the page

[Javadoc - IJ](http://rsbweb.nih.gov/ij/developer/api/ij/IJ.html)

This is a documentation called "Javadoc" and is a reference for all the functionality that an Java application has. It's **VERY IMPORTANT** to understand how to use this documentation, so I wll explain in details. 

ImageJ is a collection of many classes, and you could find all those classes in this Javadoc. The web page has side bar in the left side, and it is separated to the upper and the lower panels. The upper panel has its title "Packages" and the bottle panel is "Classes". As I have already said, ImageJ is a collection of many classes - and they are all listed in the bottom panel. 

Since there are many classes, they are organized in hierarchical way by "packages". You could imagine each packages as a folder in file system. For example, you could find a package named "ij". It means something like a folder named "ij", and for a package "ij.plugin.filter", its a folder "filter" under a folder "plguin" within a folder "ij" (in fact, class files are located in file system in this way). 

In the bottom panel, all classes are listed as long as you have not filtered them by clicking one of the packages in the upper panel. Try to look for the class **IJ** by scrolling down the lower panel, and click the link "IJ". 

You will then see a new page in the right side: There is a big text saying "Class IJ". IJ from IJ.log is a **class**, which contains many **methods**. To see those methods, scroll down the page and you will find a table titled "Method Summary". This is an alphabetical list of all methods that IJ contains. Among them, you could find 

	log(java.lang.String s) 

To use a method from IJ class, you just need a dot after the class name and then add the name of the method. In case of the method "log", you need an argument and it should be a String type. In the example we tried above, it was "Hello World!". 

How about other methods? Try the method beep(). 

	IJ.beep()
	
When this code is executed, your machine will make a beep sound. In such a way all the methods are usable. 

###Loading and showing Image

One of methods available in class IJ is openImage(path). Check it's javadoc information ([Javadoc]()). It says:

> **openImage**

> public static ImagePlus openImage(java.lang.String path)

> Opens the specified file as a tiff, bmp, dicom, fits, pgm, gif or jpeg image and returns an ImagePlus object if successful. Calls HandleExtraFileTypes plugin if the file type is not recognised. Displays a file open dialog if 'path' is null or an empty string. Note that 'path' can also be a URL. Some reader plugins, including the Bio-Formats plugin, display the image and return null.

It loads an image from a file in the ***path***, and returns an ImagePlus object (we will study more about object, or *instance* in below).

	imp = IJ.openImage('/g/data/bio-it_centres_course/data/course/--W00005--P00001--Z00000--T00000--dapi.tif')
	imp.show()

*imp* now points to the loaded image, and is an instance of class ImagePlus. The ImagePlus holds image itself (pixel data) and metadata (such as its size, image name, units and so on). Check ImagePlus Javadoc

[ImagePlus](http://rsbweb.nih.gov/ij/developer/api/ij/ImagePlus.html)

It has many methods, and one of them is `show()`, which creates a windows and displays image on your desktop. 
	
###Class ImagePlus

We study what we could get from the instance of ImagePlus object (the imp we got by loading image file). 

* imp.getTitle()
  * add a line  `print imp.getTitle()`
* imp.duplicate()
  * add two lines `imp2 = imp.duplicate()` then `imp2.show()`
  * imp2 will be a duplicate of the imp image. 
* imp.deleteRoi() 
* imp.setRoi()
* imp.getProcessor()

###Class ImageProcessor


* impstats = ip.getStatistics()
* ip.getMax()
* ip.setThreshold(min, max, lut)
* ip.resetThreshold()
* ip.subtract(val)
* ip.invertLut()
* r = ip.restRoi()
* ip.setRoi()

###Class ImageStatistics

* impstats.mean


###Constructing an Object

So far, I have not explained an important difference in types of methods: There are static and non-static methods. If you see the Javadoc of class IJ, you will see that all methods of this class has "static" as their property. This means that you could use those methods by appending the name of the method directly after name of the class, such as IJ.log() and IJ.beep(). 

In contrast, this is not possible with non-static methods. For example, the class ImagePlus has many methods such as "getHeight()", which is to get the height of the image. If you try to do 

	print ImagePlus.getHeight()

It will not work and returns an error. This is simply because we (and mainly the computer) do not know which image that we asking for its height. Instead we must use a specific **instance** of image, such as the one you retrieve by IJ.openImage(). Remember, 

	imp = IJ.openImage('/Users/miura/image.tif')
	
This "imp" is a specific instance of image because we know that we loaded the image from a specific file. ImagePlus is a class, but never becomes existing until it is "constructed" by loading an image from a file or creating a image from scratch or grabbing a image that is opened on desktop. 

Classes that became into existing entity is called an "Instance" or "Object". None static methods work only when an instance is there. 

Coming back to the static methods of class IJ, their functions are those that does need a presence of specific instance, but only does a general job to any instance or without an instance. In case of IJ.log, we know that there is only one Log window so we do not need to specify an instance. IJ.beep or IJ.openImage as well. 

In case of images, we know that there could be many different instances of images such as a image from channel 1 and another image from channel2. Though they all belong to a same ImagePlus class, they are different instances of ImagePlus.  

GaussianBlur is a class that does Gaussian blurring. It's methods are all none static but one, and for these non-static methods to work, an instance of GaussianBlur class should be constructed first. It's also that this class should be imported before it is being in use. Use 

    from [package name] import [class name]
    
to do so. If this class is not explicitly imported and used, there will be an error message:

>ImportError: cannot import name GaussianBlur

	# import class explicitly
	from ij.plugin.filter import GaussianBlur
    
	#Constructs an instance of Gaussian Blur object
	gb = GaussianBlur()

You could see how to construct an instance in the "constructor summary" in the Javadoc.

Now the actual object of GaussianBlur, gb, is available, you could blur an image by using a method

	blurGaussian(ImageProcessor ip, double sigmaX, double sigmaY, double accuracy) 
	
which would look like 

	gb.blurGaussian(imp.getProcessor(), 5.0, 5.0, 0.02)

The code for loading an image and do GaussianBlur filtering would look like this:

```python
#Loading image
import os

root = '/Volumes/data/bio-it_centres_course/data/course'
filename = '--W00005--P00001--Z00000--T00000--dapi.tif'
fullpath = os.path.join(root, filename)
imp = IJ.openImage(fullpath)

# Until here, it's all the same.
# import class explicitly
from ij.plugin.filter import GaussianBlur

# Construct an instance of Gaussian Blur object 
gb = GaussianBlur() 
gb.blurGaussian(imp.getProcessor(), 5.0, 5.0, 0.02)
imp.show()

```
Similarly, many classes for processing and analysis works only after constructing its instance. Here is another example, using a class ProfilePlot. Before running this code, please open an image on your desktop, place a line ROI. 

```python
imp = IJ.getImage()
pf = ProfilePlot(imp)
profile = pf.getProfile()
for val in profile:
    print val
```
		
The second line of this code is the constructor that creates an instance of class ProfilePlot.The constructor in this case uses an argument. See the [Javadoc](http://rsbweb.nih.gov/ij/developer/api/ij/gui/ProfilePlot.html). The class ProfilePlot has three different constructors. 

* ProfilePlot() 
* ProfilePlot(ImagePlus imp) 
* ProfilePlot(ImagePlus imp, boolean averageHorizontally)

We could use any of these three constructors. The most basic one would be  

	pf = ProfilePlot()

but then we have not specified an image where we get the intensity profile. This is not usable at all. For this reason, we use 

	pf = ProfilePlot(imp)

to specify the image that we want to work on in the constructor. 
	
We now combine the above code with the python package csv to write the output to a comma separated value text file. 

	import csv
	
	imp = IJ.getImage()
	pf = ProfilePlot(imp)
	profile = pf.getProfile()
	for val in profile:
		print val
	f = open('/Users/miura/Desktop/prof.csv', 'wb')
	writer = csv.writer(f)
	for index, val in enumerate(profile):
		writer.writerow([index, val])
	f.close()


## Workflow: Implementing Image Analysis

### Background Subtraction for VSVG and PM images. 

Now we start implementing the image processing & analysis of image data. We do this step by step - meaning write several lines, execute to test and then if it's successful, we go on to write more.

Let's first set the path to the image file and load it. We've done this already, so you should be able to understand this.

```python
import os

#path information
root = '/g/data/bio-it_centres_course/data/course'
filepm = '--W00005--P00001--Z00000--T00000--pm-647.tif'
filevsvg = '--W00005--P00001--Z00000--T00000--vsvg-sfp.tif'
fullpath = os.path.join(root, filepm)

#Load an image
imp = IJ.openImage(fullpath)
imp.show()
```

We then get the ImageProcessor object of the current ImagePlus object and do the statistics to get minimum and mean intensity of the current image.

```
#Get the ImageProcessor object of current image
ip = imp.getProcessor()

#Get ImageStatistics object of current ImageProcessor Object
impstats = ip.getStatistics()

#Get rtatistics results
ipmin = impstats.min
ipmean = impstats.mean
```
**getStatistics** method returns an ImageStatistics object which does statistical calculations and holds the results. All of these results can be directly accessed as field values (field values - this is new in this tutorial). You could also get other statistics results, which are listed as "Field Summary" of its Javadoc:

<http://rsbweb.nih.gov/ij/developer/api/ij/process/ImageStatistics.html>

You could test to print out some of these values.
```
print 'Median:', impstats.median
print 'SD:', impstats.stdDev
print 'Histogram:', impstats.histogram
```

Note that the field 'histogram' returns a list. Note also that fields labeled "protected" cannot be accessed.

We now know the minimum and the mean pixel values, so we select the region bounded by these lower and upper values. We do intensity threshold.

```
ip.setThreshold(ipmin, ipmean, ImageProcessor.RED_LUT)
```

setThreshold is a method of class ImageProcessor and has three arguments. 

1. lower threshold value
2. upper threshold value
3. LUT update (a number)

The first and the second arguments are obvious what they are, but the third one probably is not. This value determines the highlighting color of thresholded area. There are three different ways:

1. red (RED_LUT, 0)
2. black and white (BLACK_AND_WHITE_LUT, 1)
3. no update (NO_LUT_UPDATE, 2)
4. green and blue (OVER_UNDER_LUT, 3)

So if you want red highlighted area, then you could put 0 as the third argument. 

How could we know such options are there? They are actually listed as constant field values:

<http://rsbweb.nih.gov/ij/developer/api/constant-values.html#ij.process.ImageProcessor.RED_LUT>

They are a special type of field values associated with class ImageProcessor and hold constant values. For example, ImageProcessor.RED_LUT is 0. Check this by running the following code.

```
print ImageProcessor.RED_LUT
print ImageProcessor.BLACK_AND_WHITE_LUT
print ImageProcessor.NO_LUT_UPDATE
print ImageProcessor.OVER_UNDER_LUT
```

The key point here is that these field values have a very descriptive name of what they are doing. This allows the programmer to easily select one of the options of how highlighting will appear as the result of intensity thresholding.

In our case we do not care because we don't need to check the thresholded area visually. However, only because the setThreshold method needs a third argument, we set it to a default value.

We now measure the pixel values only those which were selected by this thresholding. For measurement, we now use [the getSatistics method of ImageStatistics class](http://rsbweb.nih.gov/ij/developer/api/ij/process/ImageStatistics.html#getStatistics(ij.process.ImageProcessor, int, ij.measure.Calibration)):

> static ImageStatistics	getStatistics(ImageProcessor ip, int mOptions, Calibration cal)

From this, we understand that 

* This is a static method so we can use it directly without constructing an instance. 
* It returns an ImageSatistics object.
* There are three arguments:
  1. An image processor object
  2. measurement options, a number
  3. Calibration object

The first one is obvious, the image that we are working on. The second is a specific number that sets the measurement option.
Looking through [the Javadoc of ImageStatistics class](http://rsbweb.nih.gov/ij/developer/api/ij/process/ImageStatistics.html), you will find a small table of "Fields inherited from interface ij.measure.Measurements". They are listed in the constant field value table. 

<http://rsbweb.nih.gov/ij/developer/api/constant-values.html#ij.measure.Measurements.AREA>

As we want to get a mean value of thresholded area, we need to have the option

ImageStatistics.MEAN

At the same time, we also need to set the statistics to be computed only from thresholded area so 

ImageStatistics.LIMIT

We add these values to get a specific number that set these options active.

```python
#set measurement option
measOpt = ImageStatistics.MEAN + ImageStatistics.LIMIT

#get statistics of thresholded area
impstats = ImageStatistics.getStatistics(ip, measOpt, None)
```
As we do not need calibration, we set it to null (in Java) or None (in Python).

Now the measurement is done so we can use the measured mean intensity to subtract it from image (background subtraction, finally)
```python
backlevel = impstats.mean

ip.resetThreshold()

# subtract background level
ip.subtract(backlevel)
print imp.getTitle(), " : background intensity - ", backlevel
```

Taking all these fragments into one, we now have a script that does background subtraction. 


```python
import os

#path information
root = '/g/data/bio-it_centres_course/data/course'
filepm = '--W00005--P00001--Z00000--T00000--pm-647.tif'
filevsvg = '--W00005--P00001--Z00000--T00000--vsvg-sfp.tif'
fullpath = os.path.join(root, filepm)

#Load an image
imp = IJ.openImage(fullpath)
imp.show()

#Get ImageProcessor object of current image
ip = imp.getProcessor()

#Get ImageStatistics object of current ImageProcessor Object
impstats = ip.getStatistics()

#Get rtatistics results
ipmin = impstats.min
ipmean = impstats.mean

#lower threshold = minimal intensity
#upper threshold = mean intensity
ip.setThreshold(ipmin, ipmean, ImageProcessor.RED_LUT)

#set measurement option
measOpt = ImageStatistics.MEAN + ImageStatistics.LIMIT

#get statistics of thresholded area
impstats = ImageStatistics.getStatistics(ip, measOpt, None)
backlevel = impstats.mean

ip.resetThreshold()

# subtract background level
ip.subtract(backlevel)
print imp.getTitle(), " : background intensity - ", backlevel
```

In this code, only plasma membrane image is processed. To do the background subtraction for VSVG image, we could duplicate the code and replace the path for "IJ.openImage(path)", but a smarter way of this is to create a function like below.

```python
import os

root = '/Volumes/data/bio-it_centres_course/data/course'
filepm = '--W00005--P00001--Z00000--T00000--pm-647.tif'
filevsvg = '--W00005--P00001--Z00000--T00000--vsvg-cfp.tif'

def backSub(imp):
    imp.show()
    ip = imp.getProcessor()
    impstats = ip.getStatistics()
    ipmin = impstats.min
    ipmean = impstats.mean
    #ipmax = impstats.max 
    ip.setThreshold(ipmin, ipmean, ImageProcessor.RED_LUT)
    measOpt = ImageStatistics.MEAN + ImageStatistics.LIMIT
    impstats = ImageStatistics.getStatistics(ip, measOpt, None)
    backlevel = impstats.mean
    ip.resetThreshold()
    ip.subtract(backlevel)
    print imp.getTitle(), " : background intensity - ", backlevel

fullpath = os.path.join(root, filepm)
imp = IJ.openImage(fullpath)
backSub(imp)

fullpath = os.path.join(root, filevsvg)
imp = IJ.openImage(fullpath)
backSub(imp)
```



### Nucleus segmentation

A script for processing single image dataset is:

<https://gist.github.com/miura/9765308>

```python
from ij.plugin.filter import GaussianBlur
from fiji.threshold import Auto_Local_Threshold as ALT
from ij.plugin.filter import ParticleAnalyzer as PA
from org.jfree.data.statistics import BoxAndWhiskerCalculator
from java.util import ArrayList, Arrays
import os

# size of juxtanuclear region. In pixels.
RIMSIZE = 15
# image background is expected to be black. 
Prefs.blackBackground = True
# verbose output
VERBOSE = False

root = '/Volumes/data/bio-it_centres_course/data/course'
filedapi = '--W00005--P00001--Z00000--T00000--dapi.tif'

nucpath = os.path.join(root, filedapi)

impN = IJ.openImage(nucpath)

class InstBWC(BoxAndWhiskerCalculator):
    def __init__(self):
        pass
        
def getOutlierBound(rt):
  """ Analyzes the results of the 1st partcile analysis.
  Since the dilation of nuclear perimeter often causes 
  overlap of neighboring neculeus 'terrirories', such nucleus 
  are discarded from the measurements. 

  Small nucelei are already removed, but since rejection of nuclei depends on 
  standard outlier detection method, outliers in both smaller and larger sizes
  are discarded. 
  """
  area = rt.getColumn(rt.getColumnIndex('Area'))
  circ = rt.getColumn(rt.getColumnIndex("Circ."))
  arealist = ArrayList(Arrays.asList(area.tolist()))
  circlist = ArrayList(Arrays.asList(circ.tolist()))
  bwc = InstBWC()
  ans = bwc.calculateBoxAndWhiskerStatistics(arealist)
  #anscirc = bwc.calculateBoxAndWhiskerStatistics(circlist)
  if (VERBOSE):
    print ans.toString()
    print ans.getOutliers()
  q1 = ans.getQ1()
  q3 = ans.getQ3()
  intrange = q3 - q1 
  outlier_offset = intrange * 1.5
  return q1, q3, outlier_offset

def nucleusSegmentation(imp2):
    """ Segmentation of nucleus image. 
    Nucleus are selected that:
    1. No overlapping with dilated regions
    2. close to circular shape. Deformed nuclei are rejected.
    Outputs a binary image.
    """
#Convert to 8bit
    ImageConverter(imp2).convertToGray8()
#blur slightly using Gaussian Blur 
    radius = 2.0
    accuracy = 0.01
    GaussianBlur().blurGaussian( imp2.getProcessor(), radius, radius, accuracy)
# Auto Local Thresholding
    imps = ALT().exec(imp2, "Bernsen", 15, 0, 0, True)
    imp2 = imps[0]


#ParticleAnalysis 0: prefiltering by size and circularity
    rt = ResultsTable()
    paOpt = PA.CLEAR_WORKSHEET +\
                    PA.SHOW_MASKS +\
                    PA.EXCLUDE_EDGE_PARTICLES +\
                    PA.INCLUDE_HOLES #+ \
#		PA.SHOW_RESULTS 
    measOpt = PA.AREA + PA.STD_DEV + PA.SHAPE_DESCRIPTORS + PA.INTEGRATED_DENSITY
    MINSIZE = 20
    MAXSIZE = 10000
    pa0 = PA(paOpt, measOpt, rt, MINSIZE, MAXSIZE, 0.8, 1.0)
    pa0.setHideOutputImage(True)
    pa0.analyze(imp2)
    imp2 = pa0.getOutputImage() # Overwrite 
    imp2.getProcessor().invertLut()
    impNuc = imp2.duplicate()	## for the ring. 
    #impNuc = Duplicator().run(imp2)

#Dilate the Nucleus Area
## this should be 40 pixels in Cihan's method, but should be smaller. 
    rf = RankFilters()
    rf.rank(imp2.getProcessor(), RIMSIZE, RankFilters.MAX)

#Particle Analysis 1: get distribution of sizes. 

    paOpt = PA.CLEAR_WORKSHEET +\
                    PA.SHOW_NONE +\
                    PA.EXCLUDE_EDGE_PARTICLES +\
                    PA.INCLUDE_HOLES #+ \
#		PA.SHOW_RESULTS 
    measOpt = PA.AREA + PA.STD_DEV + PA.SHAPE_DESCRIPTORS + PA.INTEGRATED_DENSITY
    rt1 = ResultsTable()
    MINSIZE = 20
    MAXSIZE = 10000
    pa = PA(paOpt, measOpt, rt1, MINSIZE, MAXSIZE)
    pa.analyze(imp2)
    #rt.show('after PA 1')
#particle Analysis 2: filter nucleus by size and circularity. 
    #print rt1.getHeadings()
    if (rt1.getColumnIndex('Area') > -1):
      q1, q3, outlier_offset = getOutlierBound(rt1)
    else:
      q1 = MINSIZE
      q3 = MAXSIZE
      outlier_offset = 0
      print imp2.getTitle(), ": no Nucleus segmented,probably too many overlaps"

    paOpt = PA.CLEAR_WORKSHEET +\
                    PA.SHOW_MASKS +\
                    PA.EXCLUDE_EDGE_PARTICLES +\
                    PA.INCLUDE_HOLES #+ \
#		PA.SHOW_RESULTS 
    rt2 = ResultsTable()
    pa = PA(paOpt, measOpt, rt2, q1-outlier_offset, q3+outlier_offset, 0.8, 1.0)
    pa.setHideOutputImage(True)
    pa.analyze(imp2)
    impDilatedNuc = pa.getOutputImage() 

#filter original nucleus

    filteredNuc = ImageCalculator().run("AND create", impDilatedNuc, impNuc)
    return filteredNuc    
      
imp2 = impN.duplicate()
impfilteredNuc = nucleusSegmentation(imp2)
impfilteredNuc.show()

```
<https://gist.github.com/miura/9644827>


### ROI generator, Measurements & Transport Ratio

* Accessing ResultsTable, read and write
* ParticleAnalysis class
* from x import y as z
* ROI, ShapeRoi classes
* Implementing Java Interface
* ImageCalculator class

```python
import os, sys
from ij.plugin.filter import ParticleAnalyzer as PA

# size of juxtanuclear region. In pixels.
RIMSIZE = 15

def roiRingGenerator(r1):
  """ Create a band of ROI outside the argument ROI.
  See Liebel (2003) Fig. 1
  """
  #r1 = imp.getRoi()
  r2 = RoiEnlarger.enlarge(r1, RIMSIZE)
  sr1 = ShapeRoi(r1)
  sr2 = ShapeRoi(r2)
  return sr2.not(sr1)

def roiEnlarger(r1):
  """ Enlarges ROI by a defined iterations.
  """
  return ShapeRoi(RoiEnlarger.enlarge(r1, RIMSIZE))

def measureROIs(imp, measOpt, thisrt, roiA, backint, doGLCM):    
  """ Cell-wise measurment using ROI array. 
  """
  analObj = Analyzer(imp, measOpt, thisrt)
  for index, r in enumerate(roiA):
    imp.deleteRoi()
    imp.setRoi(r)
    analObj.measure()
    maxint = thisrt.getValue('Max', thisrt.getCounter()-1)
    saturation = 0
    if ( maxint + backint) >= 4095:
      saturation = 1
      if (VERBOSE):
        print 'cell index ', index, 'maxint=', maxint
    thisrt.setValue('CellIndex', thisrt.getCounter()-1, index)
    thisrt.setValue('Saturation', thisrt.getCounter()-1, saturation)
  if (doGLCM):
    imp.deleteRoi()
    #measureTexture(imp, thisrt, roiA)
    
## loading files
root = '/Volumes/data/bio-it_centres_course/data/course'
fileNuc = 'dapiSegmented.tif'
filepm = 'pm-647BackSub.tif'
filevsvg = 'vsvg-cfpBackSub.tif'

nucfull = os.path.join(root, fileNuc)
pmfull = os.path.join(root, filepm)
vsvgfull = os.path.join(root, filevsvg)
impfilteredNuc = IJ.openImage(nucfull)
impPM = IJ.openImage(pmfull)
impVSVG = IJ.openImage(vsvgfull)

wnumber = '00005'

rtallcellPM = ResultsTable()
rtjnucVSVG = ResultsTable()
rtallcellVSVG = ResultsTable()
  

intmax = impfilteredNuc.getProcessor().getMax()
if intmax == 0:
    #return rtallcellPM, rtjnucVSVG, rtallcellVSVG
    exit()

impfilteredNuc.getProcessor().setThreshold(1, intmax, ImageProcessor.NO_LUT_UPDATE)
nucroi = ThresholdToSelection().convert(impfilteredNuc.getProcessor())
nucroiA = ShapeRoi(nucroi).getRois()
#print nucroiA
allcellA = [roiEnlarger(r) for r in nucroiA]
jnucroiA = [roiRingGenerator(r) for r in nucroiA]

measOpt = PA.AREA + PA.MEAN + PA.CENTROID + PA.STD_DEV + PA.SHAPE_DESCRIPTORS + PA.INTEGRATED_DENSITY + PA.MIN_MAX +\
    PA.SKEWNESS + PA.KURTOSIS + PA.MEDIAN + PA.MODE

## All Cell Plasma Membrane intensity
measureROIs(impPM, measOpt, rtallcellPM, allcellA, 0, True)
meanInt_Cell = rtallcellPM.getColumn(rtallcellPM.getColumnIndex('Mean'))
print "Results Table rownumber:", len(meanInt_Cell)
# JuxtaNuclear VSVG intensity 
measureROIs(impVSVG, measOpt, rtjnucVSVG, jnucroiA, 0, False)    
meanInt_jnuc = rtjnucVSVG.getColumn(rtjnucVSVG.getColumnIndex('Mean'))

# AllCell VSVG intensity 
measureROIs(impVSVG, measOpt, rtallcellVSVG, allcellA, 0, True)    
meanInt_vsvgall = rtallcellVSVG.getColumn(rtallcellVSVG.getColumnIndex('Mean'))


for i in range(len(meanInt_Cell)):
    if meanInt_Cell[i] != 0.0:
        transportR = meanInt_jnuc[i] / meanInt_Cell[i]
        transportRall = meanInt_vsvgall[i] / meanInt_Cell[i]
    else:
        transportR = float('inf')
        transportRall = float('inf')
    rtjnucVSVG.setValue('TransportRatio', i, transportR)
    rtallcellVSVG.setValue('TransportRatio', i, transportRall)
    rtjnucVSVG.setValue('WellNumber', i, int(wnumber)) 
    rtallcellVSVG.setValue('WellNumber', i, int(wnumber))
    rtallcellPM.setValue('WellNumber', i, int(wnumber)) 

rtallcellVSVG.show('AllCell')
```

### Pre-screening of Images.

We will not go over the details of full processing, but the pre-screening code is a good example of accessing multiple files and process images. 

<https://gist.github.com/miura/9684453>

Pre-screen results are saved under

	/g/data/bio-it_centres_course/data/VSVG/prescreen
	
## Final Code

Assembling all the fragments as a single script, here is the final code to submit. 

<https://github.com/miura/HTManalysisCourse/blob/master/measTransportBatch3.py>

An important command that appears only here is 'sys.argv`, which holds the argument added in the command line. Try the following to see what is happening. 

 Create a file 'testargv.py' with following code. 

```python
import sys
print 'The argument given: ', sys.argv
```

Save the file, then run it from the command line. 

```
fiji --mem1000m testargv.py testarg1 testarg2
```
The output should look like

```
miura@compute-n026<19>
[/g/data/bio-it_centres_course/data/course ]
fiji --mem=2000m testargv.py testarg1 testarg2

No GUI detected.  Falling back to headless mode.
No GUI detected.  Falling back to headless mode.
the argument givien:  ['testargv.py', 'testarg1', 'testarg2']
```

Within the running Jython instance, command line arguments are passed to the program via sys.argv. In our case, we pass name of the plate to process to the script.

As an example, if you want to process the first plate (0001-03--2005-08-01) and save outputs (measurements) to a folder named 'out_kota', the command will be
```
fiji --mem2000m 0001-03--2005-08-01 out_kota
```
As there is no line in the script to create a new folder, 'out_kota' should be created manually before doing this. If there is any problem with memory, try increasing it a bit, such as `--mem2500m` or so. 

##Generating Job Array

Here is the code written by Clemens. 

<https://github.com/miura/HTManalysisCourse/blob/master/fiji_script.sh>

```sh
#!/bin/bash -e
# Read-only filesystem error occurs sometimes
#     Appears to be due to mounting issues or file system limitations
#     Retry if it occurs
BASE_DIR="/g/data/bio-it_centres_course/data/VSVG"
SUB_DIR="${BASE_DIR}/fiji-sub"
LOG_DIR="${BASE_DIR}/fiji-log"
PRE_DIR="${BASE_DIR}/prescreen"
# The first version of the python script gave an error for some plates
#JYTHON_SCRIPT="/g/almf/software/scripts2/measTransportBatch.py"
#JYTHON_SCRIPT="/g/almf/software/scripts2/measTransportBatch2.py"
JYTHON_SCRIPT="/g/almf/software/scripts2/measTransportBatch3.py"

cd ${BASE_DIR}
[ -d fiji-sub ] || mkdir fiji-sub
[ -d fiji-log ] || mkdir fiji-log
[ -d fiji-out ] || mkdir fiji-out

for a in `ls ${BASE_DIR} | grep "\-\-"`
do
    PLATE=${a}

    # Check if prescreen exists
    if [ ! -f ${PRE_DIR}/${PLATE}.csv ]; then
        echo "Skipping plate ${PLATE}: no pre-screen data."
        continue
    fi
    OO="${LOG_DIR}/${PLATE}-out.txt"
    EO="${LOG_DIR}/${PLATE}-err.txt"
    TARGET_DIR="${PLATE}"
    OUTPUT_DIR="fiji-out"

    # Continue if output already exists - no need to re-run
    if [ -f ${OUTPUT_DIR}/${PLATE}--PMall.csv ]; then
        echo "Skipping plate ${PLATE}: results already exist."
        continue
    fi

    # Write the bsub script
    echo "#!/bin/bash
#BSUB -oo \"${OO}\"
#BSUB -eo \"${EO}\"
#BSUB -M 8000
#BSUB -R select[mem>8000] -R rusage[mem=8000]
ulimit -c 0
export PATH=/g/almf/software/bin2:\${PATH}
echo \"The job started:\"
java -version
JYTHON_SCRIPT=${JYTHON_SCRIPT}
TARGET_DIR=${TARGET_DIR}
OUTPUT_DIR=${OUTPUT_DIR}
echo \"Fiji started:\"
fiji --headless --mem=1000m ${JYTHON_SCRIPT} ${TARGET_DIR} ${OUTPUT_DIR}" > ${SUB_DIR}/${PLATE}.bsub

    # Submit the job to the cluster
    chmod +x ${SUB_DIR}/${PLATE}.bsub
    bsub < ${SUB_DIR}/${PLATE}.bsub
done

```








