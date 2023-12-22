# Run code setup script ----

source("R-code/01-code-setup.R")


# Run code for generating each data visualisation ----

source("R-code/03-activity-calendar-visualisation.R")
source("R-code/04-days-of-running-visualisation.R")
source("R-code/05-distance-by-month-visualisation.R")


# Bring all the visualisation into single plot ----

# Get total number of KMs ran in year using distance run data.
total_distance <- 
  distance_by_month_data |> 
  summarise(total_distance = sum(distance_km)) |> 
  pull(total_distance)

# Then, create the bottom section of the new plot.
bottom_section_of_plot <- 
  (days_of_running_plot + distance_by_month_plot) + 
  plot_layout(widths = c(1, 2))

# Finally, combine this with the calendar visualisation to create the final plot.
activity_year_review_plot <- 
  calendar_plot / bottom_section_of_plot +
  plot_layout(heights = c(6, 1)) +
  plot_annotation(
    title = glue("Running Year in Review, {most_recent_year}"),
    subtitle = glue("{floor(total_distance)} kilometers"),
    theme = theme(
      plot.title = element_text(
        hjust = 0.5,
        family = "Indie",
        size = 30,
        margin = margin(t = 5, b = 0)),
      plot.subtitle = element_text(
        hjust = 0.5,
        family = "Indie",
        size = 24,
        margin = margin(t = 0, b = -5))
    ))

activity_year_review_plot


# Saving final visualisation ----

showtext_opts(dpi = 300)
ggsave("output/strava-activity-year-review-plot.png",
       width = 10, 
       height = 8, 
       units = "in")

