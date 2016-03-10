library(shiny)
shinyUI(navbarPage("Info",
                   tabPanel("linegraph",
                            titlePanel("Age vs Divorce"),
  
                            sidebarPanel(
                              radioButtons("age", label = h4("Choose an Age Group"),
                                           choices = list("35-44" = "all_3544", "45-54" = "all_4554"),
                                           selected = "all_3544")
                            ),
                            mainPanel(
                              plotlyOutput("age_vs_divorce")
                            )
                   ),
                   
                   tabPanel("PieChart", 
                            titlePanel("Divorce vs Education"),
                            sidebarPanel(
                              sliderInput("year", "Year", min = 2000, max = 2012, 
                                          value = 1, sep = "")
                            ),
                            mainPanel(
                              plotlyOutput("education")
                            )
                   ),
                   
                   tabPanel("map",
                            titlePanel("Percentage of people married regional data"),
                            sidebarPanel(
                              selectInput("interest_year", label = h3("Select year"),
                                          choices = list("1960", "1970", "1980", "1990", 
                                                         "2000", "2010", "2012"),
                                          selected = "1960")
                            ),
                            mainPanel(
                              plotlyOutput("married")
                            )
                   )
  
))
