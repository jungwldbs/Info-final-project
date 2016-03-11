library(shiny)
library(plotly)
# install.packages("shinythemes")
library(shinythemes)

# Shiny UI
shinyUI(navbarPage("Menu",
                   theme = shinytheme("Flatly"),
                   # Tabs for seperate graphs
                   tabPanel("General",
                            titlePanel("General Information"),
                            mainPanel(
                              # includeMarkdown(" ")
                            )
                   ),
                   tabPanel("Not Married by Gender",
                            
                            # Page title
                            titlePanel("Not Married by Gender"),
                            
                            # Shiny widget, controls age group of interest
                            # Adds explanation
                            sidebarPanel(
                              radioButtons("age_range", label = h4("Choose an Age Group"),
                                           choices = list("25-34" = "all_2534",
                                                          "35-44" = "all_3544", 
                                                          "45-54" = "all_4554"),
                                           selected = "all_2534"),
                              includeMarkdown("detail/explain_gender.md")
                            ),
                            
                            # Render male and female marriage rate line graph
                            mainPanel(
                              plotlyOutput("male_vs_female")
                            )
                   ),
                   
                   tabPanel("Marriage Rate by Region",
                            
                            # Page title
                            titlePanel("Percentage of people married: Regional data"),
                            
                            # Shiny widget, controls year of interest
                            # Includes map explanation
                            sidebarPanel(
                              selectInput("interest_year", label = h3("Select year"),
                                          choices = list("1960", "1970", "1980", "1990", 
                                                         "2000", "2010", "2012"),
                                          selected = "1960"),
                              includeMarkdown("detail/explain_map.md")
                            ),
                            
                            # Render marriage rate regional map
                            mainPanel(
                              plotlyOutput("married")
                            )
                   ),

                   
                   tabPanel("Divorce by Factors", 
                            
                            # Page title
                            titlePanel("Divorce by Factors"),
                            
                            # Shiny widget, controls year, category(education, wealth),
                            # and age of interest
                            # Includes map explanation
                            sidebarPanel(
                              sliderInput("year", "Year", min = 2000, max = 2012, 
                                          value = 1, sep = ""),
                              radioButtons("cat", label = h3("Category"),
                                           choices = list("Education" = 'education', "Wealth" = 'wealth'), 
                                           selected = 'wealth'),
                              radioButtons("age_group", label = h3("Age Group"),
                                           choices = list("35-44 years old" = "3544", "45-54 years old" = "4554"), 
                                           selected = '3544')
                              
                            ),
                            
                            # Render divorce rate pie chart by factors
                            mainPanel(
                              plotlyOutput("divorce")
                            )
                   ),
                   
                   tabPanel("Age vs. Divorce",
                            
                            # Page title 
                            titlePanel("Age vs Divorce"),
                            
                            # Shiny widget, controls age group of interest
                            # Includes graph explanation
                            sidebarPanel(
                              radioButtons("age", label = h4("Choose an Age Group"),
                                           choices = list("35-44" = "all_3544", "45-54" = "all_4554"),
                                           selected = "all_3544"),
                              includeMarkdown("detail/explain_age_divorce.md")
                            ),
                            
                            # Render divorce rate by age group
                            mainPanel(
                              plotlyOutput("age_vs_divorce")
                            )
                   )
))
