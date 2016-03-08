library(shiny)
source("scripts/divorce_vs_Age.R")

shinyServer(function(input, output) {
  
  output$age_vs_divorce <- renderPlotly({
    #divorce_data <- read.csv("data/divorce.csv")
    #p <- plot_ly(divorce_data,
    #             x = year,
    #             y = eval(parse(text = input$age)),
    #             type = "markers"
    #) %>% 
    #  layout(title = "Age Group Divorce rate from 1960 - 2012")
    divorce_vs_age_graph(input$age)
  })
})

