# Run code setup script ----

source("R-code/01-code-setup.R")


# Load cleansed activities data ----

activities_cleansed <- read_csv("data-cleansed/activities_cleansed.csv")


# Data wrangle ----

distance_by_month_data <- 
  activities_cleansed |>
  mutate(month = month(date, label = TRUE)) |> # create month var again to maintain order
  group_by(month) |> 
  summarise(distance_km = sum(distance_km))


# Data Visualisation ----

distance_by_month_plot <- 
  distance_by_month_data |> 
  ggplot(aes(x = month, y = distance_km)) +
  geom_col(fill = "#36c597", col = "black") +
  geom_text(aes(label = glue("{floor(distance_km)}km")),
            family = "Indie",
            size = 4,
            nudge_y = 15) +
  theme_void() +
  theme_calendar()

distance_by_month_plot
