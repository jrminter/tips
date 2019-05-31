---
title: "Analyze AO Stage Micrometer from BX61"
author: "J. R. Minter"
date: "Started: 2013-07-16, Last modified: 2019-05-30"
output:
  html_document:
    keep_md: yes
    css: ../theme/jm-gray-vignette.css
    number_sections: yes
    toc: yes
    toc_depth: 3
---

[Back to ImageJ](ImageJ.html)

I had recorded an image on the Olympus BX-16 microscope at 10X. The metadata
from the original image is shown below.

![Metadata from SIS Viewer](tif/stage-micrometer/BX61-10X-1-AO-micro.png)

The image (reduced to 8 bits/pix) is shown below.

![The image reduced to 8 bits per pixel. One large divison is $100\ \mu m$.](tif/stage-micrometer/BX61-10X-1-AO-micro-cal-ori.png)

After cropping the image to measure just the large divisons and applying an
automatic threshold to segment the lines I obtained the image below.


![The thresholded image with segments detected.](tif/stage-micrometer/BX61-10X-1-AO-Micro-crop-ovl.png)

An enlarged view of the first two lines is shown below.


![The first two lines detected.](tif/stage-micrometer/pair-of-line-spacings.png)

The measurement data was stored to a `.csv` file for analysis.

Let's read in the data


```r
df <-read.csv2("tif/stage-micrometer/BX61-10X-1-AO-micro.csv", sep=',', stringsAsFactors =FALSE)
library(knitr)
kable(df)
```



 ID   Area   Mean   Min   Max  XM         YM     
---  -----  -----  ----  ----  ---------  -------
  1    147    255   255   255  172.983    13.704 
  2    129    255   255   255  310.438    13.453 
  3    140    255   255   255  447.214    13.550 
  4    176    255   255   255  583.455    13.580 
  5    135    255   255   255  720.433    12.796 
  6    145    255   255   255  857.769    13.521 
  7    130    255   255   255  994.500    13.000 
  8    146    255   255   255  1131.829   13.356 
  9    135    255   255   255  1268.389   12.848 
 10    137    255   255   255  1406.128   12.945 
 11    131    255   255   255  36.210     14.233 
 12      1    255   255   255  1263.500   1.500  

Note that the area of the last measurement is 1 pixel. This is spurious. We need
to filter out the last row.

We can do this using base R as shown below



```r
df_good <- df[df$Area>1,]
kable(df)
```



 ID   Area   Mean   Min   Max  XM         YM     
---  -----  -----  ----  ----  ---------  -------
  1    147    255   255   255  172.983    13.704 
  2    129    255   255   255  310.438    13.453 
  3    140    255   255   255  447.214    13.550 
  4    176    255   255   255  583.455    13.580 
  5    135    255   255   255  720.433    12.796 
  6    145    255   255   255  857.769    13.521 
  7    130    255   255   255  994.500    13.000 
  8    146    255   255   255  1131.829   13.356 
  9    135    255   255   255  1268.389   12.848 
 10    137    255   255   255  1406.128   12.945 
 11    131    255   255   255  36.210     14.233 
 12      1    255   255   255  1263.500   1.500  

All we really need is the `XM` columnm, so we can run


```r
df <- df[df$Area>1,]
xm <- as.numeric(df$XM)
xm
```

```
 [1]  172.983  310.438  447.214  583.455  720.433  857.769  994.500
 [8] 1131.829 1268.389 1406.128   36.210
```

Note the last value is unusual...


```r
delta_xm <- diff(xm)
delta_xm
```

```
 [1]   137.455   136.776   136.241   136.978   137.336   136.731   137.329
 [8]   136.560   137.739 -1369.918
```

Yes, the last value is spurious...


```r
delta_xm <- delta_xm[1:9]
delta_xm
```

```
[1] 137.455 136.776 136.241 136.978 137.336 136.731 137.329 136.560 137.739
```

These look as expected. However, they are in units of `px/100 microns`. We really
want `microns/px`, so we do a transformation


```r
px_per_um <- 100.0/delta_xm
px_per_um
```

```
[1] 0.7275108 0.7311224 0.7339934 0.7300442 0.7281412 0.7313630 0.7281783
[8] 0.7322789 0.7260108
```


```r
library(dplyr)
med <- median(px_per_um)
std_dev <- sd(px_per_um)

df_px_per_um <- as_tibble(data.frame(statistic=c("median", "std_dev"),
                                 px_per_um=round(c(med, std_dev),4)))
kable(df_px_per_um)
```



statistic    px_per_um
----------  ----------
median          0.7300
std_dev         0.0026



[Back to ImageJ](ImageJ.html)
