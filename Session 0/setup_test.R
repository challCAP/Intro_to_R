## Session 0 Setup Check ##

install.packages('tidyverse')
library(tidyverse)


list_to_sum <- c(1,2,3,4,5,6,7,8,1000)

sum <- list_to_sum%>%
  sum()

print(sum)
