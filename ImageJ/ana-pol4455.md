---
title: "Analyzing POL4455 using ParticleSizer"
author: "J. R. Minter"
date: "Started: 2019-05-25, Last modified: 2019-05-27"
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

First load all the R packages we will need.


```r
library(dplyr)
library(ggplot2)
library(latex2exp)
```


```r
fi <-'./csv/pol4455-particle_sizer.csv'
df <- read.csv(fi, header=TRUE, as.is=TRUE)
df <- as_tibble(df)
summary(df)
```

```
     Frame       Label              X                 Y          
 Min.   :1   Min.   :   1.0   Min.   :  23.59   Min.   :  17.55  
 1st Qu.:1   1st Qu.: 271.5   1st Qu.: 424.91   1st Qu.: 390.21  
 Median :1   Median : 542.0   Median : 821.84   Median : 789.54  
 Mean   :1   Mean   : 542.0   Mean   : 806.79   Mean   : 781.03  
 3rd Qu.:1   3rd Qu.: 812.5   3rd Qu.:1203.36   3rd Qu.:1168.04  
 Max.   :1   Max.   :1083.0   Max.   :1546.60   Max.   :1545.56  
      Area      Area.Conv..Hull      Peri.        Peri..Conv..Hull
 Min.   : 294   Min.   : 303.4   Min.   : 58.12   Min.   : 59.94  
 1st Qu.:1214   1st Qu.:1241.5   1st Qu.:119.84   1st Qu.:121.92  
 Median :1321   Median :1348.9   Median :125.29   Median :127.21  
 Mean   :1310   Mean   :1340.2   Mean   :124.81   Mean   :126.54  
 3rd Qu.:1421   3rd Qu.:1456.2   3rd Qu.:130.58   3rd Qu.:132.20  
 Max.   :1865   Max.   :1904.3   Max.   :153.25   Max.   :152.43  
     Feret         Min..Feret    Maximum.inscriped.circle.diameter
 Min.   :21.28   Min.   :16.80   Min.   :0                        
 1st Qu.:40.36   1st Qu.:36.66   1st Qu.:0                        
 Median :42.25   Median :38.19   Median :0                        
 Mean   :42.16   Mean   :37.81   Mean   :0                        
 3rd Qu.:43.77   3rd Qu.:39.72   3rd Qu.:0                        
 Max.   :55.33   Max.   :45.83   Max.   :0                        
 Area.equivalent.circle.diameter Long.Side.Length.MBR
 Min.   :19.35                   Min.   :18.33       
 1st Qu.:39.31                   1st Qu.:38.19       
 Median :41.01                   Median :39.72       
 Mean   :40.74                   Mean   :39.53       
 3rd Qu.:42.54                   3rd Qu.:41.25       
 Max.   :48.73                   Max.   :51.22       
 Short.Side.Length.MBR  Aspect.Ratio     Area.Peri.         Circ.      
 Min.   :16.80         Min.   :1.000   Min.   : 5.059   Min.   :11.37  
 1st Qu.:36.66         1st Qu.:1.000   1st Qu.:10.097   1st Qu.:11.82  
 Median :38.19         Median :1.038   Median :10.526   Median :11.93  
 Mean   :37.90         Mean   :1.046   Mean   :10.445   Mean   :11.95  
 3rd Qu.:39.72         3rd Qu.:1.050   3rd Qu.:10.898   3rd Qu.:12.02  
 Max.   :45.83         Max.   :1.688   Max.   :12.402   Max.   :15.04  
     Elong.         Convexity        Solidity      Num..of.Holes
 Min.   :0.0510   Min.   :0.995   Min.   :0.9030   Min.   :0    
 1st Qu.:0.1770   1st Qu.:1.000   1st Qu.:0.9750   1st Qu.:0    
 Median :0.2200   Median :1.000   Median :0.9780   Median :0    
 Mean   :0.2266   Mean   :1.000   Mean   :0.9775   Mean   :0    
 3rd Qu.:0.2650   3rd Qu.:1.000   3rd Qu.:0.9810   3rd Qu.:0    
 Max.   :0.6800   Max.   :1.000   Max.   :0.9900   Max.   :0    
  Thinnes.Rt.     Contour.Temp.     Orientation       Fract..Dim.   
 Min.   :0.8350   Min.   :0.0650   Min.   :  0.093   Min.   :1.128  
 1st Qu.:1.0000   1st Qu.:0.1310   1st Qu.: 83.968   1st Qu.:1.538  
 Median :1.0000   Median :0.1390   Median :130.767   Median :1.567  
 Mean   :0.9991   Mean   :0.1382   Mean   :114.348   Mean   :1.560  
 3rd Qu.:1.0000   3rd Qu.:0.1460   3rd Qu.:156.131   3rd Qu.:1.590  
 Max.   :1.0000   Max.   :0.1710   Max.   :179.535   Max.   :1.687  
 Fract..Dim..Goodness
 Min.   :0.8500      
 1st Qu.:0.9650      
 Median :0.9660      
 Mean   :0.9638      
 3rd Qu.:0.9660      
 Max.   :0.9910      
```


# The measure of circularity

I am **really** confused by the `circularity` value reported by ParticleSizer.
I noticed that all the values are close to 12. I am used to the definition of
circularity as defined by [Wikipedia](https://en.wikipedia.org/wiki/Shape_factor_(image_analysis_and_microscopy)#Circularity)
as

$\frac{4  \pi A}{P^2}$

that ranges from 0 to 1.0

The circularity is odd... Let's look at the histogram of the
circularity


```r
c_plt <- ggplot(df, aes(Circ.)) +
         geom_histogram(binwidth = 0.05) +
         ggtitle("Circularity") +
         theme(plot.title = element_text(lineheight=2, size=12)) +
         labs(x="Circularity", y="Count") +
         ggtitle("Raw distribution of circularity") +
         theme(axis.text=element_text(size=12), axis.title=element_text(size=14),
               plot.title = element_text(hjust = 0.5)) +
         NULL

print(c_plt)
```

![](ana-pol4455_files/figure-html/rawCircHisto-1.png)<!-- -->





After a discussion on the ImageJ
[Forum](https://forum.image.sc/t/circularity-measure-in-particlesizer-plug-in/26068)
we think the issue is a factor of $4.0 * \pi$ (12.56637). 
Let's test this hypothesis:


```r
bSave = FALSE

fixed_c_plt <- ggplot(df, aes(Circ./(4.0*pi))) +
               geom_histogram(binwidth = 0.05/(4.0*pi)) +
               ggtitle("Corrected ParticleSizer Circularity From Soft Latex") +
               theme(plot.title = element_text(lineheight=2, size=12)) +
               xlab(TeX("$\\frac{circularity}{4.0\\pi}$")) +
               ylab("count")+
               #labs(x="Corrected Circularity", y="Count") +
               theme(axis.text=element_text(size=12),
                     axis.title=element_text(size=14),
                     plot.title = element_text(hjust = 0.5)) +
               NULL

if (bSave == TRUE) {
  ggsave("png/corrected-particle-sizer-circularity-from-latex.png",
         plot=fixed_c_plt, width=6, height=4, units="in", dpi=150)
}
print(fixed_c_plt)
```

![](ana-pol4455_files/figure-html/fixedCircHisto-1.png)<!-- -->

```r
bSave = FALSE
```

Our hypothesis appears to be correct.


# Plot the histogram of ECD


```r
plt <- ggplot(df, aes(Area.equivalent.circle.diameter)) +
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
# A panel plot

Try a linear distribution panel plot that uses base graphics. This assunmes
a linear (not lognormal) particle size distribution from my old `rAnaLab`
package.

Sometime I need to migrate this function to ggplot2...



```r
library(rAnaLab)

linear.distn.panel.plot(df$Area.equivalent.circle.diameter, n.brks = 25,
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
  linear.distn.panel.plot(df$Area.equivalent.circle.diameter,
                          n.brks = 25,
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
