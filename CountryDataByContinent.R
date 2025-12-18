library(ggplot2)
library(tidyverse)
library(kableExtra)
library(rvest)
library(readxl)
library(tibble)

continents <- read_excel("C:/Users/pacad/Downloads/CountryByContinent.xlsx") %>%
  add_row(Brazil = "Brazil", `South America` = "South America", .before = 1) %>%
  rename(
    "country" = "Brazil",
    "continent" = "South America"
  )

countries <- CountryData

polished <- countries %>%
  select(c(1:6),12,16,18,26) %>%
  left_join(continents, by = "country") %>%
  drop_na() %>%
  rename("Continent" = "continent") %>%
  group_by(Continent) %>%
  summarise(
    Area_mean = mean(area),
    Pop_mean = mean(pop),
    Growth_mean = mean(growth),
    Birth_mean = mean(birth),
    Death_mean = mean(death),
    Health_mean = mean(health),
    Obesity_mean = mean(obesity),
    Educ_mean = mean(educ),
    Unemployment_mean = mean(unemployment)
  )

polished %>%
  kable( # Make Pretty Table
    caption = "Country Data Summary Statistics, Grouped By Continent", # Add Title
    align = c("l", rep("c", 6)) # Control the text alignment in each column
  ) %>%
  kable_classic( # Pre-built styling
    font_size = 16, # Control Font Size
    lightable_options = "striped" # Adds striping in a pre-built table style
  )