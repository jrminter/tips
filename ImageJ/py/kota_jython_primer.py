"""
Kota Miura's Jython primer from

https://github.com/miura/HTManalysisCourse

stored in this gist
https://gist.github.com/miura/9687511

# start with IJ1
/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --ij1

# start with IJ2 - my normal startup
/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --ij2

/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --print-ij-dir

/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --print-java-home

/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --help

produces

jrminter$ /Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --help
Usage: /Applications/Fiji.app/Contents/MacOS/ImageJ-macosx [<Java options>.. --] [<ImageJ options>..] [<files>..]

ImageJ launcher 5.0.0-SNAPSHOT (build 38792b0d)
Java options are passed to the Java Runtime, ImageJ
options to ImageJ (or Jython, JRuby, ...).

In addition, the following options are supported by ImageJ:
General options:
--help, -h
	show this help
--dry-run
	show the command line, but do not run anything
--info
	informational output
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
--debugger=<port>[,suspend]
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
--clojure
	start Clojure instead of ImageJ (this is the 
	default when called with a file ending in .clj)
--beanshell
--bsh
	start BeanShell instead of ImageJ (this is the
	default when called with a file ending in .bs or .bsh
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





"""

a = 1
b = 2
c = a + b
print c

a = '1'
b = '2'
c = a + b
print c

def addition(x, y):
	z = x + y
	return z

d = addition(a, b)
print d

#Creating a list
l = [8, 7, 100, 1] 

print l
print l[0] #specify index
print l[2] #specify index
print len(l) # length of the list
print sorted(l) #sorting the list

#Creating a list with evenly spaced elements

# 10 elements
ll = range(10) 
print ll

#the last index
print ll[len(ll)-1] 

#secify a range (slicing)
print ll[1:3] 

# check what happens
ll = range(10, 20)
print ll
ll = range(10, 20, 2)

#append a value
ll.append(1000)
print ll

#concatenate lists
lll = l + ll 
print lll

l = [8, 7, 100, 1] 
for a in l:
	print a

for b in range(10):
	print b

l = ['abc', 'efg', 'hij']
for b in l:
	print b

for i, b in enumerate(l):
	print i, b


a = 1
b = 2
if a == b: # 'equal to'
	print 'same'

if a != b: # 'not equal to'
	print 'different'

# combined
if a == b:
	print 'same'
else:
	print 'different'

a= 1
b= 2
print a == b
print a != b

if True:
	print 'prints always'

if False:
	print 'never prints'
else:
	print 'always printed'

#String
file1 = 'data.tif'
file2 = 'data.jpg'
print file1.endswith('.jpg')
print file1.endswith('.tif')
print file2.endswith('.tif')

print len(file1)
print file1[4:6]

file1 = 'data.tif'
def checkJPG(fname):
	if fname.endswith('jpg'):
		return True
	else:
		return False
print 'jpg file:', checkJPG(file1)

#Dictionary, key-value pairs

dd = {'vsvg':'abc.tif', 'pm':'cde.tif', 'dapi':'efg.tif'}
print dd['vsvg']
print dd['dapi']

print dd.keys()
print dd.values()