# BF&I installation of packages to the system library
#
#    Date     Who                           What
# ----------  ---  ---------------------------------------------------------
# 2019-04-17  JRM Set the system library at the top
#  

# run this from the command line by:
# cd /home/jrminter/Documents/git/tips/scripts
# sudo Rscript install_pkgs_sys_lib.R

# set the system library

system_r_library <- '/usr/lib/R/library'

install.packages('devtools', system_r_library)
install.packages('tidyverse', system_r_library)
install.packages('svglite', system_r_library)
install.packages('ggvis', system_r_library)
install.packages('ggmap', system_r_library)
install.packages('ggthemes', system_r_library)
install.packages('ggimage', system_r_library)
install.packages('meme', system_r_library)
install.packages('Quandl', system_r_library)
install.packages('extrafont', system_r_library)
install.packages('Rd2roxygen', system_r_library)
install.packages('tidyquant', system_r_library)
install.packages('here', system_r_library) # by Kirill Muller recommended by HW and JB!
install.packages('fs', system_r_library)
install.packages('reprex', system_r_library)
install.packages('UsingR', system_r_library) # data sets including galton

install.packages('ciTools', system_r_library)
install.packages('reticulate', system_r_library) # R-python interface

# Sweave and pandoc tools
# install.packages('cacheSweave', system_r_library) # not avail 3.2
install.packages('knitcitations', system_r_library)
install.packages('pander', system_r_library)
install.packages('rticles', system_r_library)
install.packages('rdformats', system_r_library)

install.packages('binb', system_r_library)

# matrix algebra
# install.packages('rafalib', system_r_library)
install.packages('UsingR', system_r_library) # data including basic Galton
install.packages('HistData', system_r_library) # Has Galton Families

# better number formatting
install.packages('DescTools', system_r_library)

install.packages('rtiff', system_r_library)
install.packages('raster', system_r_library)
install.packages('imager', system_r_library)

# we want revealjs and ReporteRs for presentations
install.packages('revealjs', system_r_library)
# install.packages('ReporteRs', system_r_library)

install.packages('RSQLite', system_r_library)
# install.packages('RMySQL', system_r_library)
install.packages('pryr', system_r_library)
install.packages('nycflights13', system_r_library)
install.packages('RODBC', system_r_library)
install.packages('Unicode', system_r_library)
install.packages('TeachingDemos', system_r_library)
install.packages('plotGoogleMaps', system_r_library)
install.packages('tikzDevice', system_r_library) # now back on CRAN...
install.packages('mixtools', system_r_library)

# metrology packages
install.packages('metRology', system_r_library)
install.packages('propagate', system_r_library)

# for microR
install.packages('kernlab', system_r_library)
install.packages('FactoMineR', system_r_library)
install.packages('robCompositions', system_r_library)
install.packages('Cairo', system_r_library)
install.packages('beanplot', system_r_library)
install.packages('spatstat', system_r_library)
install.packages('numbers', system_r_library)
install.packages('gmp', system_r_library)
# install.packages('doMC', system_r_library) # not avail 3.3.2
install.packages('rbenchmark', system_r_library)
install.packages('doSNOW', system_r_library)

# install.packages('RGtk2', system_r_library)
# see BFI for mac

install.packages('PerformanceAnalytics', system_r_library)

install.packages('fields', system_r_library)
# install.packages('h5r', system_r_library) # not avail 3.3.2

install.packages('SuppDists', system_r_library)

install.packages('animation', system_r_library)
install.packages('highlight', system_r_library)
install.packages('qualityTools', system_r_library)
install.packages('rcdk', system_r_library)
install.packages('rpubchem', system_r_library)

install.packages('rattle', system_r_library)
install.packages('chemCal', system_r_library)
install.packages('DAAG', system_r_library)
install.packages('fftw', system_r_library)
install.packages('rafalib', system_r_library)
install.packages('UsingR', system_r_library)

install.packages('fitdistrplus', system_r_library)
install.packages('mixdist', system_r_library)
install.packages('histogram', system_r_library)
install.packages('HSAUR2', system_r_library)
install.packages('moments', system_r_library)
install.packages('spc', system_r_library)
install.packages('sp', system_r_library)
install.packages('xlsx', system_r_library)
install.packages('readxl', system_r_library)
install.packages('DMwR', system_r_library)

install.packages('CORElearn', system_r_library)
install.packages('corpcor', system_r_library)
install.packages('ggm', system_r_library)
install.packages('googleVis', system_r_library)
install.packages('lasso2', system_r_library)
install.packages('RXKCD', system_r_library)
install.packages('ChemometricsWithR', system_r_library)
# install.packages('ChemometricsWithRData', system_r_library)
install.packages('chemometrics', system_r_library)
install.packages('lspls', system_r_library)
install.packages('FITSio', system_r_library)
install.packages('LearnBayes', system_r_library)
install.packages('R2HTML', system_r_library)
# install.packages('SweaveListingUtils', system_r_library)
install.packages('mosaic', system_r_library)
install.packages('latex2exp', system_r_library)
install.packages('highcharter', system_r_library)
install.packages('WDI', system_r_library)
install.packages('tigris', system_r_library)
install.packages('xaringan', system_r_library)
install.packages('FinCal', system_r_library)
install.packages('hrbrthemes', system_r_library)
install.packages('cowsay', system_r_library)
# needed for vignettes for ggstatsplot
install.packages('ordinal', system_r_library)
install.packages('robust', system_r_library)
