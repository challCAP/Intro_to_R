##  Intro to Data Analysis in R ##
##  Session 1
##  Data Types, Data Structures, and R Syntax
##  by Chandler Hall
##
##  11/1/24


# Welcome to world of coding in R for Data Analysis!

################
## R Basics ## 
##############

### Get to know your RStudio ####

# A typical RStudio layout will have four panes:

## SOURCE pane - (top left pane or the one you're reading this in) here is where you will write/edit code

## CONSOLE pane - (bottom left) this shows the actual input/outputs into your computer.
  2+2 # press CMD+Return (CTRL+Enter for PC) on your keyboard at the end of this line to "run" it. Look at how the console updated

## ENVIRONMENT pane - (top right) this shows saved "objects" in your R "session"
  x <- 2+2 # run this line.
  # Notice, the answer didn't appear in the console, but 'x' now appears as a saved value in your environment
  x # now run this line. Because 'x' is a saved object, running it returns its value in the console.

# OUTPUT pane - (bottom right) we will mostly focus on the file and plot tabs, and will show how to use this pane in time

  
###################
## Vocabulary ####
#################

# COMMENT - putting '#' before text makes it a COMMENT, this is text that your interpreter will ignore when running a section of code
# SCRIPT - file type in RStudio interpreter which takes R commands, a new script = a new document
# WORKING DIRECTORY - the folder your script is currently running from (this is used for file pathing)
# OPERATORS - symbols R recognizes to perform specific mathematical, logical, or decision functions
# ASSIGNMENT OPERATOR - '<-' is an operator that assigns values to R objects
# ARGUMENT - Functions have unique arguments. Arguments go inside the parentheses following a function call to specify how the function should execute
  print('argument') # e.g. the argument you give the print function is the text you want it to print
  # arguments can be any data type, refer to a function's documentation to learn all arguments it can take

##################
## DATA TYPES ###
################

# There are three common data types: 

## NUMERIC - Set of all real numbers
value <- 3.14
class(value) # You can always check the data type using class()
  
## CHARACTER – think of this as text. Any value surrounded by ' ' will be coerced to character type, also known as a string
string <- 'this is an example of character data type'
class(string)

## LOGICAL - This is a binary data type with two values: TRUE or FALSE
# NOTE: In R, logical values must always be written this way, aka True does equal TRUE
logical_value <- TRUE
class(logical_value)

# Logical values are used in condition statements
# Sample values
x = 4
y = 3
z = x > y
z # here the value of Z is TRUE because x is greater than y
  
# NOTE: there are three other recognized data types: integers, complex, and raw,
# but you most likely will not encounter these types, so we'll ignore them for now
  
################
## Objects ####
##############

## VALUE - stores single variable which can be any data type
x <- 4 # assigning value of 4 to object 'x'
x
length(x) # the length() function returns a numeric value equal to the number of elements in an object

x <- x + x # can assign the object x a new value using already stored objects
x # notice this has replaced the value of x
  
## VECTOR - stores series of data which are all the same data type
# the c() function means combine, it will combine comma-separated arguments into a vector.
# NOTE: All data points inside c() will be coerced to the same type.

v <- c(1, 2, 3, 4)
class(v)
print(v)
sum(v) # if a vector is numeric, you can perform mathematical functions, like sum
mean(v) # or mean to find the vector's average


v <- c(1, 'two', '3', 4) # what data type will the vector v be?
class(v)
print(v) # notice how even though 1 and 4 are numeric inputs, the entire vector is coerced to characters

## LIST - stores series of data which can be different data types
# to create a list, use the list() function.
lst <- list(1, 2, 3, 4)
print(lst)

lst <- list(1, 'two', '3', 4)
print(lst)

# lists can also contain lists!

lst <- list(1, 'two', '3', 4, list(1,2,3,4))
print(lst)

## DATAFRAME - table-like object that stores 2 dimensional data relating rows with columns
# think excel speadsheet!

# Creating vectors for each column
name <- c("Alice", "Bob", "Charlie", "David")
age <- c(25, 30, 22, 28)
city <- c("New York", "London", "Paris", "Tokyo")

# Creating a dataframe using the data.frame() function
df <- data.frame(Name = name, Age = age, City = city)

# Displaying the dataframe
print(df)

# Click on the arrow next to 'df' in your environment pane,
# you can see the column names, the data type of the column, and some data points
# Now click on df, this should open a tab with your dataframe if you ever want to look at it like a table

# In base R, the '$' sign is used to call a specific vector from a dataframe.
# So....
df$name
# returns only the name column from the dataframe. This will be used a lot as we start to working with dataframes!


###  NOTE: there are other recognized objects, but we're going to focus on these for now #### 

##############################
## Mathematical Operators ###
############################

2 + 2 # addition operator

2 - 2 # subtraction operator

2 * 2 # multiplication operator

2 / 2 # division operator

2 ^ 2  # power operator

# others: https://www.geeksforgeeks.org/r-operators/ 

#################################
## Logic & Logical Operators ###
###############################

TRUE # TRUE
FALSE # FALSE
# note: these have to be in all upper case

# Using logical operators will output TRUE or FALSE
2 == 2 # equals exactly
2 > 1 # greater than
2 >= 1 # greater than or equal to
2 < 1 # less than
2 <= 1 # less than or equal to
2 != 1 # exclamation point is the equivalent of "not", so this logical comparison is: 2 does not equal 1, which is TRUE

TRUE == TRUE
!TRUE == TRUE

# logical values also have mathematical values
TRUE == 1 # TRUE
FALSE == 0 # TRUE
TRUE + TRUE # 2
FALSE + TRUE # 1
TRUE * TRUE + TRUE # ?
TRUE * (TRUE + TRUE) # ?

## Logical operators can be combined using things like & (and), | (or), and xor() (exclusive of). This will combine
#  the logical conditions and output a logical vector that meets all of them, for example:
x <- 5
x == 5 & x > 2  # TRUE, x is both equal to 5 and greater than 2
x > 2 & x < 4  # FALSE, x is greater than 2 but is NOT less than 4
x > 2 | x < 4  # TRUE, x is greater than 2, one condition is met, so TRUE


#############################
## Indexing and Slicing ###
##########################

# Indexing and Slicing is an extremely important concept to managing data and developing functions.
# Like an index in the back of a book, R objects with multiple elements (think vector, lists, dataframes) have an index
# The index is the 'position' of where a specific element is within an object. Positional arguments in R are denoted by square brackets [ ]
# In R, the index starts at 1 (while this may seem intuitive, most languages start at 0)

lst <- list(1,1,2,3,5,8,13,21,44,65)

lst[3] # this gives you the third value in the sequence
lst[length(lst)]

## SWITH TO USING GOOGLE GEMINI ## (WE DO)

## TASKS ## 
# What is the last number in this list?

# What is the second to last value in the list?

# Subset the list to find the value of the elements in the first and third position

# Subset the list so the values in the first and third position are omitted

# Subset the list to repeat the value in the third position 3 times

# get values from positions 1, 10, and 12 to 15



## PROJECT XXX
## Now we switch to project-based learning (YOU DO)
## For this section, participants will be given a list of task with little guidance, they should use the concepts learned and prompting Gemini to complete the tasks

# Run the following code to import our dataset
install.packages('readr')
library(readr)

patient_intake_data <- read_csv("~/Desktop/GitHub/CAP/Intro_to_R/Session 1/patient_intake_data.csv")

# use a code segment to find how many observations are in the dataset?

# use a code segment to find how many columns are in the dataset?

# As is, use a code segment to find the first city that shows up in the dataset (row 1, column 2)

# use a code segment to find the mean income of all observations in the dataset, find the median, and standard deviation

# use a code segment to find the mean income of only patients from Boston in the dataset, find the median, and standard deviation

