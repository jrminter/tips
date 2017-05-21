# knit-them-all.R

rm(list=ls())
library(knitr)
library(rmarkdown)

strGitHome <- Sys.getenv("GIT_HOME")
if(strGitHome=="") strGitHome="~/Documents/git"
#if(strGitHome=="/Users/jrminter/git") strGitHome="/Users/jrminter/Documents/git"
strRel     <- '/tips/scripts'

names <- c("Readme.Rmd",
           "AccessToSqlite.Rmd", "automater.Rmd", "AZtec.Rmd",
           "C++11-Tips.Rmd",
           "chntpw.Rmd", "color.Rmd", "ConductiveEpoxy.Rmd",
           "DiffractionLimit.Rmd", "dtsa2.Rmd",
           "EDAX.Rmd", "Excel.Rmd","fitness.Rmd", 
           "ggplot2-figure.Rmd", "ggplot2Intro.Rmd",
           "ggvisIntro.Rmd","ggplot2UseCases.Rmd", "git-tips.Rmd", 
           "gnuplot.Rmd","hacklev.Rmd", "hyperspy.Rmd",
           "ImageJ.Rmd", "iOS.Rmd", "jekyll-github.Rmd",
           "Legacy.Rmd", "Logos.Rmd",
           "Lubuntu.Rmd", "mac.Rmd", 
           "micro.Rmd", "midb.Rmd", 
           "monteCarlo.Rmd", "msOffice.Rmd", 
           "mysql.Rmd", "osPkgs.Rmd",
           "plagiarism.Rmd", "prepForEDS.Rmd",
           "python.Rmd","R-tips.Rmd", 
           "R-Anova.Rmd", "R-bar-plots.Rmd", "R-boxplots.Rmd",
           "R-Excel.Rmd","R-foreach.Rmd", "R-GeoSpatial.Rmd",
           "R-loess.Rmd", "R-markdown.Rmd", "R-packages.Rmd",
           "ReproducibleResearch.Rmd", "research.Rmd",
           "SEM.Rmd", "shell-tips.Rmd", "skills.Rmd",
           "skimage.Rmd","Slidify.Rmd", "ST3.Rmd", "Stratagem.Rmd",
           "Sweave.Rmd", "tex-tips.Rmd","ubuntu.Rmd",
           "VS2010.Rmd","win.Rmd","workflow.Rmd", "README.Rmd")

rPath <- c("../",
           "../AccessToSqlite", "../automater", 
           "../AZtec", "../C++11",
           "../chntpw", "../color", "../ConductiveEpoxy",
           "../DiffractionLimit", "../dtsa2",
           "../EDAX", "../Excel", "../fitness",
           "../ggplot2figure" , "../ggplot2Intro",
           "../ggvisIntro","../ggplot2UseCases", "../git", 
           "../gnuplot", "../hacklev", "../hyperspy",
           "../ImageJ", "../iOS", "../jekyll-github", 
           "../legacy", "../Logos",
           "../Lubuntu", "../mac",
           "../micro",  "../midb", 
           "../monteCarlo",  "../msOffice",
           "../mysql", "../osPkgs", 
           "../plagiarism", "../prepForEDS",
           "../python", "../R",
           "../R-Anova", "../R-bar-plots", "../R-boxplots" ,
           "../R-Excel", "../R-foreach", "../R-GeoSpatial", 
           "../R-loess", "../R-markdown", "../R-packages",
           "../ReproducibleResearch", "../research",
           "../SEM", "../shell", "../skills",
           "../skimage", "../Slidify", "../ST3", "../Stratagem",
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


