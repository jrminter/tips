# knit-them-all.R

rm(list=ls())
require(knitr)

strGitHome <- Sys.getenv("GIT_HOME")
if(strGitHome=="") strGitHome="~/git"
strRel     <- '/tips/scripts'

names <- c("automater.Rmd", "C++11-Tips.Rmd",
           "chntpw.Rmd", "color.Rmd",
           "DiffractionLimit.Rmd",
           "EDAX.Rmd", "git-tips.Rmd","gnuplot.Rmd",
           "ImageJ.Rmd", "Legacy.Rmd", "mac.Rmd", 
           "micro.Rmd", "mysql.Rmd", "osPkgs.Rmd",
           "plagiarism.Rmd",
           "python.Rmd","R-tips.Rmd", 
           "R-Anova.Rmd", "R-bar-plots.Rmd", "R-boxplots.Rmd",
           "R-foreach.Rmd", "R-GeoSpatial.Rmd","research.Rmd",
           "Salabim-graphics.Rmd", "shell-tips.Rmd",
           "skimage.Rmd","Slidify.Rmd",
           "Sweave.Rmd", "tex-tips.Rmd","ubuntu.Rmd",
           "VS2010.Rmd","win.Rmd","README.Rmd")
rPath <- c("../automater", "../C++11",
           "../chntpw", "../color",
           "../DiffractionLimit", 
           "../EDAX", "../git", "../gnuplot", "../ImageJ",
           "../legacy", "../mac","../micro",
           "../mysql", "../osPkgs",
           "../plagiarism", "../python", "../R",
           "../R-Anova", "../R-bar-plots", "../R-boxplots" ,
           "../R-foreach", "../R-GeoSpatial", "../research",
           "../Salabim", "../shell", 
           "../skimage", "../Slidify",
           "../Sweave", "../tex", "../ubuntu",
           "../VS2010","../win", "../")

knitIt <- function(wrkPath, scrPath, theName){
  print(wrkPath)
  setwd(wrkPath)
  knit2html(theName)
  theMD <- paste0(strsplit(theName, ".Rmd")[[1]], ".md")
  file.remove(theMD)
  setwd(scrPath)
}

strScripts <- paste0(strGitHome, strRel)
print(strScripts)



# print(strGitHome)



setwd(strScripts)

for(i in 1:length(names))
{
  knitIt(rPath[i], strScripts, names[i])
}

