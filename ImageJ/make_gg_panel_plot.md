---
title: "Make gg_panel_plot"
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



```r
options(width = 72)
bSave = FALSE # don't save plots until I', satisfied...
```

I'll need
[this](https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html)
later...


```r
library(knitr)
library(dplyr)
library(ggplot2)
library(gridExtra)
```

# Read in the data with R


```r
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

Make a tibble that includes the traditional definition of circularity. We
discovered that the `Circ.` column need to be divided by $4 \pi$.


```r
area = df$Area
peri = df$Peri.
trad_circ = 4.0*pi*area/peri^2
# summary(trad_circ)

particles <- as_tibble(data.frame(lab=df$Label,
                                  ecd=df$Area.equivalent.circle.diameter,
                                  ar=df$Aspect.Ratio,
                                  circ=df$Circ./(4.0*pi),
                                  elong=df$Elong.,
                                  conv=df$Convexity))
summary(particles)
```

```
      lab              ecd              ar             circ       
 Min.   :   1.0   Min.   :19.35   Min.   :1.000   Min.   :0.9047  
 1st Qu.: 271.5   1st Qu.:39.31   1st Qu.:1.000   1st Qu.:0.9408  
 Median : 542.0   Median :41.01   Median :1.038   Median :0.9490  
 Mean   : 542.0   Mean   :40.74   Mean   :1.046   Mean   :0.9511  
 3rd Qu.: 812.5   3rd Qu.:42.54   3rd Qu.:1.050   3rd Qu.:0.9567  
 Max.   :1083.0   Max.   :48.73   Max.   :1.688   Max.   :1.1970  
     elong             conv      
 Min.   :0.0510   Min.   :0.995  
 1st Qu.:0.1770   1st Qu.:1.000  
 Median :0.2200   Median :1.000  
 Mean   :0.2266   Mean   :1.000  
 3rd Qu.:0.2650   3rd Qu.:1.000  
 Max.   :0.6800   Max.   :1.000  
```
# The measure of circularity

I was **really** confused by the `Circ.` value reported by ParticleSizer.
I noticed that all the values are close to 12. I am used to the definition of
circularity as defined by [Wikipedia](https://en.wikipedia.org/wiki/Shape_factor_(image_analysis_and_microscopy)#Circularity)
as

$\frac{4  \pi A}{P^2}$. It turns out that ParticleSizer did **not** divide by
$4 \pi$ so we will correct the result during data processing.

that ranges from 0 to 1.0. So that is what we will use.

# Plot the histogram of ECD


```r
#' Plot the ECD
#'
#' Make a ggplot2 plot of the ECD
#'
#' @param tib tibble - Containing the ecd
#' @param bin_width number - The width of the bin for the diameter histogram
#' @param title String - A title for the plot
#' @param xlab String - the label for the x axis, e.g. "diameter [nm]"
#' @param ylab String - the y label. Default = "Counts"
#' @param base_txt_pts String - the size in points. Default 12.
#'
#' @return plt
#'
#' @examples
#' library(rAnaLab)
#' x <- sprintf("H4100 800X: X= %.3f, %.3f",  calc.adda.mm.per.px(150.92),
#'      calc.adda.mm.per.px(148.77))
#' print(x)
#'
#'
#'
#' @export
#'
#'

plot_ecd <- function(tib, bin_width, title, xlab, ylab = "Counts",
                     base_txt_pts=12){
         med <- median(tib$ecd)
  plt <- ggplot(tib, aes(ecd)) +
         geom_histogram(binwidth=bin_width) +
         ggtitle(title) +
         theme(plot.title = element_text(lineheight=2, size=base_txt_pts+2)) +
         labs(x=xlab, y=ylab) +
         ggtitle(title) +
         theme(axis.text=element_text(size=base_txt_pts),
               axis.title=element_text(size=base_txt_pts+2),
              plot.title = element_text(hjust = 0.5)) +
         geom_vline(xintercept=med,linetype=1, size=1.5, colour="blue") +
         NULL
        return(plt)
}

anot <- sprintf("Median is \n %.1f nm", median(particles$ecd)) 

ecd_plt <- plot_ecd(particles, 1.0, "Diameter distribution",
                "diameter [nm]", "Counts") +
       annotate("text", label = anot, x = 30, y = 150, size = 4,
                colour = "blue")

print(ecd_plt)
```

![](make_gg_panel_plot_files/figure-html/plotECD-1.png)<!-- -->


```r
#' Plot the corrected circularity distribution
#'
#' Make a ggplot2 plot of the traditional circularity distribution
#'
#' @param tib tibble - Containing the circularity
#' @param bin_width number - The width of the bin for the circularity histogram
#' @param title String - A title for the plot
#' @param xlab String - the label for the x axis, e.g. "diameter [nm]"
#' @param ylab String - the y label. Default = "Counts"
#' @param base_txt_pts String - the size in points. Default 12.
#'
#' @return plt
#'
#' @examples
#' library(rAnaLab)
#' x <- sprintf("H4100 800X: X= %.3f, %.3f",  calc.adda.mm.per.px(150.92),
#'      calc.adda.mm.per.px(148.77))
#' print(x)
#'
#'
#'
#' @export
#'
#'

plot_circ <- function(tib, bin_width, title, xlab, ylab = "Counts",
                     base_txt_pts=12){
  plt <- ggplot(tib, aes(circ)) +
         geom_histogram(binwidth=bin_width) +
         ggtitle(title) +
         theme(plot.title = element_text(lineheight=2, size=base_txt_pts+2)) +
         labs(x=xlab, y=ylab) +
         ggtitle(title) +
         theme(axis.text=element_text(size=base_txt_pts),
               axis.title=element_text(size=base_txt_pts+2),
               plot.title = element_text(hjust = 0.5)) +
         NULL
        return(plt)
}


pltc <- plot_circ(particles, 0.01, "Circularity distribution", "Circularity", "Counts")

print(pltc)
```

![](make_gg_panel_plot_files/figure-html/plot_circ-1.png)<!-- -->



```r
plot_diam_boxplot <- function(tib, c_fixed=0.1, title="Box Plot", ylab = "ECD [nm]",
                     base_txt_pts=12){

the_plt <- ggplot(particles, aes(x="", y=ecd)) + 
           geom_boxplot() +
           coord_fixed(c_fixed) +
           labs(y=ylab, x="") +
           ggtitle(title) +
           theme(axis.text=element_text(size=base_txt_pts),
                 axis.title=element_text(size=base_txt_pts+2),
                 plot.title = element_text(hjust = 0.5)) +
           NULL

return(the_plt)
}

box_plt <- plot_diam_boxplot(particles)
print(box_plt)
```

![](make_gg_panel_plot_files/figure-html/plot_diam_boxplot-1.png)<!-- -->



```r
plot_ecd_qq_plot <- function(tib, c_fixed=0.5, title="QQ Plot", ylab = "ECD [nm]",
                     base_txt_pts=12){
base_txt_pts=12
plt <- ggplot(tib, aes(sample = ecd)) +
              stat_qq() +
              stat_qq_line() +
              labs(y=ylab, x="") +
              ggtitle(title) +
              coord_fixed(c_fixed) +
              theme(axis.text=element_text(size=base_txt_pts),
                 axis.title=element_text(size=base_txt_pts+2),
                 plot.title = element_text(hjust = 0.5)) +
              NULL
         
return(plt)
}

ecd_qq_plot <- plot_ecd_qq_plot(particles, c_fixed=0.5, title="QQ Plot",
                                ylab = "ECD [nm]", base_txt_pts=12)
print(ecd_qq_plot)
```

![](make_gg_panel_plot_files/figure-html/ecd_qq_plot-1.png)<!-- -->





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

![](make_gg_panel_plot_files/figure-html/linearDistPanelPlot-1.png)<!-- -->

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

Make the panel plot


```r
out <- grid.arrange(ecd_plt, box_plt, ecd_qq_plot, nrow=1 )
```

![](make_gg_panel_plot_files/figure-html/panel_plot-1.png)<!-- -->

```r
ggsave(file="png/pol4455_gg_panel_plot.png", out) 
```

```
## Saving 7 x 5 in image
```

[Back to ImageJ](ImageJ.html)
