# __install-pkgs-github.R

if( Sys.info()['sysname'] == "Windows"){
  
  Sys.setenv(JAVA_HOME="")
  print("unset JAVA_HOME for Windows")
}

library(lwPackageHelperR)

# .libPaths()

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

