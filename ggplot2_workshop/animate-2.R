library(gganimate)
library(ggplot2)
ggplot(mpg) + 
  geom_bar(aes(x = factor(cyl)))
ggplot(mpg) + 
  geom_bar(aes(x = factor(cyl))) + 
  labs(title = 'Number of cars in {closest_state} by number of cylinders') + 
  transition_states(states = year) + 
  enter_grow() + 
  exit_fade()
