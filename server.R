library(shiny)
source("scripts/divorce_vs_Age.R")
source("scripts/divorce-education.R")
divorce_data <- read.csv("data/divorce.csv")
shinyServer(function(input, output) {
  
  output$age_vs_divorce <- renderPlotly({
    divorce_vs_age_graph(input$age)
  })
  output$education <- renderPlotly({
    pie_chart(divorce_data, input$year, education)
  })
})

