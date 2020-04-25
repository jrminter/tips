library(gganimate)
library(ggplot2)
mpg2 <- tidyr::pivot_longer(mpg, c(cty,hwy))
ggplot(mpg2) + 
  geom_point(aes(x = displ, y = value)) + 
  ggtitle("{if (closest_state == 'cty') 'Efficiency in city' else 'Efficiency on highway'}") + 
  transition_states(name)
