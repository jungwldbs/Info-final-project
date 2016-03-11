library(shiny)
library(plotly)
source("scripts/divorce_vs_Age.R")
source("scripts/divorce-education.R")
source("scripts/regional_married.R")
source("scripts/male_vs_female.R")
source("scripts/ethnicity_graph.R")

divorce_data <- read.csv("data/divorce.csv")
shinyServer(function(input, output) {
  
  # Allows user to find divorve rate based on age group
  output$age_vs_divorce <- renderPlotly({
    divorce_vs_age_graph(input$age)
  })
  
  # Allows user to find divorce rate based on year, age group
  output$divorce <- renderPlotly({
    cat <- get(input$cat)
    pie_chart(divorce_data, input$year, cat, input$age_group)
  })
  
  # Allows user to see marriage rate per region based on year
  output$married <- renderPlotly({
    married_state_map(input$interest_year)
  })
  
  # Allows user to find male and female marriage rate based on age group
  output$male_vs_female <- renderPlotly({
    male_female_graph(input$age_range)
  })
  
  # # Allows user to find percent not married by age group and ethnicity
  output$ethnicity_plot <- renderPlotly({
    ethnicity_graph(input$ethnicity, input$age_choice)
  })
})
