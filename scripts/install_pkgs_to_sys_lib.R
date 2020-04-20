# BF&I installation of packages to the system library
#
#    Date     Who                           What
# ----------  ---  ---------------------------------------------------------
# 2019-04-17  JRM Set the system library at the top
# 2020-04-20  JRM Updated for R-4.0.0
#  

# run this from the command line by:
# cd /home/jrminter/Documents/git/tips/scripts
# sudo Rscript install_pkgs_sys_lib.R

# set the system library

#   For debian
# system_r_library <- '/usr/lib/R/library'

# For ubuntu bionic
# system_r_library <- '/usr/local/lib/R/site-library'

# for lubuntu-bionic
# system_r_library <-'/home/jrminter/R/x86_64-pc-linux-gnu-library/3.5'

# For mac
# system_r_library <-'/Library/Frameworks/R.framework/Versions/3.6/Resources/library'

# For win
system_r_library <-'/Apps/R/R-4.0/R-4.0.0rc/library'


install.packages('devtools', system_r_library, dependencies=TRUE)
install.packages('pdftools', system_r_library, dependencies=TRUE)
install.packages('tabulizer', system_r_library, dependencies=TRUE)
install.packages('janitor', system_r_library, dependencies=TRUE)
# install.packages('plotGoogleMaps', system_r_library, dependencies=TRUE)
install.packages('RCurl', system_r_library, dependencies=TRUE)
install.packages('callr', system_r_library, dependencies=TRUE)
install.packages('prettyunits', system_r_library, dependencies=TRUE)
install.packages('desc', system_r_library, dependencies=TRUE)
install.packages('pkgbuild', system_r_library, dependencies=TRUE)
install.packages('tidyverse', system_r_library, dependencies=TRUE)
install.packages('svglite', system_r_library, dependencies=TRUE)
install.packages('ggvis', system_r_library, dependencies=TRUE)
install.packages('ggmap', system_r_library, dependencies=TRUE)
install.packages('ggthemes', system_r_library, dependencies=TRUE)
install.packages('ggimage', system_r_library, dependencies=TRUE)
install.packages('meme', system_r_library, dependencies=TRUE)
install.packages('Quandl', system_r_library, dependencies=TRUE)
install.packages('extrafont', system_r_library, dependencies=TRUE)
install.packages('Rd2roxygen', system_r_library, dependencies=TRUE)
install.packages('tidyquant', system_r_library, dependencies=TRUE)
install.packages('here', system_r_library, dependencies=TRUE) # by Kirill Muller recommended by HW and JB!
install.packages('fs', system_r_library, dependencies=TRUE)
install.packages('reprex', system_r_library, dependencies=TRUE)
install.packages('UsingR', system_r_library, dependencies=TRUE) # data sets including galton

install.packages('ciTools', system_r_library, dependencies=TRUE)
install.packages('reticulate', system_r_library, dependencies=TRUE) # R-python interface

# Sweave and pandoc tools
# install.packages('cacheSweave', system_r_library, dependencies=TRUE) # not avail 3.2
install.packages('knitcitations', system_r_library, dependencies=TRUE)
install.packages('pander', system_r_library, dependencies=TRUE)
install.packages('rticles', system_r_library, dependencies=TRUE)
install.packages('rdformats', system_r_library, dependencies=TRUE) # not avail 4.0

install.packages('binb', system_r_library, dependencies=TRUE)

# matrix algebra
# install.packages('rafalib', system_r_library, dependencies=TRUE)
install.packages('UsingR', system_r_library, dependencies=TRUE) # data including basic Galton
install.packages('HistData', system_r_library, dependencies=TRUE) # Has Galton Families

# better number formatting
install.packages('DescTools', system_r_library, dependencies=TRUE)

install.packages('rtiff', system_r_library, dependencies=TRUE)
install.packages('raster', system_r_library, dependencies=TRUE)
install.packages('imager', system_r_library, dependencies=TRUE)

# we want revealjs and ReporteRs for presentations
install.packages('revealjs', system_r_library, dependencies=TRUE)
# install.packages('ReporteRs', system_r_library, dependencies=TRUE)

install.packages('RSQLite', system_r_library, dependencies=TRUE)
# install.packages('RMySQL', system_r_library, dependencies=TRUE)
install.packages('pryr', system_r_library, dependencies=TRUE)
install.packages('nycflights13', system_r_library, dependencies=TRUE)
install.packages('RODBC', system_r_library, dependencies=TRUE)
install.packages('Unicode', system_r_library, dependencies=TRUE)
install.packages('TeachingDemos', system_r_library, dependencies=TRUE)
install.packages('tikzDevice', system_r_library, dependencies=TRUE) # now back on CRAN...
install.packages('mixtools', system_r_library, dependencies=TRUE)

# metrology packages
install.packages('metRology', system_r_library, dependencies=TRUE)
install.packages('propagate', system_r_library, dependencies=TRUE)

# for microR
install.packages('kernlab', system_r_library, dependencies=TRUE)
install.packages('FactoMineR', system_r_library, dependencies=TRUE)
install.packages('robCompositions', system_r_library, dependencies=TRUE)
install.packages('Cairo', system_r_library, dependencies=TRUE)
install.packages('beanplot', system_r_library, dependencies=TRUE)
install.packages('spatstat', system_r_library, dependencies=TRUE)
install.packages('numbers', system_r_library, dependencies=TRUE)
install.packages('gmp', system_r_library, dependencies=TRUE)
# install.packages('doMC', system_r_library, dependencies=TRUE) # not avail 3.3.2
install.packages('rbenchmark', system_r_library, dependencies=TRUE)
install.packages('doSNOW', system_r_library, dependencies=TRUE)

# install.packages('RGtk2', system_r_library, dependencies=TRUE)
# see BFI for mac

install.packages('PerformanceAnalytics', system_r_library, dependencies=TRUE)

install.packages('fields', system_r_library, dependencies=TRUE)
# install.packages('h5r', system_r_library, dependencies=TRUE) # not avail 3.3.2

install.packages('SuppDists', system_r_library, dependencies=TRUE)

install.packages('animation', system_r_library, dependencies=TRUE)
install.packages('highlight', system_r_library, dependencies=TRUE)
install.packages('qualityTools', system_r_library, dependencies=TRUE)
install.packages('rcdk', system_r_library, dependencies=TRUE)
install.packages('rpubchem', system_r_library, dependencies=TRUE)

install.packages('rattle', system_r_library, dependencies=TRUE)
install.packages('chemCal', system_r_library, dependencies=TRUE)
install.packages('DAAG', system_r_library, dependencies=TRUE)
install.packages('fftw', system_r_library, dependencies=TRUE)
install.packages('rafalib', system_r_library, dependencies=TRUE)
install.packages('UsingR', system_r_library, dependencies=TRUE)

install.packages('fitdistrplus', system_r_library, dependencies=TRUE)
install.packages('mixdist', system_r_library, dependencies=TRUE)
install.packages('histogram', system_r_library, dependencies=TRUE)
install.packages('HSAUR2', system_r_library, dependencies=TRUE)
install.packages('moments', system_r_library, dependencies=TRUE)
install.packages('spc', system_r_library, dependencies=TRUE)
install.packages('sp', system_r_library, dependencies=TRUE)
install.packages('xlsx', system_r_library, dependencies=TRUE)
install.packages('readxl', system_r_library, dependencies=TRUE)
install.packages('DMwR', system_r_library, dependencies=TRUE)

install.packages('CORElearn', system_r_library, dependencies=TRUE)
install.packages('corpcor', system_r_library, dependencies=TRUE)
install.packages('ggm', system_r_library, dependencies=TRUE)
install.packages('googleVis', system_r_library, dependencies=TRUE)
install.packages('lasso2', system_r_library, dependencies=TRUE)
install.packages('RXKCD', system_r_library, dependencies=TRUE)
install.packages('ChemometricsWithR', system_r_library, dependencies=TRUE)
# install.packages('ChemometricsWithRData', system_r_library, dependencies=TRUE)
install.packages('chemometrics', system_r_library, dependencies=TRUE)
install.packages('lspls', system_r_library, dependencies=TRUE)
install.packages('FITSio', system_r_library, dependencies=TRUE)
install.packages('LearnBayes', system_r_library, dependencies=TRUE)
install.packages('R2HTML', system_r_library, dependencies=TRUE)
# install.packages('SweaveListingUtils', system_r_library, dependencies=TRUE)
install.packages('mosaic', system_r_library, dependencies=TRUE)
install.packages('latex2exp', system_r_library, dependencies=TRUE)
install.packages('highcharter', system_r_library, dependencies=TRUE)
install.packages('WDI', system_r_library, dependencies=TRUE)
install.packages('tigris', system_r_library, dependencies=TRUE)
install.packages('xaringan', system_r_library, dependencies=TRUE)
install.packages('FinCal', system_r_library, dependencies=TRUE)
install.packages('hrbrthemes', system_r_library, dependencies=TRUE)
install.packages('cowsay', system_r_library, dependencies=TRUE)
# needed for vignettes for ggstatsplot
install.packages('ordinal', system_r_library, dependencies=TRUE)
install.packages('robust', system_r_library, dependencies=TRUE)
