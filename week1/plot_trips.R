########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration)) + scale_x_log10(label = comma) + geom_histogram(bins = 200)
ggplot(trips, aes(x = tripduration)) + scale_x_log10(label = comma) + geom_density()
# plot the distribution of trip times by rider type indicated using color and fill (compare a histogram vs. a density plot)
ggplot(trips, aes(x = tripduration, fill = usertype, color = usertype)) + scale_x_log10(label = comma)+ geom_histogram(bins = 200)
ggplot(trips, aes(x = tripduration, color = usertype)) + scale_x_log10(label = comma)+ geom_density()
# plot the total number of trips on each day in the dataset
new_trips <- trips %>% 
                    mutate(start_date = as.Date(starttime), 
                           start_time = format(starttime, "%H:%M:%S"),
                           stop_date  = as.Date(stoptime),
                           end_time  = format(stoptime, "%H:%M:%S"))

new_trips %>% group_by(start_date) %>% summarize(num_trips = n()) %>% ggplot(aes(x=start_date, y = num_trips)) + geom_line()

# plot the total number of trips (on the y axis) by age (on the x axis) and gender (indicated with color)

newer_trips <- new_trips %>% mutate (
                age = 2014 - birth_year
            )
newer_trips %>% group_by(age, gender) %>% summarize(num_trips = n()) %>% ggplot(aes(x = age, y = num_trips, color = gender)) + geom_line()

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the pivot_wider() function to reshape things to make it easier to compute this ratio
# (you can skip this and come back to it tomorrow if we haven't covered pivot_wider() yet)

newer_trips %>% group_by(age, gender) %>% summarise(num_trips = n()) %>% 
filter(gender != 'Unknown') %>% pivot_wider(
                                            names_from = gender,
                                            values_from = num_trips) %>%
                                            mutate(m_t_f_ratio = Male / Female) %>%
                                            ggplot(aes(x = age, y = m_t_f_ratio)) + scalegeom_point()

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

ggplot(weather, aes(x = date, y = tmin)) + geom_point()


# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the pivot_longer() function for this to reshape things before plotting
# (you can skip this and come back to it tomorrow if we haven't covered reshaping data yet)

weather %>% select(ymd, tmin, tmax) %>% 
pivot_longer(names_to = 'Temp', values_to = 'Degrees', 2:3) %>%
ggplot(aes(x = ymd, y = Degrees, color = Temp)) + geom_point()
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

trips_with_weather %>% group_by(ymd, tmin) %>% 
                    summarise(num_trips = n()) %>%
                    ggplot(aes(x = tmin, y = num_trips)) + geom_point() +
                    labs(
                        title = "Min Temperature vs Number Of Trips",
                        x = "Min Temperature",
                        y = "Number of Trips"
                    )


# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

trips_with_weather %>% group_by(ymd, tmin) %>% summarise(num_trips = n(), avg_precp = mean(prcp)) %>%
                        ggplot(aes(x = tmin, y = num_trips, color = avg_precp)) + geom_point() +
                    labs(
                        title = "Min Temperature vs Number Of Trips",
                        x = "Min Temperature",
                        y = "Number of Trips"
                    ) + geom_smooth()


# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

hour_avg_std <- trips_with_weather %>% mutate(hour = hour(starttime), date = date(starttime), .before = 1) %>% 
group_by(hour, date) %>% summarise(num_trips = n()) %>% group_by(hour) %>%
summarize(avg_num_trips = mean(num_trips), standard_devi = sd(num_trips))

# plot the above
ggplot(hour_avg_std, aes(x = hour, y = avg_num_trips)) +
geom_line() +
geom_ribbon(aes(ymin = avg_num_trips - standard_devi,
                ymax = avg_num_trips + standard_devi),
                alpha = 0.3) +
        labs (title = "Min Temperature vs Number Of Trips (With Standard Deviation)",
                        x = "Hour",
                        y = "Average Number of Trips"
            )

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
weekday_avg_std <- trips_with_weather %>% mutate(weekday = wday(starttime), date = date(starttime), .before = 1) %>% 
group_by(weekday, date) %>% summarise(num_trips = n()) %>% group_by(weekday) %>%
summarize(avg_num_trips = mean(num_trips), standard_devi = sd(num_trips))

ggplot(weekday_avg_std, aes(x = weekday, y = avg_num_trips)) +
geom_line() +
geom_ribbon(aes(ymin = avg_num_trips - standard_devi,
                ymax = avg_num_trips + standard_devi),
                alpha = 0.3) +
        labs (title = "Weekday vs Number Of Trips (With Standard Deviation)",
                        x = "Weekday",
                        y = "Average Number of Trips"
            )
