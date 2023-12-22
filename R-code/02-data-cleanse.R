# Run code setup script ----

source("R-code/01-code-setup.R")


# Data cleanse ----

# Choose activity type to consider for this project.
chosen_activity_type <- "Run"

# Load raw data and cleanse.
activities_cleansed <- read_csv("data-raw/activities.csv") |> 
  clean_names() |>
  filter(activity_type == chosen_activity_type) |> 
  transmute(date = as.Date(str_sub(activity_date, 1, 12),format = "%b %d, %Y"),
            date_day = weekdays(date),
            date_week = week(date),
            date_month = month(date, label = TRUE),
            date_year = year(date),
            activity_id,
            distance_km = distance_7)

# Get most recent year.
most_recent_year <- max(activities_cleansed$date_year)


# Save cleansed data ----
write_csv(activities_cleansed |> filter(date_year == most_recent_year),
          "data-cleansed/activities_cleansed.csv")

