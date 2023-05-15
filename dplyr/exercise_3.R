# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
# Approach 1: Using temporary variables
acura_2015 <- vehicles %>% filter(year == 2015 & manufacturer == "acura")
acura_2015_ordered <- acura_2015 %>% arrange(desc(hwy))
best_acura_2015 <- acura_2015_ordered %>% slice(1) %>% select(model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
# Approach 2: Nesting functions
best_acura_2015 <- vehicles %>% 
  filter(year == 2015 & manufacturer == "acura") %>% 
  arrange(desc(hwy)) %>% 
  slice(1) %>% 
  select(model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
# Approach 3: Using the pipe operator
best_acura_2015 <- vehicles %>%
  filter(year == 2015 & manufacturer == "acura") %>%
  arrange(desc(hwy)) %>%
  slice(1) %>%
  select(model)


### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times
# Bonus: Define functions for each approach
best_acura_1 <- function() {
  acura_2015 <- vehicles %>% filter(year == 2015 & manufacturer == "acura")
  acura_2015_ordered <- acura_2015 %>% arrange(desc(hwy))
  best_acura_2015 <- acura_2015_ordered %>% slice(1) %>% select(model)
}

best_acura_2 <- function() {
  vehicles %>% 
    filter(year == 2015 & manufacturer == "acura") %>% 
    arrange(desc(hwy)) %>% 
    slice(1) %>% 
    select(model)
}

best_acura_3 <- function() {
  vehicles %>%
    filter(year == 2015 & manufacturer == "acura") %>%
    arrange(desc(hwy)) %>%
    slice(1) %>%
    select(model)
}

# Test performance of each function
library(microbenchmark)
microbenchmark(best_acura_1(), best_acura_2(), best_acura_3(), times = 1000)
