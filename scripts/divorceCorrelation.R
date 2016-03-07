library(dplyr)
library(plotly)

both_sexes <- read.csv("~/Desktop/info498/Info-final-project/data/both_sexes.csv")
divorce <- read.csv("~/Desktop/info498/Info-final-project/data/divorce.csv")
men <- read.csv("~/Desktop/info498/Info-final-project/data/men.csv")
women <- read.csv("~/Desktop/info498/Info-final-project/data/women.csv")

# divorce -> percentage of currently divorced
# marriage data -> percentage of people never been married

men2534 <- select(men, year, ends_with("2534"))
women2534 <- select(women, year, ends_with("2534"))
divorce2534 <- select(divorce, year, ends_with("2534"))

round_col <- function(df, digits) {
  df <- df %>% mutate_each(funs(.*100), -year) %>% 
        mutate_each(funs(round(.,digits)), -year) 
}

men2534 <- round_col(men2534, 2)
women2534 <- round_col(women2534, 2)

# New England
NE <- c(44.21, -70.31)
# Mid-Atlantic (coordinates of VA)
MA <- c(37.43, -78.66)
# Midwest (coordinates of Iowa)
Midwest <- c(42.00, -93.00) 
# South (coordinates of Mississippi)
South <- c(33.00, -90.00)
# Mountain West (coordinates of Utah)
Mountain <- c(39.50, -111.50)
# Pacific (coordinates of California)
Pacific <- c(37.00, -120.00)

# what are some factors of long lasting marriage?
# compare divorce rate with education level, economic level
# education level, most likely related to economic level
