# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
# Compute average departure delay by month
dep_delay_by_month <- flights %>% 
  group_by(month) %>% 
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE))

# Which month had the greatest average departure delay?
# Find month with greatest average departure delay
dep_delay_by_month %>% 
  filter(avg_dep_delay == max(avg_dep_delay)) %>% 
  select(month)

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
# Create scatterplot of average departure delay by month
plot(dep_delay_by_month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
# Find destinations with highest average arrival delays
flights %>% 
  group_by(dest) %>% 
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  arrange(desc(avg_arr_delay)) %>% 
  head()

# You can look up these airports in the `airports` data frame!
# Find city flown to with highest average speed
flights %>% 
  mutate(speed = distance / air_time) %>% 
  group_by(dest) %>% 
  summarise(avg_speed = mean(speed, na.rm = TRUE)) %>% 
  arrange(desc(avg_speed)) %>% 
  slice(1) %>%
  left_join(airports, by = c("dest" = "faa")) %>%
  select(name)

# Which city was flown to with the highest average speed?
