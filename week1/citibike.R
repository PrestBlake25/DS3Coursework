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

gender_info <- trips %>% group_by(gender) %>% summarize()

# do this all at once, by using summarize() with multiple arguments

# find the 10 most frequent station-to-station trips

# find the top 3 end stations for trips starting from each start station

# find the top 3 most common station-to-station trips by gender

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)

# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
