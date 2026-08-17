# TIME FOR SOME GG PLOT>>

# need to read in files everytime
library(tidyverse)

library(palmerpenguins)

# _**GGPLOT**_

# all this does is declare a figure
ggplot(data = penguins)

# Let's see the **mappings**
ggplot(data = penguins,
    mapping = aes(
        flipper_length_mm,
        y = body_mass_g
    )
)

# Let us add a **geometry**
ggplot(data = penguins,
    mapping = aes(
        flipper_length_mm,
        y = body_mass_g
    )
) +
  geom_point() 

# Your turn
# what type of figures are created with the following **geometries**

ggplot(data = penguins, mapping = aes(x = island)) +
  geom_bar() # this is a categorical variable

ggplot(data = penguins, mapping = aes(x = body_mass_g)) +
  geom_histogram() # this is a continuous variable

ggplot(data = penguins, mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot() 


# X and Y are not our only aesthetics

ggplot(data = penguins,
     mapping = aes(
        x = species,
        y = body_mass_g,
        fill = species)
    ) +
  geom_boxplot()


# what is fill and x refer to different columns 
ggplot(data = penguins,
     mapping = aes(
        x = species,
        y = body_mass_g,
        fill = island)
    ) +
  geom_boxplot()


# _**Scales**_ control how mappings appear
ggplot(data = penguins,
     mapping = aes(
        x = species,
        y = body_mass_g,
        fill = island)
    ) +
  
  geom_boxplot() +
  
  scale_y_continuous(
    name = "Body Mass (g)", 
    n.breaks = 7, 
    limits = c(2000, 7000)) +
  
  scale_x_discrete(
    name = "Penguin Species") 


# The shape aes() that works on scatterplots
ggplot(
    data = penguins, 
    mapping = aes(
        x = body_mass_g, 
        y = flipper_length_mm,
        shape = species, 
        color = species)
    ) + 
  
  geom_point() +

  scale_shape_manual(
    values = c(
        Adelie = "square",
        Chinstrap = "diamond",
        Gentoo = "circle"
    )
  )



# REMEMBER 

# functions 

# data, mapping, scale, geometry

