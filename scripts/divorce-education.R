library(plotly)
library(dplyr)

#displays pie chart given, category, year, and age group for divorce rates
pie_chart <- function(data, year_1, category, age){
  category(data, year_1, age)
}

#display pie chart for level of education and divorce rate
education <- function(data, year_1, age){
  #select relevant education columns from divorce data
  education <- data %>% select(year, eval(parse(text = paste0("HS_", age))), 
                                     eval(parse(text = paste0("SC_", age))),
                                     eval(parse(text = paste0("BAp_", age))), 
                                     eval(parse(text = paste0("BAo_", age))), 
                                     eval(parse(text = paste0("GD_", age)))) %>% filter(year == year_1)
  
  #create vector for divorce rates
  percentages <- as.numeric(education[1,])[2:6]
  
  #set percentages and value to pie chart
  ds <- data.frame(labels = c("High School or less", "Some College", "Bachelors or more", "Bachelors, no Grad", "Graduate"),
                   values = percentages)
  
  #create pie chart
  plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = paste("Divorces and Education in", year_1))
}

#display pie chart for level of education and divorce rate
wealth <- function(data, year_1, age){
  #select relevant wealth columns from divorce data
  wealth <- data %>% select(year, eval(parse(text = paste0("poor_", age))), 
                                  eval(parse(text = paste0("mid_", age))), 
                                  eval(parse(text = paste0("rich_", age)))) %>% filter(year == year_1)
  
  #create divorce rates vector for divorce rates 
  percentages <- as.numeric(wealth[1,])[2:4]
  
  #set percentages and value to pie chart
  ds <- data.frame(labels = c("Poor", "Middle", "Rich"),
                   values = percentages)
  
  #create pie chart
  plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = paste("Divorces and Wealth in", year_1))
}




