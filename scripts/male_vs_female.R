# Load plotly library
library(plotly)

# Creates the function that will take in an age parameter to make a graph
male_female_graph <- function(age_range) {
  
  # Reads the csv files
  male_data <- read.csv("data/men.csv")
  female_data <- read.csv("data/women.csv")
  
  # Creates a line graph based on age and percent not married for men
  male_graph <- plot_ly(male_data,
                  x = year,
                  y = eval(parse(text = age_range)) * 100,
                  type = "markers",
                  name = "Males"
                ) 
  
  # Creates a line graph based on age and percent not married for women
  female_graph <- add_trace(female_data,
                    x = year,
                    y = eval(parse(text = age_range)) * 100,
                    type = "markers",
                    name = "Females"
                  ) %>%
  
    # Adds the title and renames the yaxis
    layout(title = "Percent of Males and Females Not Married in 1960-2012",
           yaxis = list(title = "Percent Not Married")) %>%
    return()
}
