# knit-them-all.R

rm(list=ls())
library(knitr)
library(rmarkdown)

strGitHome <- Sys.getenv("GIT_HOME")
if(strGitHome=="") strGitHome="~/Documents/git"
#if(strGitHome=="/Users/jrminter/git") strGitHome="/Users/jrminter/Documents/git"
strRel     <- '/tips/scripts'

names <- c("AccessToSqlite.Rmd", "automater.Rmd", "AZtec.Rmd",
           "C++11-Tips.Rmd",
           "chntpw.Rmd", "color.Rmd", "ConductiveEpoxy.Rmd",
           "DiffractionLimit.Rmd", "dtsa2.Rmd",
           "EDAX.Rmd", "Excel.Rmd","fitness.Rmd", 
           "ggplot2-figure.Rmd", "ggplot2Intro.Rmd",
           "ggvisIntro.Rmd","ggplot2UseCases.Rmd", "git-tips.Rmd", 
           "gnuplot.Rmd","hacklev.Rmd", "hyperspy.Rmd",
           "ImageJ.Rmd", "iOS.Rmd", "jekyll-github.Rmd", "Legacy.Rmd",
           "Lubuntu.Rmd", "mac.Rmd", 
           "micro.Rmd", "midb.Rmd", "msOffice.Rmd", 
           "mysql.Rmd", "osPkgs.Rmd",
           "plagiarism.Rmd",
           "python.Rmd","R-tips.Rmd", 
           "R-Anova.Rmd", "R-bar-plots.Rmd", "R-boxplots.Rmd",
           "R-Excel.Rmd","R-foreach.Rmd", "R-GeoSpatial.Rmd",
           "R-loess.Rmd", "R-packages.Rmd",
           "ReproducibleResearch.Rmd", "research.Rmd",
           "SEM.Rmd", "shell-tips.Rmd", "skills.Rmd",
           "skimage.Rmd","Slidify.Rmd", "ST3.Rmd",
           "Sweave.Rmd", "tex-tips.Rmd","ubuntu.Rmd",
           "VS2010.Rmd","win.Rmd","workflow.Rmd", "README.Rmd")

rPath <- c("../AccessToSqlite", "../automater", 
           "../AZtec", "../C++11",
           "../chntpw", "../color", "../ConductiveEpoxy",
           "../DiffractionLimit", "../dtsa2",
           "../EDAX", "../Excel", "../fitness",
           "../ggplot2figure" , "../ggplot2Intro",
           "../ggvisIntro","../ggplot2UseCases", "../git", 
           "../gnuplot", "../hacklev", "../hyperspy",
           "../ImageJ", "../iOS", "../jekyll-github", 
           "../legacy", "../Lubuntu", "../mac",
           "../micro",  "../midb", "../msOffice",
           "../mysql", "../osPkgs", 
           "../plagiarism", "../python", "../R",
           "../R-Anova", "../R-bar-plots", "../R-boxplots" ,
           "../R-Excel", "../R-foreach", "../R-GeoSpatial", 
           "../R-loess", "../R-packages",
           "../ReproducibleResearch", "../research",
           "../SEM", "../shell", "../skills",
           "../skimage", "../Slidify", "../ST3",
           "../Sweave", "../tex", "../ubuntu",
           "../VS2010","../win", "../workflow", "../")

knitIt <- function(wrkPath, scrPath, theName){
  print(wrkPath)
  setwd(wrkPath)
  # knit2html(theName)
  rmarkdown::render(theName)
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


