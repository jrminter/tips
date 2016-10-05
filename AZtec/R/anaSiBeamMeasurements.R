# anaSiBeamMeasurements.R
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


Si.cps.per.nA <- df$Si.K.ct/(df$live.time.s*df$pc.nA)
Si.cps.per.nA <- append(Si.cps.per.nA, 0.0)
e0.kV <- df$e0
e0.kV <- append(e0.kV, 0.0)

df <-data.frame(e0.kV=e0.kV, Si.cps.per.nA=Si.cps.per.nA)
df <- df[order(df[,1]), ]
print(df)

y.loess <- loess( Si.cps.per.nA ~ e0.kV, span=1, data=df)
df$Si.cps.per.nA.loess <-  predict(y.loess, data.frame(e0.kV=df$e0.kV))
plot(df$e0.kV, df$Si.cps.per.nA.loess)

e0.kV <- seq(from=0.05, to=20.0, by=0.1)
df2 <- data.frame(e0.kV=e0.kV)
df2$Si.cps.per.nA = round(predict(y.loess, newdata = df2), 5)
# plot(Si.cps.per.nA~e0.kV, data=df2)


siCpsPerNa <- ggplot(df, aes(x=e0.kV, y=Si.cps.per.nA)) + 
                     geom_line(color='blue', size=1.25, 
                               aes(color="blue"), data=df2)   +
                     annotate("text", label = 'LOESS',
                              x = 15, y = 20000,
                              size = 5, colour = "blue") +
                     geom_point(color='black', size=3.0) + 
                     xlab("e0 [kV]") +
                     ylab("Si-K cps/nA") + 
                     ggtitle("Si-K X-ray Peak Intensity") +
                     theme(axis.text=element_text(size=12),
                     axis.title=element_text(size=14))# or ,face="bold")) +

fi <- '../csv/computed-si-cps-per-na-2016-10-05.csv'
write.csv(df2, file=fi, row.names=FALSE)


print(siCpsPerNa)

fi <- '../img/si-cps-per-nA-plt.png'
ggsave(siCpsPerNa, file=fi, width=9.0, height=6.0, units="in", dpi=150)


