# __install-pkgs.R Install a list of Packages for LCS
# 2018-05-29 Updated for R-3.3.5.0


if( Sys.info()['sysname'] == "Windows"){
	
	Sys.setenv(JAVA_HOME="")
	print("unset JAVA_HOME for Windows")
}


str.cran.repo <- 'http://cran.revolutionanalytics.com/'
str.lib <- .Library



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
install_new('here') # by Kirill Muller recommended by HW and JB!
install_new('fs')


# Sweave and pandoc tools
# install_new('cacheSweave') # not avail 3.2
install_new('knitcitations')
install_new('pander')

install_new('nycflights13')

devtools::install_github('jrminter/statshelpR',build_vignettes=TRUE)


