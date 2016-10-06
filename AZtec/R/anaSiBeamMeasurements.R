# anaSiBeamMeasurements2.R
rm(list=ls())

library(ggplot2)

gitHome = Sys.getenv('GIT_HOME')
relWrk = '/tips/AZtec/R'
wd = paste0(gitHome, relWrk)
oldWd = getwd()
setwd(wd)
print(oldWd)

df <- read.csv('../csv/Si-K-beam-calibration-2016-10-05.csv', header=TRUE,
                as.is=TRUE)
df$eov <- df$e0 - 1.7397 # This did not help at all
df$Si.cps.per.nA <- df$Si.K.cts/(df$live.time.s*df$pc.nA)

print(df)

lin.model <- lm(Si.cps.per.nA ~ e0, data=df) 
lin.sum  <- summary(lin.model)

# print(str(lin.sum))
print(lin.sum$coef)


lm.b <- lin.sum$coef[1]
lm.m <- lin.sum$coef[2]

siCpsPerNa <- ggplot(df, aes(x=e0, y=Si.cps.per.nA)) + 
                     scale_x_continuous(name="e0 [kV]", limits=c(0, 20)) +
                     scale_y_continuous(name="Si-K cps/nA",
                                        limits=c(0, 25000)) +
                     geom_abline(intercept=lm.b, slope=lm.m,
                                 colour='blue', size=1.25) +
                     geom_point(color='black', size=3.0) + 
                     # xlab("e0 [kV]") +
                     # ylab("Si-K cps/nA") + 
                     annotate("text", label = '2016-10-05',
                     x = 18, y = 500,
                     size = 5, colour = "black") +
                     ggtitle("Si-K X-ray Peak Intensity") +
                     theme(axis.text=element_text(size=12),
                     axis.title=element_text(size=14))

print(siCpsPerNa)

# save the model
si.cps.per.Na.lm.coef <- lin.sum$coef
fi <- '../dat/si-cps-per-nA-coef.RData'
save(si.cps.per.Na.lm.coef, file=fi)


fi <- '../img/si-cps-per-nA-plt.png'
ggsave(siCpsPerNa, file=fi, width=9.0, height=6.0, units="in", dpi=150)