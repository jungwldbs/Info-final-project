# Load plotly library
library(plotly)

# Creates the function that will take in an age parameter to make a graph
divorce_vs_age_graph <- function(age) {
  
  # Reads the csv file
  divorce_data <- read.csv("data/divorce.csv")
  
  # Creates a line graph based on age and divorce rate over time
  p <- plot_ly(divorce_data,
             x = year,
             y = eval(parse(text = age)) * 100,
             type = "markers",
             color = year
             ) %>% 
    
  # Adds the title and renames the yaxis
  layout(title = "Age Group Divorce rate from 1960-2012",
         yaxis = list(title = "Divorce Percentage")) %>%
    return()
}


