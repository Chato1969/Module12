# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
# Compute average arrival delay by destination and join with airports data frame
dest_arr_delay <- flights %>% 
  group_by(dest) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  left_join(airports, by = c("dest" = "faa"))

# Find airport with largest average arrival delay
dest_arr_delay %>% 
  filter(avg_arr_delay == max(avg_arr_delay)) %>% 
  select(name)

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
# Compute average arrival delay by airline and join with airlines data frame
airline_arr_delay <- flights %>% 
  group_by(carrier) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  left_join(airlines, by = "carrier")

# Find airline with smallest average arrival delay
airline_arr_delay %>% 
  filter(avg_arr_delay == min(avg_arr_delay)) %>% 
  select(name)
