# setwd("M:/projects/2010/R/lognormal-fit")
# source("fit_lognormal_distn.R")
#
rm(list=ls())

# change these to suit
strWorkbook <- "qm-02481_NiSO4_M-post.xls"
strCol <- "ECD (µm)"
strLongTitle <- "qm-02481_NiSO4_M-3000 hrs"
strShortTitle <- "qm-02481_NiSO4_M-post"
strQqFile <- "qm-02481_NiSO4_M-post_qq.pdf"
strHistFile <- "qm-02481_NiSO4_M-post_hist.pdf"
strOutFile <- "StreamNozzleID_out.csv"
nBins <- 25 # number histogram bins
nCalc <- 40 # number of calculated points
#
# you shouldn't need to change anything below here
#
library(RODBC)
library(MASS)


cnct <- odbcConnectExcel(strWorkbook)
dataframe <- sqlQuery(cnct, "SELECT * FROM [DATA$]")
close(cnct)
x <- dataframe[, strCol]
(f<-fitdistr(x, 'lognormal'))
gmd <- round(exp(f$estimate[[1]]),3)
gsd <- round(exp(f$estimate[[2]]),3)
# xlab <- paste('Lognormal(meanlog=',round(f$estimate[[1]],3))
# xlab <- paste(xlab,', sdlog=')
# xlab <- paste(xlab,round(f$estimate[[2]],3))
# xlab <- paste(xlab,')')

xlab <- paste('Lognormal(gmd =', gmd)
xlab <- paste(xlab,' [µm], gsd =')
xlab <- paste(xlab, gsd)
xlab <- paste(xlab,')')
strYlab <- paste(strShortTitle, ' ', strCol)
qqplot(qlnorm(ppoints(x), meanlog=f$estimate[[1]], sdlog=f$estimate[[2]]), x, main='QQ plot (Lognormal)', xlab=xlab, ylab=strYlab )
grid()
dev.copy(pdf, file=strQqFile, height=8.5, width=11, onefile=T)
dev.off()

cat("Press enter key to continue","\n")
foo <- readLines(stdin(), 1)


print(f)
strXlab <- paste(strCol, ' red - lognormal fit (gmd =', gmd)
strXlab <- paste(strXlab,' [µm], gsd =')
strXlab <- paste(strXlab, gsd)
strXlab <- paste(strXlab,')')
h <- hist(x, breaks=nBins)
xhist<-c(min(h$breaks),h$breaks)
yhist<-c(0,h$density,0)
xfit<-seq(min(x),max(x),length=nCalc)
yfit<-dlnorm(xfit,meanlog=f$estimate[[1]], sdlog=f$estimate[[2]])
plot(xhist,yhist,type="s",ylim=c(0,max(yhist,yfit)), main=strLongTitle, xlab=strXlab, ylab="Frequency")
lines(xfit,yfit, col="red")
dev.copy(pdf, file=strHistFile, height=8.5, width=11, onefile=T)
dev.off()
# summary(mrchart)

# resLst <- list(name=strLongTitle, numGroups = ichart$general$numTot,lclEcd=ichart$graphPars$lcl3[1], meanEcd=ichart$general$meanX, uclEcd=ichart$graphPars$ucl3[1], meanRange=mrchart$general$meanX, uclRange=mrchart$graphPars$ucl3[3])
# print(resLst)

# write.csv(resLst, strOutFile, row.names=F, quote=F)





