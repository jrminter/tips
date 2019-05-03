# knit-them-all.R

rm(list=ls())
library(knitr)
library(rmarkdown)

sleep_time <- 2

strGitHome <- Sys.getenv("GIT_HOME")
if(strGitHome=="") strGitHome="~/Documents/git"
#if(strGitHome=="/Users/jrminter/git") strGitHome="/Users/jrminter/Documents/git"
strRel     <- '/tips/scripts'

names <- c("README.Rmd",
           "AccessToSqlite.Rmd", "automater.Rmd", "AZtec.Rmd", "bibtex.Rmd",
           "C++11-Tips.Rmd", "carbonFilmThickness.Rmd",
           "chntpw.Rmd", "color.Rmd", "ConductiveEpoxy.Rmd",
           "DataScience-linux64.Rmd", "Debian.Rmd","Denton.Rmd",
           "DiffractionLimit.Rmd", "dtsa2.Rmd",
           "earth-sci.Rmd","EDAX.Rmd", "Excel.Rmd",
           "epma-matrix-corr.Rmd", "fitness.Rmd",
           "french-press-instructions.Rmd", "generator.Rmd","gfortran.Rmd",
           "ggplot2-figure.Rmd", "ggplot2Intro.Rmd",
           "ggvisIntro.Rmd","ggplot2UseCases.Rmd", "git-tips.Rmd", 
           "gnuplot.Rmd","hacklev.Rmd", "homebrew.Rmd", "hyperspy.Rmd",
           "ImageJ.Rmd", "inkscape.Rmd", "iOS.Rmd", "jekyll-github.Rmd",
           "json.Rmd","Legacy.Rmd", "Logos.Rmd",
           "Lubuntu.Rmd", "mac.Rmd", "mac-for-data-science.Rmd",
           "micro.Rmd", "micro-sample-prep.Rmd", "midb.Rmd", 
           "monteCarlo.Rmd", "msOffice.Rmd", 
           "mysql.Rmd", "Octave.Rmd", "osPkgs.Rmd", "pandoc.Rmd", "penepma.Rmd",
           "plagiarism.Rmd", "portableMakefiles.Rmd",
           "prepForEDS.Rmd", "probeForEPMA.Rmd",
           "python.Rmd","R-tips.Rmd", 
           "R-Anova.Rmd", "R-bar-plots.Rmd", "R-boxplots.Rmd",
           "R-character-encoding.Rmd","R-data-pipeline.Rmd",
           "R-Excel.Rmd","R-foreach.Rmd", "R-GeoSpatial.Rmd",
           "R-knitrBootstrap.Rmd", "R-lm.Rmd", "R-loess.Rmd",
           "R-markdown.Rmd", "R-matrix-algebra.Rmd", "R-memes.Rmd",
           "R-model-predict.Rmd","R-packages.Rmd",
           "ReproducibleResearch.Rmd", "research.Rmd",
           "SEM.Rmd", "shell-tips.Rmd", "skills.Rmd",
           "skimage.Rmd", "Slidify.Rmd", "software-dev.Rmd", "SQL.Rmd",
           "ST3.Rmd", "Stratagem.Rmd", "Sweave.Rmd",
           "TEM.Rmd", "tex-tips.Rmd", "tidyData.Rmd", "TV.Rmd",
           "ubuntu.Rmd", "vacuum.Rmd",
           "VS2010.Rmd","win.Rmd","workflow.Rmd",
           "wxMaxima.Rmd", "README.Rmd")

rPath <- c("../",
           "../AccessToSqlite", "../automater", 
           "../AZtec", "../bibtex", "../C++11", "../carbonFilmThickness", 
           "../chntpw", "../color", "../ConductiveEpoxy",
           "../DataScience-linux64", "../Debian","../Denton",
           "../DiffractionLimit", "../dtsa2","../earth-sci",
           "../EDAX", "../Excel", "../epma-matrix-corr",
           "../fitness", "../french-press-instructions","../generator",
           "../gfortran", "../ggplot2figure" , "../ggplot2Intro",
           "../ggvisIntro","../ggplot2UseCases", "../git", 
           "../gnuplot", "../hacklev", 
           "../homebrew","../hyperspy",
           "../ImageJ", "../inkscape", "../iOS", "../jekyll-github", 
           "../json","../legacy", "../Logos",
           "../Lubuntu", "../mac", "../mac-for-data-science",
           "../micro", "../micro-sample-prep" , "../midb", 
           "../monteCarlo",  "../msOffice",
           "../mysql", "../Octave", "../osPkgs", "../pandoc", "../penepma",
           "../plagiarism", "../portableMakefiles",
           "../prepForEDS", "../probeForEPMA",
           "../python", "../R",
           "../R-Anova", "../R-bar-plots", "../R-boxplots" ,
           "../R-character-encoding", "../R-data-pipeline",
           "../R-Excel", "../R-foreach", "../R-GeoSpatial", 
           "../R-knitrBootstrap", "../R-lm","../R-loess",
           "../R-markdown", "../R-matrix-algebra", "../R-memes",
           "../R-model-predict", "../R-packages",
           "../ReproducibleResearch", "../research",
           "../SEM", "../shell", "../skills",
           "../skimage", "../Slidify", "../software-dev", "../SQL",
           "../ST3", "../Stratagem", "../Sweave",
           "../TEM","../tex", "../tidyData",
           '../TV', "../ubuntu",
           "../vacuum",
           "../VS2010","../win", "../workflow", 
           "../wxMaxima", "../")

knitIt <- function(wrkPath, scrPath, theName){
  print(wrkPath)
  setwd(wrkPath)
  # knit2html(theName)
  rmarkdown::render(theName)
  theMD <- paste0(strsplit(theName, ".Rmd")[[1]], ".md")
  file.remove(theMD)
  setwd(scrPath)
  Sys.sleep(sleep_time)
}

strScripts <- paste0(strGitHome, strRel)
print(strScripts)



# print(strGitHome)



setwd(strScripts)

for(i in 1:length(names))
{
  knitIt(rPath[i], strScripts, names[i])
}


