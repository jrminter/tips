library(gganimate)
library(ggplot2)
ggplot(economics) + 
  geom_line(aes(x = date, y = unemploy))
ggplot(economics) + 
  geom_line(aes(x = date, y = unemploy)) + 
  transition_reveal(along = date)
