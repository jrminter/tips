---
title: "Analyze Diameter Data from  a Generated Lognormal Distribution"
author: "J. R. Minter"
date: "Started: 2019-06-18, Last modified: 2019-06-18"
output:
  html_document:
    keep_md: yes
    css: ../theme/jm-gray-vignette.css
    number_sections: yes
    toc: yes
    toc_depth: 3
---

[Back to ImageJ](ImageJ.html)

I want to use Fiji/ImageJ to generate images of circular particles that have
are from a lognormal distribution. The first step is to generate equivalent
circular diameter features from the
`org.apache.commons.math3.distribution.LogNormalDistribution`
class using the script `test_lognormal_distribution.py`.

# Read in the data


```
## [1] "C:/Users/jrminter/Documents/git/tips/ImageJ/csv/test_gen_lognormal_particles.csv"
```

```
##       num             ECD_nm     
##  Min.   :   1.0   Min.   :27.15  
##  1st Qu.: 625.8   1st Qu.:44.36  
##  Median :1250.5   Median :49.80  
##  Mean   :1250.5   Mean   :50.83  
##  3rd Qu.:1875.2   3rd Qu.:56.24  
##  Max.   :2500.0   Max.   :87.50
```


```r
bSave = FALSE
library(ggplot2)
pHD <- ggplot(df_particles, aes(ECD_nm)) +
       geom_histogram(binwidth = .02) +
       scale_x_log10(limits = c(10.,100.0),
                     breaks = c(10, 20, 30, 50, 100)) +
       ggtitle("Grain Equivalent Circular Diameter") +
       theme(plot.title = element_text(lineheight=2, size=12)) +
       labs(x="diameter (nm) log scale", y="Count",
            caption = 'jrminter@gmail.com / @jrminter') +
       theme(axis.text=element_text(size=12),
              axis.title=element_text(size=12),
              # center the title
              plot.title=element_text(hjust = 0.5)) +
       NULL

if (bSave == TRUE) {
  ggsave("./dat/png/grain-ecd-histo.png", plot=pHistoAgxDiam,
         width=6, height=4, units="in", dpi=150)
}
print(pHD)
```

```
## Warning: Removed 2 rows containing missing values (geom_bar).
```

![](ana_generated_spheres_files/figure-html/make_plot-1.png)<!-- -->

[Back to ImageJ](ImageJ.html)
