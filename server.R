library(shiny)
source("scripts/divorce_vs_Age.R")
source("scripts/divorce-education.R")
source("scripts/neverMarried.R")

divorce_data <- read.csv("data/divorce.csv")
shinyServer(function(input, output) {
  
  output$age_vs_divorce <- renderPlotly({
    divorce_vs_age_graph(input$age)
  })
  output$education <- renderPlotly({
    pie_chart(divorce_data, input$year, education)
  })
  output$never_married <- renderPlotly({
    never_married_state_map(input$interest_year)
  })
})


