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


[Back to ImageJ](ImageJ.html)
