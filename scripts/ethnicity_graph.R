# Loads Plotly library
library(plotly)

# Creates the function that will take in an age and ethnicity as a parameter
ethnicity_graph <- function(ethnicity, age){
  
  # Reads in the csv file
  data <- read.csv("data/both_sexes.csv")
  
  # makes a graph based upon the year and ethnicity and age
  make_graph <- plot_ly(data,
                        x = year,
                        y = eval(parse(text = paste0(ethnicity, age))),
                        type = "markers"

  ) %>%
    
    # creates the title and renames yaxis
    layout(title = "Not Married By Ethnicity in 1960-2012",
           yaxis = list(title = "Percent Not Married")) %>%
    return()
}

