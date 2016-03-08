library(plotly)
library(dplyr)

divorce_vs_age_graph <- function(age) {
  divorce_data <- read.csv("data/divorce.csv")
  p <- plot_ly(divorce_data,
             x = year,
             y = eval(parse(text = age)),
             type = "markers",
             color = year
             ) %>% 
  layout(title = "Age Group Divorce rate from 1960 - 2012") %>%
    return()
}


