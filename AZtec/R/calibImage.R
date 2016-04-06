# calibImage.R
rm(list=ls())
gitHome = Sys.getenv('GIT_HOME')
relWrk = '/tips/AZtec/R'
wd = paste0(gitHome, relWrk)
oldWd = getwd()
setwd(wd)
print(oldWd)

df <- read.csv('../csv/mag-cal-data.csv', header=TRUE, as.is=TRUE)
df$invMag <- 1/df$Mag
print(df)

# plot(umFW~invMag, data=df)

fitLM <- lm(umFW ~ 0 + invMag, data=df)
sumLM <- summary(fitLM)



slopeMu <- sumLM$coefficients[1]
slopeSE <- sumLM$coefficients[2]

fitRes <- c(slopeMu,slopeSE )
names(fitRes) <- c('mu', 'se')
print(fitRes)

strFit <- sprintf("Slope: mean = %.2f, std. err. = %.2f", slopeMu, slopeSE)


old.mar <- par('mar')
par('mar' = c(4.1,4.1,1.1,1.1))
plot(c(0,0.0015), c(0,500), type='n',
     xlab = 'inverse magnification',
     ylab = 'AZtec image full width [microns]')
points(umFW~invMag, data = df, pch=19, col='blue' )
abline(fitLM, lwd=1, col='blue')
legend('topleft', strFit)

par('mar' = old.mar)

setwd(oldWd)

estimateCal <- function(mag, imgWidth=1024, slope=289251.80, slopeSE=16.54){
  imFWMu <- slopeMu/mag
  imFWLCL <- (slopeMu-slopeSE)/mag
  imFWUCL <- (slopeMu+slopeSE)/mag
  sfMu <- imFWMu/imgWidth
  sfLC <- imFWLCL/imgWidth
  sfUC <- imFWUCL/imgWidth
  val <- c(sfLC, sfMu, sfUC)
  names(val) <- c('LCL', 'um.per.px', 'UCL')
  return(val)
}

es <- estimateCal(20000.)

print(es)






