# __install-pkgs.R Install a list of Packages for R, if needed
# 2015-04-26 Updated for R-3.2.1
# 2016-05-09 Updated for R-3.3.0
# 2016-06-23 Updated for R-3.3.1
# 2016-11-01 Updated for R-3.3.2
# 2017-03-13 Updated for R-3.3.3
# 2017-11-01 fixed JAVA_HOME issue for R-3.4.2
# 2017-11-28 added magick from github
#            https://datascienceplus.com/image-processing-and-manipulation-with-magick-in-r/
# 2018-06-13 Added rafalib and UsingR to buld matrix algebra and R-3.5.0
# 2018-06-27 add github r-libs/styler to install
# 2018-07-05 added ropenscilabs/icon, emitanaka/anicon, yihui/xaringan
#            and tpoisot/digitize from github
# 2018-08-15 Added DescTools package for numeric fomatting.
# 2019-03-03 Add rdformats
# 2019-04-13 use lwPackageHelperR to install new and github to .lib dir


if( Sys.info()['sysname'] == "Windows"){
	
	Sys.setenv(JAVA_HOME="")
	print("unset JAVA_HOME for Windows")
}

# first update anything not built with your current version of R.
update.packages(ask=FALSE, checkBuilt = TRUE)

library(lwPackageHelperR)

# Start with the tidyverse
install_new('devtools', .libPaths()[1])
install_new('tidyverse',.libPaths()[1])
install_new('svglite',.libPaths()[1])
install_new('ggvis',.libPaths()[1])
install_new('ggmap',.libPaths()[1])
install_new('ggthemes',.libPaths()[1])
install_new('Quandl',.libPaths()[1])
install_new('extrafont',.libPaths()[1])
install_new('Rd2roxygen',.libPaths()[1])
install_new('tidyquant',.libPaths()[1])
install_new('here',.libPaths()[1]) # by Kirill Muller recommended by HW and JB!
install_new('fs',.libPaths()[1])
install_new('reprex',.libPaths()[1])
install_new('UsingR',.libPaths()[1]) # data sets including galton

install_new('ciTools',.libPaths()[1])
install_new('reticulate',.libPaths()[1]) # R-python interface

# Sweave and pandoc tools
# install_new('cacheSweave',.libPaths()[1]) # not avail 3.2
install_new('knitcitations',.libPaths()[1])
install_new('pander',.libPaths()[1])
install_new('rticles',.libPaths()[1])
install_new('rdformats',.libPaths()[1])

install_new('binb',.libPaths()[1])

# matrix algebra
# install_new('rafalib',.libPaths()[1])
install_new('UsingR',.libPaths()[1]) # data including basic Galton
install_new('HistData',.libPaths()[1]) # Has Galton Families

# better number formatting
install_new('DescTools',.libPaths()[1])

install_new('rtiff',.libPaths()[1])
install_new('raster',.libPaths()[1])
install_new('imager',.libPaths()[1])

# we want revealjs and ReporteRs for presentations
install_new('revealjs',.libPaths()[1])
# install_new('ReporteRs',.libPaths()[1])

install_new('RSQLite',.libPaths()[1])
# install_new('RMySQL',.libPaths()[1])
install_new('pryr',.libPaths()[1])
install_new('nycflights13',.libPaths()[1])
install_new('RODBC',.libPaths()[1])
install_new('Unicode',.libPaths()[1])
install_new('TeachingDemos',.libPaths()[1])
install_new('plotGoogleMaps',.libPaths()[1])
install_new('tikzDevice',.libPaths()[1]) # now back on CRAN...
install_new('mixtools',.libPaths()[1])

# metrology packages
install_new('metRology',.libPaths()[1])
install_new('propagate',.libPaths()[1])

# for microR
install_new('kernlab',.libPaths()[1])
install_new('FactoMineR',.libPaths()[1])
install_new('robCompositions',.libPaths()[1])
install_new('Cairo',.libPaths()[1])
install_new('beanplot',.libPaths()[1])
install_new('spatstat',.libPaths()[1])
install_new('numbers',.libPaths()[1])
install_new('gmp',.libPaths()[1])
# install_new('doMC',.libPaths()[1]) # not avail 3.3.2
install_new('rbenchmark',.libPaths()[1])
install_new('doSNOW',.libPaths()[1])

# install_new('RGtk2',.libPaths()[1])
# see BFI for mac

install_new('PerformanceAnalytics',.libPaths()[1])

install_new('fields',.libPaths()[1])
# install_new('h5r',.libPaths()[1]) # not avail 3.3.2

install_new('SuppDists',.libPaths()[1])

install_new('animation',.libPaths()[1])
install_new('highlight',.libPaths()[1])
install_new('qualityTools',.libPaths()[1])
install_new('rcdk',.libPaths()[1])
install_new('rpubchem',.libPaths()[1])

install_new('rattle',.libPaths()[1])
install_new('chemCal',.libPaths()[1])
install_new('DAAG',.libPaths()[1])
install_new('fftw',.libPaths()[1])
install_new('rafalib',.libPaths()[1])
install_new('UsingR',.libPaths()[1])

install_new('fitdistrplus',.libPaths()[1])
install_new('mixdist',.libPaths()[1])
install_new('histogram',.libPaths()[1])
install_new('HSAUR2',.libPaths()[1])
install_new('moments',.libPaths()[1])
install_new('spc',.libPaths()[1])
install_new('sp',.libPaths()[1])
install_new('xlsx',.libPaths()[1])
install_new('readxl',.libPaths()[1])
install_new('DMwR',.libPaths()[1])

install_new('CORElearn',.libPaths()[1])
install_new('corpcor',.libPaths()[1])
install_new('ggm',.libPaths()[1])
install_new('googleVis',.libPaths()[1])
install_new('lasso2',.libPaths()[1])
install_new('RXKCD',.libPaths()[1])
install_new('ChemometricsWithR',.libPaths()[1])
# install_new('ChemometricsWithRData',.libPaths()[1])
install_new('chemometrics',.libPaths()[1])
install_new('lspls',.libPaths()[1])
install_new('FITSio',.libPaths()[1])
install_new('LearnBayes',.libPaths()[1])
install_new('R2HTML',.libPaths()[1])
# install_new('SweaveListingUtils',.libPaths()[1])
install_new('mosaic',.libPaths()[1])
install_new('latex2exp',.libPaths()[1])
install_new('highcharter',.libPaths()[1])
install_new('WDI',.libPaths()[1])
install_new('tigris',.libPaths()[1])
install_new('xaringan',.libPaths()[1])
install_new('FinCal',.libPaths()[1])
install_new('hrbrthemes',.libPaths()[1])
install_new('cowsay',.libPaths()[1])
# needed for vignettes for ggstatsplot
install_new('ordinal',.libPaths()[1])
install_new('robust',.libPaths()[1])

install_new_github('slidify','ramnathv',.libPaths()[1])
install_new_github('slidifyLibraries','ramnathv',.libPaths()[1])
install_new_github('rCharts','ramnathv',.libPaths()[1])
# install_new_github('bookdown','hadley',.libPaths()[1])
install_new_github('captioner','adletaw',.libPaths()[1])
# install_new_github('choroplethrZip','arilamstein',.libPaths()[1])
install_new_github('printr','yihui',.libPaths()[1])

install_new_github('rPeaks','jrminter',.libPaths()[1])
install_new_github('rEDP','jrminter',.libPaths()[1])
install_new_github('rEDS','jrminter',.libPaths()[1])
install_new_github('rFinFuncs','jrminter',.libPaths()[1])
install_new_github('rWrapStrataGem','jrminter',.libPaths()[1])

install_new_github('magick','ropensci',.libPaths()[1])
install_new_github('bookdown','rstudio',.libPaths()[1])
install_new_github('rrtools','benmarwick',.libPaths()[1])
install_new_github('diffobj','brodieG',.libPaths()[1])
install_new_github('speedtest','hrbrmstr',.libPaths()[1])
install_new_github('styler','r-lib',.libPaths()[1])
install_new_github('icon','ropenscilabs',.libPaths()[1])
install_new_github('anicon','emitanaka',.libPaths()[1])
install_new_github('xaringan','yihui',.libPaths()[1])
install_new_github('digitize','tpoisot',.libPaths()[1])



# needed for vignettes for ggstatsplot
install_new('ordinal')
install_new('robust')
# devtools::install_github('IndrajeetPatil/ggstatsplot',build_vignettes=TRUE)
devtools::install_github('jrminter/statshelpR',build_vignettes=TRUE)
devtools::install_github('jrminter/rAnaLab',build_vignettes=TRUE)
devtools::install_github('jrminter/statshelpR',build_vignettes=TRUE)




