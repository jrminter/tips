---
title: "Analyzing POL4455 using ParticleSizer"
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
Linux, but this part can be turned off in the IJ-Prefs.txt file.

I analyzed my background-subtrated POL4455 image

![My background subtracted image after a 2 px median filter and inverting the graylevel image to follow ParticSizer's convention ](png/POL-4455-16bit-Img01-bks-mf_inv.png)

![My image after measurement with the overlay on the particles and burning a scale bar. ](png/POL-4455-16bit-Img01-bks-ana.png)

# Read in the data with R


```r
library(dplyr)
fi <-'./csv/pol4455-particle_sizer.csv'
df <- read.csv(fi, header=TRUE, as.is=TRUE)
df <- as_tibble(df)
df
```

```
# A tibble: 1,083 x 26
   Frame Label      X     Y  Area Area.Conv..Hull Peri. Peri..Conv..Hull
   <int> <int>  <dbl> <dbl> <dbl>           <dbl> <dbl>            <dbl>
 1     1     1   78.4  17.5 1088.           1118.  115.             116.
 2     1     2  994.   22.1  943.            957.  105.             107.
 3     1     3 1074.   27.0 1361.           1398.  127.             129.
 4     1     4  640.   26.1 1069.           1097.  113.             114.
 5     1     5 1162.   26.1 1239.           1267.  121.             123.
 6     1     6 1245.   28.4 1316.           1347.  125.             127.
 7     1     7  464.   30.0 1505.           1529.  133.             135.
 8     1     8  384.   29.5 1284.           1309.  124.             125.
 9     1     9 1331.   29.7 1344.           1361.  124.             128.
10     1    10  559.   33.7 1321.           1365.  130.             130.
# … with 1,073 more rows, and 18 more variables: Feret <dbl>,
#   Min..Feret <dbl>, Maximum.inscriped.circle.diameter <int>,
#   Area.equivalent.circle.diameter <dbl>, Long.Side.Length.MBR <dbl>,
#   Short.Side.Length.MBR <dbl>, Aspect.Ratio <dbl>, Area.Peri. <dbl>,
#   Circ. <dbl>, Elong. <dbl>, Convexity <dbl>, Solidity <dbl>,
#   Num..of.Holes <int>, Thinnes.Rt. <dbl>, Contour.Temp. <dbl>,
#   Orientation <dbl>, Fract..Dim. <dbl>, Fract..Dim..Goodness <dbl>
```

```r
bSave = FALSE
area = df$Area
peri = df$Peri.

trad_circ = 4.0*pi*area/peri^2
summary(trad_circ)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 0.8354  1.0453  1.0537  1.0518  1.0629  1.1054 
```

```r
particles <- as_tibble(data.frame(lab=df$Label,
                                  ecd=df$Area.equivalent.circle.diameter,
                                  ar=df$Aspect.Ratio, circ=df$Circ., elong=df$Elong.,
                                  conv=df$Convexity))
particles
```

```
# A tibble: 1,083 x 6
     lab   ecd    ar  circ elong  conv
   <int> <dbl> <dbl> <dbl> <dbl> <dbl>
 1     1  37.2  1.31  12.1 0.464     1
 2     2  34.6  1     11.6 0.197     1
 3     3  41.6  1.04  11.9 0.133     1
 4     4  36.9  1.09  11.9 0.304     1
 5     5  39.7  1     11.8 0.221     1
 6     6  40.9  1.04  11.8 0.208     1
 7     7  43.8  1.04  11.7 0.2       1
 8     8  40.4  1     11.9 0.167     1
 9     9  41.4  1     11.5 0.112     1
10    10  41.0  1.14  12.8 0.405     1
# … with 1,073 more rows
```
# The measure of circularity

I am **really** confused by the `circularity` value reported by ParticleSizer.
I noticed that all the values are close to 12. I am used to the definition of
circularity as defined by [Wikipedia](https://en.wikipedia.org/wiki/Shape_factor_(image_analysis_and_microscopy)#Circularity)
as

$\frac{4  \pi A}{P^2}$

that ranges from 0 to 1.0


```r
library(ggplot2)
```

```
## Registered S3 methods overwritten by 'ggplot2':
##   method         from 
##   [.quosures     rlang
##   c.quosures     rlang
##   print.quosures rlang
```

```r
dfCircTest <- data.frame(trad_circ=trad_circ, Circ=df$Circ.)
# head(dfCircTest)
circPlt <-  ggplot(dfCircTest) +  
            geom_point(aes(x = trad_circ, y = Circ), colour="blue") +
            ylab(label="ParticleSizer circularity") + 
            xlab("'traditional' circularity") +
            ggtitle("Circularity measures from a monodisperse latex") +
            theme(axis.text=element_text(size=12),
                  axis.title=element_text(size=14),
                  plot.title = element_text(hjust = 0.5)) # center the title
            NULL
```

```
## NULL
```

```r
if (bSave == TRUE) {
  ggsave("png/pol4455-circularity-measures.png", plot=circPlt,
         width=6, height=4, units="in", dpi=150)
}
print(circPlt)
```

![](ana-pol4455_files/figure-html/testCircPlt-1.png)<!-- -->

# Plot the histogram of ECD


```r
library(ggplot2)

plt <- ggplot(particles, aes(ecd)) +
       geom_histogram(binwidth = 1.0) +
       ggtitle("Equivalent Circular Diameter") +
       theme(plot.title = element_text(lineheight=2, size=12)) +
       labs(x="diameter [nm]", y="Count") +
       ggtitle("Diameter distribution of soft latex particles in vitreous ice") +
       theme(axis.text=element_text(size=12), axis.title=element_text(size=14),
             plot.title = element_text(hjust = 0.5)) +
       NULL

if (bSave == TRUE) {
  ggsave("png/pol4455-ecd-histo.png", plot=plt,
         width=6, height=4, units="in", dpi=150)
}
print(plt)
```

![](ana-pol4455_files/figure-html/plotECD-1.png)<!-- -->


```r
library(ggplot2)

pltc <- ggplot(dfCircTest, aes(trad_circ)) +
        geom_histogram(binwidth = 0.01) +
        ggtitle("Circularity") +
        theme(plot.title = element_text(lineheight=2, size=12)) +
        labs(x="'traditional' circularity", y="Count") +
        ggtitle("Circularity distribution of soft latex particles in vitreous ice") +
        theme(axis.text=element_text(size=12), axis.title=element_text(size=14),
              plot.title = element_text(hjust = 0.5)) +
        NULL

if (bSave == TRUE) {
  ggsave("png/pol4455-trad-circ-histo.png", plot=pltc,
         width=6, height=4, units="in", dpi=150)
}
print(pltc)
```

![](ana-pol4455_files/figure-html/plot_trad_circ-1.png)<!-- -->



```r
library(ggplot2)

pltc <- ggplot(particles, aes(circ)) +
        geom_histogram(binwidth = 0.1) +
        theme(plot.title = element_text(lineheight=2, size=12)) +
        labs(x="'ParticleSizer' Circularity", y="Count") +
        ggtitle("Circularity distribution of soft latex particles in vitreous ice") +
        theme(axis.text=element_text(size=12), axis.title=element_text(size=14),
              plot.title = element_text(hjust = 0.5)) +
        NULL

if (bSave == TRUE) {
  ggsave("png/pol4455-part-sizer-circ-histo.png", plot=pltc,
         width=6, height=4, units="in", dpi=150)
}
print(pltc)
```

![](ana-pol4455_files/figure-html/plotTradCirc-1.png)<!-- -->

Try a linear distribution panel plot that uses base graphics. This assunmes
a linear (not lognormal) particle size distribution from my old `rAnaLab`
package.

Sometime I need to migrate this function to ggplot2...



```r
library(rAnaLab)

linear.distn.panel.plot(particles$ecd, n.brks = 25,
                        distn.lab = "ecd [nm]",
                        hist.legend = TRUE,
                        legend.loc = "topright",
                        kern.bw = "nrd0",
                        plt.median = TRUE,
                        scale.mult = 1.2)
```

![](ana-pol4455_files/figure-html/linearDistPanelPlot-1.png)<!-- -->

```r
if (bSave == TRUE) {
  png("png/linearDistPanelPlot.png", width=1024, height=768, pointsize=24)
  linear.distn.panel.plot(particles$ecd, n.brks = 25,
                         distn.lab = "ecd [nm]",
                         hist.legend = TRUE,
                         legend.loc = "topright",
                         kern.bw = "nrd0",
                         plt.median = TRUE,
                         scale.mult = 1.2)
  dev.off()
}
```

[Back to ImageJ](ImageJ.html)
