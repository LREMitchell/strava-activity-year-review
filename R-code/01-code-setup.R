# Required packages for project ----

library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(glue)
library(janitor)
library(stringr)
library(ggplot2)
library(scales)
library(showtext)
library(patchwork)


# Custom font load for data visualisations ----

showtext_auto()
font_add_google("Indie Flower", "Indie")
vis_font <- "Indie"


# Ggplot theme for calendar visualisation ----

theme_calendar <- function() {
  
  theme(
    
    # Main Visualisation Text...
    
    plot.title = element_text(
      family = vis_font,
      size = 34, 
      color = "black", 
      face = "bold", 
      margin = margin(t = 0, b = 2), 
      hjust = 0.5),
    plot.subtitle = element_text(
      family = vis_font,
      size = 16, 
      color = "black", 
      face = "plain", 
      margin = margin(b = 20), 
      hjust = 0.5),
    axis.title = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_text(
      family = vis_font,
      colour = "black",
      size = 10),
    
    # Strip Backgrounds (for facet wrap)...
    
    strip.background = element_rect(fill = "#fc4c02"),
    strip.text = element_text(
      family = vis_font,
      color = "white", 
      size = 15, 
      face = "bold"),
    
    # Legend Styling...
    
    legend.position = "none",
    legend.text.align = 0,
    legend.text = element_text(size = 10),
    legend.title = element_text(size = 12),
    
    # Grid + Axis Lines and Ticks...
    
    panel.grid = element_blank(),
    axis.ticks = element_blank(),
    axis.ticks.length = unit(0, "pt"),
    
    # Margin...
    
    plot.margin = margin(
      r = 15, 
      t = 15, 
      b = 15, 
      l = 15)
    
  )
  
}


