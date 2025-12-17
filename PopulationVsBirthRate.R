library(tidyverse)
library(ggplot2)
library(ggpubr)
library(jpeg)
library(dcData)

img <- readJPEG("C:/Users/pacad/Downloads/WorldMap.jpg")

countries <- CountryData %>%
  select(c(country, birth, pop)) %>%
  filter(pop > 100000)

locations <- CountryCentroids %>%
  select(c(name, long, lat)) %>%
  rename(country = name)

dataPolished <- left_join( 
  x = countries,
  y = locations,
  by = join_by(country == country)
)


ggplot(
  data = dataPolished,
  mapping = aes(
    x = long,
    y = lat,
    size = pop/1000000,
    color = birth
  )) + 
  background_image(img) +
  geom_point() + 
  coord_cartesian(xlim = c(-180,180), ylim = c(-90,90)) + 
  scale_color_gradient(low = 'red', high = 'blue') + 
  labs(
    x = "Longitude",
    y = "Latitude",
    title = "Map of Population and Birth Rate",
    color = "Births per
1000 People",
  ) + 
  guides(size = 'none')
