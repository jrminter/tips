---
title: "Scripting ImageJ using Groovy"
author: "J. R. Minter"
date: "Started: 2019-05-22, Last modified: 2019-05-22"
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


Jan Eglinger (imagejan on the forum.image.sc) is a proponent of Groovy
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

The main site for Groovy is [groovy-lang.org](http://groovy-lang.org/).

There is a [Groovy Scripting](https://imagej.net/Groovy_Scripting) page on
ImageJ.net that refers to the Groovy
[Getting Started](http://groovy-lang.org/documentation.html#gettingstarted)
page.

[Groovy Syntax](http://groovy-lang.org/syntax.html)

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
a 32 bit image of my [head shot](groovy/john_32.png).


[Back to ImageJ](ImageJ.html)
