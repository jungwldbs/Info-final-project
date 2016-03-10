library(shiny)
library(plotly)
source("scripts/divorce_vs_Age.R")
source("scripts/divorce-education.R")
source("scripts/regional_married.R")
source("scripts/male_vs_female.R")

divorce_data <- read.csv("data/divorce.csv")
shinyServer(function(input, output) {
  
  output$age_vs_divorce <- renderPlotly({
    divorce_vs_age_graph(input$age)
  })
  output$education <- renderPlotly({
    pie_chart(divorce_data, input$year, education)
  })
  output$married <- renderPlotly({
    married_state_map(input$interest_year)
  })
  output$male_vs_female <- renderPlotly({
    male_female_graph(input$age_range)
  })
})
