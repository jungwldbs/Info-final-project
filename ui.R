library(shiny)
library(plotly)

shinyUI(navbarPage("Menu",
                   tabPanel("Not Married by Gender",
                            titlePanel("Not Married by Gender"),
                            sidebarPanel(
                              radioButtons("age_range", label = h4("Choose an Age Group"),
                                           choices = list("25-34" = "all_2534",
                                                          "35-44" = "all_3544", 
                                                          "45-54" = "all_4554"),
                                           selected = "all_2534")
                            ),
                            tabPanel("", 
                                     fluidRow(
                                       column(4, includeMarkdown("detail/explain_gender.md"))
                                     )
                            ),
                            mainPanel(
                              plotlyOutput("male_vs_female")
                            )
                   ),
                   
                   tabPanel("Marriage Rate by Region",
                            titlePanel("Percentage of people married regional data"),
                            sidebarPanel(
                              selectInput("interest_year", label = h3("Select year"),
                                          choices = list("1960", "1970", "1980", "1990", 
                                                         "2000", "2010", "2012"),
                                          selected = "1960")
                            ),
                            fluidRow(
                              column(4, includeMarkdown("detail/explain_map.md"))
                            ),
                            mainPanel(
                              plotlyOutput("married")
                            )
                   ),
                   
                   tabPanel("Divorce by Factors", 
                            titlePanel("Divorce by Factors"),
                            sidebarPanel(
                              sliderInput("year", "Year", min = 2000, max = 2012, 
                                          value = 1, sep = "")
                            ),
                            mainPanel(
                              plotlyOutput("education")
                            )
                   ),
                   
                   tabPanel("Age vs. Divorce",
                            titlePanel("Age vs Divorce"),
                            sidebarPanel(
                              radioButtons("age", label = h4("Choose an Age Group"),
                                           choices = list("35-44" = "all_3544", "45-54" = "all_4554"),
                                           selected = "all_3544")
                            ),
                            fluidRow(
                              column(4, includeMarkdown("detail/explain_age_divorce.md"))
                            ),
                            mainPanel(
                              plotlyOutput("age_vs_divorce")
                            )
                   )

                   
))
