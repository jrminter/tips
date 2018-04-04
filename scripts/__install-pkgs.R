# __install-pkgs.R Install a list of Packages for R, if needed
# 2015-04-26 Updated for R-3.2.1
# 2016-05-09 Updated for R-3.3.0
# 2016-06-23 Updated for R-3.3.1
# 2016-11-01 Updated for R-3.3.2
# 2017-03-13 Updated for R-3.3.3
# 2017-11-01 fixed JAVA_HOME issue for R-3.4.2
# 2017-11-28 added magick from github
#            https://datascienceplus.com/image-processing-and-manipulation-with-magick-in-r/
#

if( Sys.info()['sysname'] == "Windows"){
	
	Sys.setenv(JAVA_HOME="")
	print("unset JAVA_HOME for Windows")
}


str.cran.repo <- 'http://cran.revolutionanalytics.com/'
str.lib <- .Library

source("http://bioconductor.org/biocLite.R")


ensure_devtools <- function(){
  if ("devtools" %in% installed.packages()){
    print("devtools already installed")
  }else{
    print("Installing devtools")
    install.packages("devtools",repos=str.cran.repo,
                     dep=TRUE,lib=str.lib)
    
  }
}
ensure_devtools()

install_new<-function(mypkg){
  if (mypkg %in% installed.packages()){
    str.line <- paste0("Package ", mypkg, " already installed \n")
    cat(str.line)
  }else{
    str.line <- paste0("Package ", mypkg, " not found, so installing with dependencies... \n")
    cat(str.line)
    cat("Press CTRL C to abort.\n")
    cat()
    Sys.sleep(5)
    install.packages(mypkg,repos=str.cran.repo,dep=TRUE,lib=str.lib)
  }
}

install_new_bioconductor<-function(mypkg){
  if (mypkg %in% installed.packages()){
    str.line <- paste0("Package ", mypkg, " already installed \n")
    cat(str.line)
  }else{
    str.line <- paste0("Package ", mypkg, " not found, so installing with dependencies... \n")
    cat(str.line)
    cat("Press CTRL C to abort.\n")
    cat()
    Sys.sleep(5)
    biocLite(mypkg, dep=TRUE, lib=str.lib)
  }
}

install_new_github<-function(mypkg, repo){
  library(devtools)
  theCmd <- paste0(repo,'/', mypkg)
  if (mypkg %in% installed.packages()){
    str.line <- paste0("Package ", mypkg, " already installed \n")
    cat(str.line)
  }else{
    str.line <- paste0("Package ", mypkg, " not found, so installing with dependencies... \n")
    cat(str.line)
    cat("Press CTRL C to abort.\n")
    cat()
    Sys.sleep(5)

    install_github(theCmd)
  }
}

# first update anything not built with your current version of R.
update.packages(ask=FALSE, checkBuilt = TRUE)



# Problem packages for R-3.1.0
# install_new('RMySQL')
# install_new('RExcel')

# Start with the tidyverse
install_new('devtools')
install_new('tidyverse')
install_new('svglite')
install_new('ggvis')
install_new('ggmap')
install_new('ggthemes')
install_new('Quandl')
install_new('extrafont')
install_new('Rd2roxygen')
install_new('tidyquant')
install_new('here') # by Kirill Muller recommended by HW and JB!
install_new('fs')

install_new('ciTools')
install_new('reticulate') # R-python interface

# Sweave and pandoc tools
# install_new('cacheSweave') # not avail 3.2
install_new('knitcitations')
install_new('pander')
install_new('rticles')

install_new('rtiff')
install_new('raster')
install_new('imager')

# we want revealjs and ReporteRs for presentations
install_new('revealjs')
install_new('ReporteRs')

install_new('RSQLite')
install_new('RMySQL')
install_new('pryr')
install_new('nycflights13')
install_new('RODBC')
install_new('Unicode')
install_new('TeachingDemos')
install_new('plotGoogleMaps')
install_new('tikzDevice') # now back on CRAN...
install_new('mixtools')

# metrology packages
install_new('metRology')
install_new('propagate')

# for microR
install_new('kernlab')
install_new('FactoMineR')
install_new('robCompositions')
install_new('Cairo')
install_new('beanplot')
install_new('spatstat')
install_new('numbers')
# install_new('doMC') # not avail 3.3.2
install_new('rbenchmark')
install_new('doSNOW')

# install_new('RGtk2')
# see BFI for mac

install_new('PerformanceAnalytics')

install_new('fields')
# install_new('h5r') # not avail 3.3.2

install_new('SuppDists')

install_new('animation')
install_new('highlight')
install_new('qualityTools')
install_new('rcdk')
install_new('rpubchem')

install_new('rattle')
install_new('chemCal')
install_new('DAAG')
install_new('fftw')

install_new('fitdistrplus')
install_new('mixdist')
install_new('histogram')
install_new('HSAUR2')
install_new('moments')
install_new('spc')
install_new('xlsx')
install_new('readxl')
install_new('DMwR')

install_new('CORElearn')
install_new('corpcor')
install_new('ggm')
install_new('googleVis')
install_new('lasso2')
install_new('RXKCD')
install_new('ChemometricsWithR')
install_new('ChemometricsWithRData')
install_new('chemometrics')
install_new('lspls')
install_new('FITSio')
install_new('LearnBayes')
install_new('R2HTML')
install_new('SweaveListingUtils')
install_new('mosaic')
install_new('latex2exp')
install_new('highcharter')
install_new('WDI')
install_new('tigris')
install_new('xaringan')
install_new('FinCal')
install_new('hrbrthemes')
install_new('cowsay')

biocLite()

install_new_bioconductor("BiocStyle")
#install_new_bioconductor("RCurl") # avail from CRAN
install_new_bioconductor("EBImage")
install_new_bioconductor("gpls")
install_new_bioconductor("graph")

install_new_github('slidify','ramnathv')
install_new_github('slidifyLibraries','ramnathv')
install_new_github('rCharts','ramnathv')
# install_new_github('bookdown','hadley')
install_new_github('captioner','adletaw')
install_new_github('choroplethrZip','arilamstein')
install_new_github('printr','yihui')

install_new_github('rPeaks','jrminter')
install_new_github('rEDP','jrminter')
install_new_github('rEDS','jrminter')
install_new_github('rFinFuncs','jrminter')
install_new_github('rWrapStrataGem','jrminter')

devtools::install_github('jrminter/rAnaLab',build_vignettes=TRUE)

devtools::install_github('ropensci/magick')
devtools::install_github("hadley/modelr") #still experimental
devtools::install_github('WinVector/WVPlots',build_vignettes=TRUE)
devtools::install_github("rstudio/bookdown")
devtools::install_github("ThinkR-open/remedy")
devtools::install_github("crsh/citr")
devtools::install_github("benmarwick/rrtools")
devtools::install_github("brodieG/diffobj")
devtools::install_github("rorynolan/ijtiff")
devtools::install_github("hrbrmstr/speedtest")
devtools::install_github("lbusett/insert_table")
