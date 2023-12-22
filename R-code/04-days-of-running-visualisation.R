# Run code setup script ----

source("R-code/01-code-setup.R")


# Load cleansed activities data ----

activities_cleansed <- read_csv("data-cleansed/activities_cleansed.csv")
most_recent_year <- max(activities_cleansed$date_year)


# Data warngle for visualisation ----

days_in_year <- if(leap_year(most_recent_year) == TRUE){366} else {365}

days_ran <- activities_cleansed |> 
  distinct(date) |> 
  nrow()

days_no_run <- days_in_year - days_ran

days_run_data <- 
  tibble(
    year = c(most_recent_year, most_recent_year),
    run_category = c("run", "no run"),
    days = c(days_ran, days_no_run)
  )

# Data visualisation ----

days_of_running_plot <- 
  days_run_data |> 
  mutate(bar_label = if_else(
    run_category == "run",
    glue("{days_ran} days\nof running\nin {most_recent_year}"),
    glue("{days_no_run} days\nwithout running\nin {most_recent_year}"))) |> 
  ggplot(aes(x = year, y = days)) +
  scale_fill_manual(values = c("white", "#36c597")) +
  geom_col(aes(fill = run_category, colour = run_category),
           colour = "black", 
           show.legend = FALSE) +
  geom_text(aes(label = bar_label),
            colour = "black",
            position = position_stack(vjust = 0.5),
            family = "Indie",
            size = 5,
            lineheight = 0.6) + 
  scale_y_continuous(labels = c(0, days_in_year), breaks = c(0, days_in_year)) +
  coord_flip() +
  theme_void() +
  theme(
    axis.text.x = element_text(
      size = 14,
      family = "Indie"),
    axis.title.x = element_text(
      size = 14,
      family = "Indie",
      margin = margin(t = -10)
    ))

days_of_running_plot
