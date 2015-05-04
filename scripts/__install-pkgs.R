# __install-pkgs.R Install a list of Packages for R, if needed
# 2015-04-26 Updated for R-3.2.0

str.cran.repo <- 'http://cran.revolutionanalytics.com/'
str.lib <- .Library

source("http://bioconductor.org/biocLite.R")
biocLite()

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


install_new('RODBC')
install_new('Unicode')
install_new('TeachingDemos')
install_new('plotGoogleMaps')
install_new('tikzDevice') # now back on CRAN...

# Sweave and pandoc tools
# install_new('cacheSweave') # not avail 3.2
install_new('knitr')
install_new('knitcitations')
install_new('pander')

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
install_new('rtiff')

# for foreach
install_new('foreach')
install_new('numbers')
# install_new('doMC') # not avail 3.2
install_new('rbenchmark')
install_new('doSNOW')


install_new('RGtk2')
install_new('testthat')
install_new('dplyr')
install_new('tidyr')
install_new('PerformanceAnalytics')
install_new('quantmod')
install_new('TTR')
install_new('RJSONIO')
install_new('rgdal')
install_new('filehash')
install_new('sp')
install_new('raster')
install_new('fields')
# install_new('h5r') # not avail 3.2
install_new('devtools')
install_new('rJava')
install_new('xtable')
install_new('SuppDists')
install_new('ellipse')
install_new('rjson')
install_new('animation')
install_new('rgl')
install_new('ggplot2')
install_new('evaluate')
install_new('formatR')
install_new('highlight')
install_new('qualityTools')
install_new('rcdk')
install_new('rpubchem')
install_new('gtools')
install_new('randomForest')
install_new('itertools')
install_new('rattle')
install_new('chemCal')
install_new('DAAG')
install_new('fftw')
install_new('fitdistrplus')
install_new('histogram')
install_new('HSAUR2')
install_new('moments')
install_new('spc')
install_new('xlsx')
install_new('png')
install_new('plyr')
install_new('DMwR')
install_new('fBasics')
install_new('vcd')
install_new('gplots')
install_new('vcd')
install_new('rpart')
install_new('ROCR')
install_new('party')
install_new('ada')
install_new('colorspace')
install_new('randomForest')
install_new('caret')
install_new('e1071')
install_new('doParallel')
install_new('CORElearn')
install_new('corpcor')
install_new('ggm')
install_new('googleVis')
install_new('lasso2')
install_new('RXKCD')
install_new('ChemometricsWithR')
install_new('ChemometricsWithRData')
install_new('chemometrics')
install_new('pls')
install_new('lspls')
install_new('fastICA')
install_new('FITSio')
install_new('LearnBayes')
install_new('tables')
install_new('R2HTML')
install_new('SweaveListingUtils')
install_new('memisc')
install_new('mosaic')
install_new('fastR')
install_new('roxygen2')
install_new('Rd2roxygen')
install_new('markdown')
install_new('lmtest')
install_new('gridExtra')
install_new('stringr')
install_new('quantreg')
install_new('zoo')
install_new('lme4')
install_new('plotGoogleMaps')


install_new_bioconductor("BiocStyle")
#install_new_bioconductor("RCurl") # avail from CRAN
install_new_bioconductor("EBImage")
install_new_bioconductor("gpls")
install_new_bioconductor("graph")
install_new_bioconductor("RBGL")

install_new_github('slidify','ramnathv')
install_new_github('slidifyLibraries','ramnathv')
install_new_github('bookdown','hadley')
install_new_github('captioner','adletaw')
install_new_github('choroplethrZip@v1.3.0','arilamstein')



