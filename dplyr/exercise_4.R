# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
# Install and load nycflights13 and dplyr packages
install.packages("nycflights13")
library(nycflights13)
library(dplyr)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
# Inspect flights data frame
dim(flights)
names(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
# Add column for time gained or lost during flight
flights_gain <- flights %>% mutate(gain_in_air = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
# Sort data frame by gain_in_air column
flights_gain_sorted <- flights_gain %>% arrange(desc(gain_in_air))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
# Repeat last two steps using pipe operator
flights_gain_sorted <- flights %>%
  mutate(gain_in_air = arr_delay - dep_delay) %>%
  arrange(desc(gain_in_air))

# Make a histogram of the amount of time gained using the `hist()` function
# Create histogram of time gained
hist(flights_gain_sorted$gain_in_air)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
# Compute average time gained or lost
mean(flights_gain_sorted$gain_in_air, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
# Create data frame of flights to SeaTac
sea_flights <- flights_gain_sorted %>% 
  filter(dest == "SEA") %>% 
  select(origin, dest, gain_in_air)

# On average, did flights to SeaTac gain or loose time?
# Compute average time gained or lost for flights to SeaTac
mean(sea_flights$gain_in_air, na.rm = TRUE)

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
# Compute summary statistics for air time of JFK to SEA flights
jfk_sea_flights <- flights %>% 
  filter(origin == "JFK" & dest == "SEA") %>% 
  summarise(avg_air_time = mean(air_time, na.rm = TRUE),
            min_air_time = min(air_time, na.rm = TRUE),
            max_air_time = max(air_time, na.rm = TRUE))
