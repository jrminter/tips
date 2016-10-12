# anaSiBeamMeasurements2.R
rm(list=ls())

library(rAnaLab)

gitHome = Sys.getenv('GIT_HOME')
relWrk = '/tips/AZtec/R'
wd = paste0(gitHome, relWrk)
oldWd = getwd()
setwd(wd)
print(oldWd)

df <- read.csv('../csv/Beam-Meas-CuL-100s-2016-10-15.csv', header=TRUE,
                as.is=TRUE)

print(df)

cu.mu <- round(df$cu.la.cts.mu/(df$lt.s*df$pc.na), 2)
cu.un <- round(df$cu.la.cts.s/(df$lt.s*df$pc.na), 2)
e0    <- df$e0

df <- data.frame(e0=e0, cu.mu=cu.mu, cu.un=cu.un)

print(df)

poly.model <- lm(cu.mu ~ e0 + I(e0^2) , data=df) 
poly.sum   <- summary(poly.model)
print(poly.sum$coef)


e0 <- seq(from=2.0, to=22.0, by=0.5)
df2 <- data.frame(e0=e0)
df2$cu.mu = predict(poly.model, newdat=df2)


cuCpsPerNa <- ggplot(df, aes(x=e0, y=cu.mu)) +
                     geom_line(color='blue', size=1.25, aes(color="blue"), data=df2) +
                     annotate("text", label = 'polynomial o(2)',
                     x = 18, y = 7500,
                     size = 5, colour = "blue") +
                     geom_point(color='black', size=2.0) +
                     # geom_abline(intercept=lm.b, slope=lm.m,
                     #            colour='blue', size=1.25) +
                     scale_x_continuous(name="e0 [kV]", limits=c(0, 22)) +
                     scale_y_continuous(name="Cu-L cps/nA", limits=c(0, 10000)) +
                     
                     # xlab("e0 [kV]") +
                     # ylab("Si-K cps/nA") + 
                     annotate("text", label = '2016-10-05',
                     x = 18, y = 500,
                     size = 5, colour = "black") +
                     ggtitle("Cu-L X-ray Peak Intensity") +
                     theme(axis.text=element_text(size=12),
                     axis.title=element_text(size=14))

print(cuCpsPerNa)

# save the model
cu.l.cps.per.na.poly.coef <- poly.sum$coef
fi <- '../dat/cu.l.cps.per.na.poly.coef.RData'
save(cu.l.cps.per.na.poly.coef, file=fi)


fi <- '../img/cu-l-cps-per-nA-plt.png'
ggsave(cuCpsPerNa, file=fi, width=9.0, height=6.0, units="in", dpi=150)