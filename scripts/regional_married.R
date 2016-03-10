library(dplyr)
library(plotly)

married_state_map <- function(interest_year) {
  both_sexes <- read.csv("data/both_sexes.csv", stringsAsFactors = FALSE)
  source("scripts/married_data.R")

  Marriage2534 <- married_data(both_sexes)
  
  data <- Marriage2534 %>% select(Region, contains(interest_year), code)
  
  # create sets of hovering texts on map                    
  data$hover <- with(data, paste(Region, '<br>', 
                                 'Never married:', eval(parse(text = paste0('`', interest_year, '`')))
                                 , '%'))
  
  
  # marker styling, set its size, opacity and shape
  l <- list(color = toRGB("gray75"), width = 0.5)
  
  # geo styling, get usa map and set colors of lands and its borderlines
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('gray75'),
    # subunitcolor = toRGB("gray50"),
    countrycolor = toRGB("gray90"),
    countrywidth = 0.5
    # subunitwidth = 0.8
  )
  
  plot_ly(data, z = eval(parse(text = paste0('`', interest_year, '`'))), 
          locations = code, color = eval(parse(text = paste0('`', interest_year, '`'))), 
          colors = 'Blues', type = 'choropleth', locationmode = 'USA-states', 
          marker = list(line = l), text = hover, colorbar = 
          list(title = "% Married", ticksuffix = '%')) %>%
    layout(title = paste0(interest_year, ' percentage of married population'), geo = g) %>%
    return()
}