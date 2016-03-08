


library(plotly)
library(dplyr)

pie_chart <- function(data, year_1, cat){

  cat(data, year_1)
  
}

education <- function(data, year_1){
  education <- data %>% select(year, HS_3544, SC_3544, 
                               BAp_3544, BAo_3544, GD_3544) %>% filter(year == year_1)
  
  percentages <- as.numeric(education[1,])[2:6]
  
  ds <- data.frame(labels = c("High School", "Some College", "Bachelors or more", "Bachelors, no Grad", "Graduate"),
                   values = percentages)
  
  plot_ly(ds, labels = labels, values = values, type = "pie") %>% 
    layout(title = paste("Divorces and Education in", year_1))
}




