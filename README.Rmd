---
title: "John Minter's Helpful Tips"
author: "J. R. Minter"
date: "Started: 2013-07-16, Last modified: 2020-01-22"
output:
  html_document:
    keep_md: true
    css: ./theme/jm-gray-vignette.css
    number_sections: yes
    toc: yes
    toc_depth: 3
---

This repository contains the John Minter's useful tips in Rmarkdown
format.


**First**, some quickies:

1. The **Feynman** technique of learning:

    - **Step 1**: Pick and study a topic

    - **Step 2**: Explain the topic to someone, like a child, who is unfamiliar with the topic

    - **Step 3**: Identify any gaps in your understanding 

    - **Step 4**: Review and Simplify!

2. **install command line tools** on MacOS

    `xcode-select --install`

3. **regex for youtube time stamps**. Useful in SublimeText3!

   `\d\d:\d\d`

4. **Symbolic links**. I always get this backwards...

    ```
       file     link
ln -s source destination
    ```

5. **Fun snippets**

    > Your closest colaborator is you, six months from now    
    > ... and you don't respond to email     
    > - Karl Broman

    > DRY (do not repeat yourself) vs WET (waste everyones time) coding styles    
    > - Peter Baker (UseR 2018)

6. **Getting started with data science**

- A very helpful article from
[Datacamp](https://www.datacamp.com/community/tutorials/setup-data-science-environment).

7. **Clear the Chrome Cache**

    - Press "CTRL" + "Shift" + "Delete" keys in Windows or Linux
    - Press "Command" + "Shift" + "Delete"" keys on MacOS.

8. **Delete Specific Cookies in Chrome for Mac OS X**

    From [osxdaily.com](http://osxdaily.com/2016/07/02/delete-cookies-chrome-browser/): You can remove a specific website cookie from Chrome by doing the following:

    This skips several steps from original article!

    - Open `chrome://settings/siteData` as a URL

    - Scroll to look at the list or use the `Search` box if you want to quickly find a specific site URL.

    - To remove the cookie(s), then select the site and click the **trash can icon** to delete cookies for the site.

    - Rinse and repeat for other sites...

    - Avoid cookie placement and cache generation in the first place by using the Chrome `Incognito Mode` private browsing feature.

9. **Automatically download all files in a directory**

   Let's also exclude all the `index.html` files... 

```
    wget -r --no-parent --reject "index.html*" http://my/url
```

10. **How to block someone on Facebook**

    - Click at the top right of Facebook and choose `Settings`.
    - Click `Blocking` in the left side menu.
    - In the `Block` users setting, enter the name of the person you want to block and click `Block`.
    - Select the specific person you want to block ans click `Block > Block [name]`



**Topics**

[AccessToSqlite](./AccessToSqlite/AccessToSqlite.html)

[EkAutomater](./automater/automater.html)

[Oxford AZtec](./AZtec/AZtec.html)

[bibtex](./bibtex/bibtex.html)

[C++11](./C++11/C++11-Tips.html)

[Carbon Film Thickness](./carbonFilmThickness/carbonFilmThickness.html)

[chntpw](./chntpw/chntpw.html)

[Color](./color/color.html)

[Conductive Epoxies](./ConductiveEpoxy/ConductiveEpoxy.html)

[DataScience-linux64](./DataScience-linux64/DataScience-linux64.html)

[Debian](./Debian/Debian.html)

[Denton Coaters](./Denton/Denton.html)

[Diffraction Limit](./DiffractionLimit/DiffractionLimit.html)

[DTSA-II](./dtsa2/dtsa2.html)

[Earth Science](./earth-sci/earth-sci.html)

[EDAX](./EDAX/EDAX.html)

[EPMA Matrix Correction](./epma-matrix-corr/epma-matrix-corr.html)

[Excel](./Excel/Excel.html)

[Feynman Technique](./Feynman_technique/Feynman_technique.html)

[Fiji plugin development](./fiji-plugin-development/fiji-plugin-development.html)

[Fitness](./fitness/fitness.html)

[French Press Instructions](./french-press-instructions/french-press-instructions.html)

[generator](./generator/generator.html)

[gfortran](./gfortran/gfortran.html)

[Building up a ggplot2 figure](./ggplot2figure/ggplot2-figure.html)

[ggplot2Intro](./ggplot2Intro/ggplot2Intro.html)

[ggplot2UseCases](./ggplot2UseCases/ggplot2UseCases.html)

[ggvisIntro](./ggvisIntro/ggvisIntro.html)

[git](./git/git-tips.html)

[gnuplot](./gnuplot/gnuplot.html)

[Haklev's tips on data wrangling with R](./hacklev/hacklev.html)

[homebrew](./homebrew/homebrew.html)

[hyperspy](./hyperspy/hyperspy.html)

[Image-J](./ImageJ/ImageJ.html)

[Inkscape](./inkscape/inkscape.html)

[iOS](./iOS/iOS.html)

[Jekyll on github.io](./jekyll-github/jekyll-github.html)

[json](./json/json.html)

[legacy equipment](./legacy/Legacy.html)

[Logos Library System](./Logos/Logos.html)

[Lubuntu](./Lubuntu/Lubuntu.html)

[mac](./mac/mac.html)

[mac-for-data-science](./mac-for-data-science/mac-for-data-science.html)

[microscopy](./micro/micro.html)

[microscopy sample prep](./micro-sample-prep/micro-sample-prep.html)

[midb](./midb/midb.html)

[Monte Carlo methods in R](./monteCarlo/monteCarlo.html)

[MS Office](./msOffice/msOffice.html)

[MySQL](./mysql/mysql.html)

[Octave](./Octave/Octave.html)

[OnePassword](./OnePassword/OnePassword.html)

[Oracle Virtual Box](./Oracle-Virtual-Box/Oracle-Virtual-Box.html)

[OS Package Links](./osPkgs/osPkgs.html)

[pandoc](./pandoc/pandoc.html)

[penepma](./penepma/penepma.html)

[plagiarism](./plagiarism/plagiarism.html)

[pool](./pool/pool.html)

[portable makefiles](./portableMakefiles/portableMakefiles.html)

[Preparation of samples for EDS](./prepForEDS/prepForEDS.html)

[Probe for EPMA](./probeForEPMA/probeForEPMA.html)

[python](./python/python.html)

[python image processing with skimage](./skimage/skimage.html)

[R](./R/R-tips.html)

[R-Anova](./R-Anova/R-Anova.html)

[R-bar-plots](./R-bar-plots/R-bar-plots.html)

[R-boxplots](./R-boxplots/R-boxplots.html)

[R-character-encoding](./R-character-encoding/R-character-encoding.html)

[R-data-cleaning](./R-data-cleaning/R-data-cleaning.html)

[R-data-pipeline](./R-data-pipeline/R-data-pipeline.html)

[R-Excel](./R-Excel/R-Excel.html)

[R-foreach](./R-foreach/R-foreach.html)

[R-GeoSpatial](./R-GeoSpatial/R-GeoSpatial.html)

[R-knitrBootstrap](./R-knitrBootstrap/R-knitrBootstrap.html)

[R-lm](./R-lm/R-lm.html)

[R-loess](./R-loess/R-loess.html)

[R-markdown](./R-markdown/R-markdown.html)

[R-matrix-algebra](./R-matrix-algebra/R-matrix-algebra.html)

[R-memes](./R-memes/R-memes.html)

[R-model-predict](./R-model-predict/R-model-predict.html)

[R-Packages](./R-packages/R-packages.html)

[R-scrape-pdf](./R-scrape-pdf/R-scrape-pdf.html)

[Reproducible Research](./ReproducibleResearch/ReproducibleResearch.html)

[Research](./research/research.html)

[SEM](./SEM/SEM.html)

[shell](./shell/shell-tips.html)

[Sirion](./Sirion/Sirion.html)

[skills](./skills/skills.html)

[skimage](./skimage/skimage.html)

[Slidify](./Slidify/Slidify.html)

[Software Development](./software-dev/software-dev.html)

[SQL](./SQL/SQL.html)

[Sublime Text 3](./ST3/ST3.html)

[Stratagem](./Stratagem/Stratagem.html)

[Sweave](./Sweave/Sweave.html)

[TEM](./TEM/TEM.html)

[TeX](./tex/tex-tips.html)

[Tidy Data](./tidyData/tidyData.html)

[TV](./TV/Tv.html)

[Ubuntu](./ubuntu/ubuntu.html)

[vacuum systems](./vacuum/vacuum.html)

[Visual Studio 2010](./VS2010/VS2010.html)

[Win](./win/win.html)

[Workflow](./workflow/workflow.html)

[WxMaxima](./WxMaxima/WxMaxima.html)

