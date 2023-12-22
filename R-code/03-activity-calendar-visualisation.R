# Run code setup script ----

source("R-code/01-code-setup.R")


# Load cleansed activities data ----

activities_cleansed <- read_csv("data-cleansed/activities_cleansed.csv")


# Calendar visualisation data wrangle ----

#> We want to find the max and min date so that we can have a full dataset
#> where one row represents a given day.

min_date <- floor_date(min(activities_cleansed$date), "month")
max_date <- max(activities_cleansed$date)

table_of_dates <- seq(min_date, max_date, "1 day") %>% 
  as_tibble() %>% 
  rename(date = value) |> 
  mutate(date_day = weekdays(date),
         date_week = week(date),
         date_month = month(date, label = TRUE),
         date_year = year(date))

complete_run_data <- table_of_dates %>% 
  left_join(activities_cleansed |> 
              select(date, distance_km)) %>% 
  group_by(date) %>% 
  summarise(distance_km = sum(distance_km))
  

#> We then have to add in some additional variables regarding the date so that
#> we can build the calendar plot.

months <- c("January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December")

weekdays <- c("Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
              "Sunday")

#> We will the make the final data table required to make the calendar data
#> visualisation.

calendar_data <- 
  complete_run_data %>% 
  mutate(wday = weekdays(date),
         month_day = day(date),
         month = month(date),
         year = year(date),
         week_increment = if_else(month_day == 1 | wday == "Monday", 1, 0)) %>% 
  group_by(month, year) %>% 
  mutate(week = cumsum(week_increment),
         text_month = months(date)) %>% 
  ungroup() %>% 
  mutate(wday = factor(wday, levels = weekdays),
         text_month = factor(text_month, levels = months),
         distance_km = replace_na(distance_km, 0),
         activity_type = if_else(distance_km > 0, "Run", "No Run"))



# Plotting the activity calendar ----

calendar_plot <- 
  calendar_data |> 
  ggplot(aes(x = wday, y = week)) +
  geom_tile(col = "grey", fill = "white") +
  geom_point(aes(size = distance_km),
             colour = "#36c597") +
  geom_text(aes(label = month_day), 
            family = "Indie",
            colour = "black",
            size = 4) +
  scale_y_reverse() +
  scale_x_discrete(labels = c("M", "T", "W", "T", "F", "S", "S")) +
  facet_wrap(~text_month, scales = "free_x") +
  theme_bw() +
  theme_calendar()

calendar_plot
