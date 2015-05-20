# knit-them-all.R

rm(list=ls())
require(knitr)

strGitHome <- Sys.getenv("GIT_HOME")
if(strGitHome=="") strGitHome="~/git"
strRel     <- '/tips/scripts'

names <- c("AccessToSqlite.Rmd", "automater.Rmd", "AZtec.Rmd",
           "C++11-Tips.Rmd",
           "chntpw.Rmd", "color.Rmd", "ConductiveEpoxy.Rmd",
           "DiffractionLimit.Rmd", "dtsa2.Rmd",
           "EDAX.Rmd", "fitness.Rmd","ggplot2Intro.Rmd",
           "ggvisIntro.Rmd", "git-tips.Rmd", 
           "gnuplot.Rmd","hacklev.Rmd",
           "ImageJ.Rmd", "iOS.Rmd", "Legacy.Rmd",
           "Lubuntu.Rmd", "mac.Rmd", 
           "micro.Rmd", "msOffice.Rmd", "mysql.Rmd", "osPkgs.Rmd",
           "plagiarism.Rmd",
           "python.Rmd","R-tips.Rmd", 
           "R-Anova.Rmd", "R-bar-plots.Rmd", "R-boxplots.Rmd",
           "R-Excel.Rmd","R-foreach.Rmd", "R-GeoSpatial.Rmd",
           "R-packages.Rmd", "research.Rmd",
           "Salabim-graphics.Rmd", "shell-tips.Rmd",
           "skimage.Rmd","Slidify.Rmd", "ST3.Rmd",
           "Sweave.Rmd", "tex-tips.Rmd","ubuntu.Rmd",
           "VS2010.Rmd","win.Rmd","workflow.Rmd", "README.Rmd")

rPath <- c("../AccessToSqlite", "../automater", 
           "../AZtec", "../C++11",
           "../chntpw", "../color", "../ConductiveEpoxy",
           "../DiffractionLimit", "../dtsa2",
           "../EDAX", "../fitness","../ggplot2Intro",
           "../ggvisIntro", "../git", 
           "../gnuplot", "../hacklev",
           "../ImageJ", "../iOS",
           "../legacy", "../Lubuntu", "../mac",
           "../micro", "../msOffice",
           "../mysql", "../osPkgs",
           "../plagiarism", "../python", "../R",
           "../R-Anova", "../R-bar-plots", "../R-boxplots" ,
           "../R-Excel", "../R-foreach", "../R-GeoSpatial", 
           "../R-packages","../research",
           "../Salabim", "../shell", 
           "../skimage", "../Slidify", "../ST3",
           "../Sweave", "../tex", "../ubuntu",
           "../VS2010","../win", "../workflow", "../")

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

