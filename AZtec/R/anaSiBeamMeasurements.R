# anaSiBeamMeasurements2.R
rm(list=ls())

library(rAnaLab)

gitHome = Sys.getenv('GIT_HOME')
relWrk = '/tips/AZtec/R'
wd = paste0(gitHome, relWrk)
oldWd = getwd()
setwd(wd)
print(oldWd)

df <- read.csv('../csv/Beam-Meas-SiK-100s-2016-10-15.csv', header=TRUE,
                as.is=TRUE)

si.mu <- round(df$si.ka.cts.mu/(df$lt.s*df$pc.na), 2)
si.un <- round(df$si.ka.cts.s/(df$lt.s*df$pc.na), 2)
e0    <- df$e0

df <- data.frame(e0=e0, si.mu=si.mu, si.un=si.un)

print(df)

lin.model <- lm(si.mu ~ e0, data=df) 
lin.sum   <- summary(lin.model)

# print(str(lin.sum))
print(lin.sum$coef)


lm.b <- round(lin.sum$coef[1], 1)
lm.m <- round(lin.sum$coef[2], 1)

siCpsPerNa <- ggplot(df, aes(x=e0, y=si.mu)) + 
                     geom_point(color='black', size=2.0) +
                     geom_abline(intercept=lm.b, slope=lm.m,
                                 colour='blue', size=1.25) +
                     scale_x_continuous(name="e0 [kV]", limits=c(0, 20)) +
                     scale_y_continuous(name="Si-K cps/nA", limits=c(0, 25000)) +
                     
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
si.k.cps.per.na.lm.coef <- lin.sum$coef
fi <- '../dat/si.k.cps.per.na.lm.coef.RData'
save(si.k.cps.per.na.lm.coef, file=fi)


fi <- '../img/si-cps-per-nA-plt.png'
ggsave(siCpsPerNa, file=fi, width=9.0, height=6.0, units="in", dpi=150)