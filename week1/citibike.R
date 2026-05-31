library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('week1/201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))


########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)
# My answer: There are 224,736 trips

# find the earliest and latest birth years (see help for max and min to deal with NAs)
trips$birth_year <- suppressWarnings(as.integer(trips$birth_year))
latest_birth_year <- max(trips$birth_year, na.rm = TRUE)
earliest_birth_year <- min(trips$birth_year, na.rm = TRUE)
# My answers: the earilest birth year is 1899, and the latest birth year is 1997

# use filter and grepl to find all trips that either start or end on broadway
broadway_trips <- trips %>% filter(grepl('Broadway', start_station_name, ignore.case = TRUE)| grepl('Broadway',end_station_name, ignore.case = TRUE))
nrow(broadway_trips)
# Answers: There are 41,469 trips that start or end on broadway


# do the same, but find all trips that both start and end on broadway
 start_and_end_broadway <- trips %>% filter(grepl('Broadway', start_station_name, ignore.case = TRUE) & grepl('Broadway',end_station_name, ignore.case = TRUE))
 nrow(start_and_end_broadway)

# My answer: There are 2,776 trips that both start and end on Broadway

# find all unique station names
start_stations <- unique(trips$start_station_name)

# count the number of trips by gender, the average trip time by gender, and the standard deviation in trip time by gender

gender_info <- trips |> 
        group_by(gender) |>
        summarise(
                  count_trips = n(), 
                  avg_trip_time = mean(tripduration), 
                  std_trip_time = sd(tripduration)
        )

# do this all at once, by using summarize() with multiple arguments

gender_info <- trips |> 
        group_by(gender) |>
        summarise(
                  count_trips = n(), 
                  avg_trip_time = mean(tripduration), 
                  std_trip_time = sd(tripduration)
        )

# find the 10 most frequent station-to-station trips
station_counts <- trips |>
                    count(start_station_name, end_station_name, sort = TRUE)
top_combos <- head(station_counts, 10)
 
    # My answer: 
    #  1 E 43 St & Vanderbilt Ave W 41 St & 8 Ave          156
    #  2 Pershing Square N        W 33 St & 7 Ave          124
    #  3 Norfolk St & Broome St   Henry St & Grand St      122
    #  4 E 7 St & Avenue A        Lafayette St & E 8 St    121
    #  5 Henry St & Grand St      Norfolk St & Broome St   118
    #  6 W 17 St & 8 Ave          8 Ave & W 31 St          118
    #  7 Central Park S & 6 Ave   Central Park S & 6 Ave   115
    #  8 Lafayette St & E 8 St    E 6 St & Avenue B        115
    #  9 E 10 St & Avenue A       Lafayette St & E 8 St    108
    # 10 Canal St & Rutgers St    Henry St & Grand St      103

# find the top 3 end stations for trips starting from each start station

end_stations_per_trip <- trips |> group_by(start_station_name) |> slice_max(order_by = end_station_name, n = 3) |> select(start_station_name, end_station_name)

# find the top 3 most common station-to-station trips by gender

common_trips_by_gender <- trips |> 
group_by(gender,start_station_name, end_station_name) |> 
summarize(trip_count = n(), .groups = "drop") |> 
group_by(gender) |>
slice_max(order_by = trip_count, n = 3) |>
arrange(gender, desc(trip_count))

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
busiest_day <- trips |> 
            mutate(date = as.Date(starttime))|>
            group_by(date) |>
            summarize(trip_count = n(), .groups = "drop") |>
            slice_max(order_by = trip_count, n = 1)

# My answer: Feburary 2nd, 2026 with 13,816 trips

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?

avg_trips_by_hour <- trips |>
                    mutate(
                        date = as.Date(starttime),
                        hour = hour(starttime)
                    ) |>
                    group_by(date, hour) |> 
                    summarize(trip_count = n(), .groups = "drop") |>
                    group_by(hour) |>
                    summarize(avg_trips = mean(trip_count, na.rm = TRUE))


peak_hours <- avg_trips_by_hour |> arrange(desc(avg_trips)) |> slice_head(n = 3)
# Peak Hours are 4pm to 6pm.