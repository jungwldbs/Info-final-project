library(plotly)
library(dplyr)

pie_chart <- function(data, year_1, cat, age){
  cat(data, year_1, age)
}

education <- function(data, year_1, age){
  education <- data %>% select(year, eval(parse(text = paste0("HS_", age))), 
                                     eval(parse(text = paste0("SC_", age))),
                                     eval(parse(text = paste0("BAp_", age))), 
                                     eval(parse(text = paste0("BAo_", age))), 
                                     eval(parse(text = paste0("GD_", age)))) %>% filter(year == year_1)
  
  percentages <- as.numeric(education[1,])[2:6]
  
  ds <- data.frame(labels = c("High School", "Some College", "Bachelors or more", "Bachelors, no Grad", "Graduate"),
                   values = percentages)
  
  plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = paste("Divorces and Education in", year_1))
}

wealth <- function(data, year_1, age){
  wealth <- data %>% select(year, eval(parse(text = paste0("poor_", age))), 
                                  eval(parse(text = paste0("mid_", age))), 
                                  eval(parse(text = paste0("rich_", age)))) %>% filter(year == year_1)
  
  percentages <- as.numeric(wealth[1,])[2:4]
  
  ds <- data.frame(labels = c("Poor", "Middle", "Rich"),
                   values = percentages)
  
  plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = paste("Divorces and Wealth in", year_1))
}




