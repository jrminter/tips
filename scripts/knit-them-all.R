# knit-them-all.R

rm(list=ls())
require(knitr)

strGitHome <- Sys.getenv("GIT_HOME")
strRel     <- '/tips/scripts'

names <- c("color.Rmd", "DiffractionLimit.Rmd", "git-tips.Rmd","gnuplot.Rmd",
           "ImageJ.Rmd", "Legacy.Rmd", "mac.Rmd", "micro.Rmd", "mysql.Rmd",
           "python.Rmd","R-tips.Rmd",
           "R-Anova.Rmd","Salabim-graphics.Rmd", "Slidify.Rmd",
           "Sweave.Rmd", "tex-tips.Rmd",
           "win.Rmd","README.Rmd")
rPath <- c("../color", "../DiffractionLimit", "../git", "../gnuplot", "../ImageJ",
           "../legacy", "../mac","../micro", "../mysql",
           "../python", "../R",
           "../R-Anova", "../Salabim", "../Slidify", "../Sweave",
           "../tex", "../win", "../")

knitIt <- function(wrkPath, scrPath, theName){
  setwd(wrkPath)
  knit2html(theName)
  theMD <- paste0(strsplit(theName, ".Rmd")[[1]], ".md")
  file.remove(theMD)
  setwd(scrPath)
}

strScripts <- paste0(strGitHome, strRel)



# print(strGitHome)



setwd(strScripts)

for(i in 1:length(names))
{
  knitIt(rPath[i], strScripts, names[i])
}

