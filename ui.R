library(shiny)
library(plotly)
# install.packages("shinythemes")
library(shinythemes)
# Requires markdown
require(markdown)

# Shiny UI
shinyUI(navbarPage(
  "Menu",
  theme = shinytheme("flatly"),
  
  # Tabs for seperate information
  tabPanel("General",
           mainPanel(
             includeMarkdown("README.md")
           )
  ),
  
  # Tabs for seperate graphs
  tabPanel(
    "Marriage",
    tabsetPanel(
      "marriage_related",
      tabPanel(
        "Not Married by Gender",
        
        # Page title
        titlePanel("Not Married by Gender"),
        
        # Shiny widget, controls age group of interest
        # Adds explanation
        sidebarPanel(
          radioButtons(
            "age_range", label = h4("Choose an Age Group"),
            choices = list(
              "25-34" = "all_2534",
              "35-44" = "all_3544",
              "45-54" = "all_4554"
            ),
            selected = "all_2534"
          ),
          includeMarkdown("detail/explain_gender.md")
        ),
        
        # Render male and female marriage rate line graph
        mainPanel(plotlyOutput("male_vs_female"))
      ),
      
      tabPanel(
        "Marriage Rate by Region",
        
        # Page title
        titlePanel("Percentage of people married: Regional data"),
        
        # Shiny widget, controls year of interest
        # Includes map explanation
        sidebarPanel(
          selectInput(
            "interest_year", label = h3("Select year"),
            choices = list("1960", "1970", "1980", "1990",
                           "2000", "2010", "2012"),
            selected = "1960"
          ),
          includeMarkdown("detail/explain_map.md")
        ),
        
        # Render marriage rate regional map
        mainPanel(plotlyOutput("married"))
      ),
      
      tabPanel("Marriage Rate by Ethnicity",
               
               # Page title
               titlePanel("Marriage Rate by Ethnicity and Age"),
               
               # Shiny widget, controls age and ethnicity
               # Includes plot explanation
               sidebarPanel(
                 radioButtons("age_choice", label = h4("Choose an Age Group"),
                              choices = list("25-34" = "2534",
                                             "35-44" = "3544", 
                                             "45-54" = "4554"),
                              selected = "2534"),
                 radioButtons("ethnicity", label = h4("Choose an Ethnicity"),
                              choices = list("White" = "White_",
                                             "Black" = "Black_", 
                                             "Hispanic" = "Hisp_"),
                              selected = "White_"),
               includeMarkdown("detail/explain_ethnicity.md")
               ),
      
               
               # Render marriage rate based on ethnicity plot
               mainPanel(
                 plotlyOutput("ethnicity_plot")
               )
      )
    )
  ),
  
  tabPanel(
    "Divorce",
    tabsetPanel(
      "divorce_related",
      tabPanel(
        "Divorce by Factors",
        
        # Page title
        titlePanel("Divorce by Factors"),
        
        # Shiny widget, controls year, category(education, wealth),
        # and age of interest
        # Includes map explanation
        sidebarPanel(
          sliderInput(
            "year", "Year", min = 2000, max = 2012,
            value = 1, sep = ""
          ),
          radioButtons(
            "cat", label = h3("Category"),
            choices = list("Education" = 'education', "Wealth" = 'wealth'),
            selected = 'wealth'
          ),
          radioButtons(
            "age_group", label = h3("Age Group"),
            choices = list("35-44 years old" = "3544", "45-54 years old" = "4554"),
            selected = '3544'
          ),
          includeMarkdown("detail/explain_divorce.md")
        ),
        
        # Render divorce rate pie chart by factors
        mainPanel(plotlyOutput("divorce"))
      ),
      
      tabPanel(
        "Age vs. Divorce",
        
        # Page title
        titlePanel("Age vs Divorce"),
        
        # Shiny widget, controls age group of interest
        # Includes graph explanation
        sidebarPanel(
          radioButtons(
            "age", label = h4("Choose an Age Group"),
            choices = list("35-44" = "all_3544", "45-54" = "all_4554"),
            selected = "all_3544"
          ),
          includeMarkdown("detail/explain_age_divorce.md")
        ),
        
        # Render divorce rate by age group
        mainPanel(plotlyOutput("age_vs_divorce"))
      )
    )
  )
)
)

