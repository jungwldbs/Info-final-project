library(shiny)
shinyUI(fluidPage(
  
  # UI title
  titlePanel("Age vs Divorce"),
  
  sidebarPanel(
    radioButtons("age", label = h4("Choose an Age Group"),
                 choices = list("35-44" = "all_3544", "45-54" = "all_4554"),
                 selected = "all_3544")
  ),
  # Render plot
  mainPanel(
    plotlyOutput("age_vs_divorce")
  )
))
