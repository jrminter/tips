library(gganimate)
library(ggplot2)

ggplot(mpg) + 
geom_point(aes(x = displ, y = hwy)) + 
ggtitle("Cars with {closest_state} cylinders") + 
transition_states(factor(cyl))