##  Intro to Data Analysis in R ##
##  Session 2
##  Tidyverse, Packages, Data Cleaning
##  by Chandler Hall
##
##  2/10/25

################
## Packages  ## 
##############

# FOR DEMO GO TO YOUR TOOLBAR AT THE TOP OF THE SCREEN, CLICK SESSION > RESTART R

setwd("~/Desktop/GitHub/CAP/Intro_to_R/Session 1") # update to path to Session 1 folder from your Desktop

# Run the following line of code
patient_intake_data <- read_csv("patient_intake_data.csv")
# What does the error message say?

# Packages in R are a pre-built set of functions that you can load into your environment to perform new or more complicated functions. As R is an open-source language, users around the world create packages and upload them to the Comprehensive R Archive Network (CRAN), from which you can install packages directly within RStudio for free.

# In the bottom right pane, click on the tab that says "Packages." Here is a list of innate packages loaded directly into your "library" upon every use. No need to mess with those!

# As you install and load packages to your library, you will see this list update. You can also attach or detach packages from your library at any point in a session by clicking the box on the left side of the list.

# Let's install the readr package which is used to load CSV and similar files into your R environment. Run the following line of code. Ignore any prompt about restarting R for now.

install.packages('readr')

# Readr is installed, but not loaded into our library for the current session. NOTE: You only need to INSTALL packages once, but will need to LOAD packages into your library each time you start a new session.

# Now let's load the readr package for our current R session. Run the following line of code.

library(readr)

# Notice, now that readr is install, R recognizes it as an object and you don't put readr in quotes.

# Now let's run the first line of code again....
patient_intake_data <- read_csv("patient_intake_data.csv")
# Success!


################
## Tidyverse ## 
##############

# One of the almost universally used packages in R is called the TIDYVERSE. In fact, it's actually a bunch of commonly used packages rolled up into one. Let's install it:
install.packages('tidyverse')

# Remember, it's not actively being used in this R session until we load it...
library(tidyverse) 

# Tidyverse is particularly useful for working with 2 dimensional data or dataframe-like structures.

## NOTE: The tidyverse actually uses something called tibbles, a different class of data frame. For our purposes, data frames and tibbles are nearly identical, and I will be referring to them both as dataframes.

# The biggest difference of using Tidyverse is the new syntax it introduces to string operations together using something called a "pipe operator," or just "pipe" for short, which looks looks '%>%'. This comes from a package called 'dplyr' and can be referred to as dplyr syntax.

# This is the syntax we would have used previously to get the first 20 rows and 2 columns from our existing dataframe
selected_df <- patient_intake_data[1:20,colnames(patient_intake_data) == "City" | colnames(patient_intake_data) == "Age"]

print(selected_df)

# This will yield the same result, but is now translated into dplyr syntax
selected_df <- patient_intake_data %>%
  select(City, Age) %>%
  slice(1:20)

selected_df%>%
  print()

# Which syntax do you prefer? Which makes more intuitive sense of what you are trying to accomplish?

####################################

# So what is the pipe doing?

# Every function in the tidyverse takes a dataframe object or vector as its first 'argument' (or function input).
# for example:
boston_df <- filter(patient_intake_data, City == "Boston") # this function would filter the patient_intake_data to only with Boston as the city
print(boston_df)

# With the pipe operator, the data you are using as your first argument become implicit. This way, it is easier to string together commands on the same dataset. For example if I wanted to filter to only Boston patients, then filter to only patients with an income below $45k, then arrange the data into descending order by income....
dallas_df <- patient_intake_data %>%
  filter(City == "Dallas") %>%
  filter(Income < 45000)%>%
  arrange(-Income)

#############################################
## Data Cleaning and Data Transformations ## 
###########################################

### FILTERING ####
# filter() will return a subset of rows based on a logical condition(s)
reduced_df <- patient_intake_data%>%
  filter(City %in% c("Boston", "Austin"))  # return subset of rows if City in list

# Note: '%in%' operator returns TRUE if any value from list is found. You can reverse this by adding a ! in front of the ENTIRE argument, closed by parentheses.

reduced_df <- patient_intake_data%>%
  filter(!(City %in% c("Boston", "Austin")))  # return subset of rows if City is NOT in list

reduced_df <- patient_intake_data%>%
  filter(City %in% c("Boston", "Austin") & Income < 45000) # return subset of rows if City in list AND income less than 45k

reduced_df <- patient_intake_data%>%
  filter(City %in% c("Boston", "Austin"),
         Income < 45000) # using a comma and separating the arguments also accomplishes this

reduced_df <- patient_intake_data%>%
  filter(City == "Boston" | Age >= 38) # return rows if patients in Boston OR their age is greater than or equal to 38

# You can also combine it with operations like max() to get things like the max value for a column:
patient_intake_data %>% filter(Income == max(Income))
patient_intake_data %>% filter(Income == min(Income))

# notice, this didn't use an assignment operator, so this does not save over patient_intake_data

##### Slice #####

# Quick lesson on indexing dataframes!
# Recall from Session 1 when we indexed from a list...
lst <- list(1,1,2,3,5,8,13,21,44,65)

lst[3] # this gives you the third value in the sequence
lst[length(lst)]
# We can also use indexing with a dataframe. However, a dataframe is a 2 dimensional object so indexing requires 2 arguments
# which will look something like this:
dataframe[row, column]

# So...
patient_intake_data[1,2] # returns the value(s) from the first row, second column
patient_intake_data[1,] # returns the value(s) from the first row, all columns
patient_intake_data[,2] # returns value(s) from all rows, second column
patient_intake_data[1:10,1:2] # ':' denotes a range. What does this return?

# Now Slicing
# slice() returns rows based on indices, so this base R operation:
sliced_df <- patient_intake_data[1:15, ]
print(sliced_df)

# becomes:
sliced_df <- patient_intake_data %>%
  slice(1:15)
print(sliced_df)

# Unlike native indexing, slice() lets you provide multiple indices, separated by commas:
sliced_df <- patient_intake_data %>%
  slice(1, 6, 9, c(20:24)) 


##### Select #####

# select() will allow you to select columns from your dataframe. It is very versatile and includes a number of helper functions

reduced_df <- patient_intake_data %>% select(City, Age)  # separate column names by a comma
reduced_df <- patient_intake_data %>% select(c("City", "Age"))  # you can also pass in a vector of names as strings

reduced_df <- patient_intake_data %>%  select(-Illness)  # get all columns except Income

reduced_df <- patient_intake_data %>% select(City:Age)  # get all columns between City and Age

reduced_df <- patient_intake_data %>% select(starts_with("I"))  # all columns that start with 'p'
reduced_df <- patient_intake_data %>% select(contains('e'))  # all columns that contain 'o'

# There are also special variants of select that will return columns based on a logical test. Here we select only columns with numbers:
reduced_df <- patient_intake_data %>% select_if(is.numeric)


##### Arrange #####

# arrange() is used to order data according to its values. You can order by multiple columns. The default is ascending order.

arranged_df <- patient_intake_data %>% arrange(Age)  # ascending by Age
arranged_df <- patient_intake_data %>% arrange(-Age)  # descending by Age

##### Mutate #####

# mutate() is probably the most used tidyverse function. It creates new variables and appends them to your dataframe. It uses the following syntax:

mutate(data, new_variable_name = some_criteria)

# For example, this will create a logical binary (TRUE or FALSE) with the name Adult:
mutated_df <- patient_intake_data %>%
  mutate(poverty_line = Income <= 42000)

# We can also code what the binary result should be using if_else(). In this case, we want it to be a 1 if above the poverty line, 0 if below
mutated_df <- patient_intake_data %>%
  mutate(poverty_line = if_else(Income <= 42000, 1, 0))

# We can also use case_when() to do more complicated mutations. mutate() can be incredibly complex and can create variables using wildly complicated functions.
mutated_df <- patient_intake_data %>%
  mutate(region = case_when(
    City == "Boston" ~ "Northeast",
    City == "Dallas" | City == "Austin" ~ "Southwest",
    City == "Washington D.C." ~ "Mid-atlantic",
    TRUE ~ "Other"
  ))

# Notice this added another column to the existing dataframe saved under mutated_df

# It can also create more than one new variable at the same time:
mutated_df <- patient_intake_data %>%
  mutate(
    bad_knees = Age >= 30,
    masshole = City == "Boston"
  )


##### Group By / Summarize #####

# group_by() and summarize() functions are powerful tools used together to calculate many different summary statistics from a larger dataframe.

# The best way to explain how to use these tools is with an example:
summary_df <- patient_intake_data %>%
  group_by(City) %>% # here, I'm "grouping" patients by their City
  summarize(mean_income = mean(Income)) # Now I'm calculating the mean income of EACH group
summary_df # now let's take a look at the new object we created summary_df
# Notice that this created a new dataframe relating each city group to the mean income of all observations in that group
# Notice also, that by creating a new object (summary_df), we still have the original dataframe unaffected with all our data

# You can also group by multiple variables using a comma to separate
summary_df <- patient_intake_data %>%
  group_by(City, Gender) %>%
  summarize(mean_income = mean(Income))
summary_df # Notice the new structure of summary_df

# You can also create multiple summary variables using a comma to separate new variables
summary_df <- patient_intake_data %>%
  group_by(City) %>%
  summarize(mean_income = mean(Income),
            median_income = median(Income),
            count = n()) # the n() function is a counter. This counts how many observations there are in each group
summary_df # Notice the new structure of summary_df

# And of course can do multiple groups and multiple summaries together
summary_df <- patient_intake_data %>%
  group_by(City, Gender) %>%
  summarize(mean_income = mean(Income),
            median_income = median(Income),
            count = n())
summary_df

# NOTE: The group_by() function does not create a grouped object until you combine it with a summarize() function
summary_df <- patient_intake_data %>%
  group_by(City, Gender) # This just returns the dataframe as it was


###### TASKS ##########




