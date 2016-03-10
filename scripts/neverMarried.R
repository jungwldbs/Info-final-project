library(dplyr)
library(plotly)

never_married_state_map <- function(interest_year) {
  both_sexes <- read.csv("data/both_sexes.csv", stringsAsFactors = FALSE)
  
  Marriage2534 <- select(both_sexes, year, ends_with("2534")) 
  
  round_col <- function(df, digits) {
    df <- df %>% mutate_each(funs(.*100), -year) %>% 
      mutate_each(funs(round(.,digits)), -year) 
  }
  
  Marriage2534 <- round_col(Marriage2534, 2)
  Marriage2534 <- select(Marriage2534, year, NE_2534:Pacific_2534) %>% t()
  colnames(Marriage2534) = Marriage2534[1, ]
  Marriage2534 = Marriage2534[-1, ]
  
  row.names(Marriage2534) <- c("New England", "Mid-Atlantic", "Midwest", 
                               "South", "Mountain", "Pacific")
  
  Marriage2534 <- as.data.frame(Marriage2534)
  Marriage2534 <- add_rownames(Marriage2534, "Region")
  Marriage2534 <- mutate(Marriage2534, numStates = c(6, 6, 13, 15, 6, 5)) %>%
    as.data.frame()
  Marriage2534 <- Marriage2534[rep(row.names(Marriage2534), 
                                   Marriage2534$numStates), 1:19]
  
  ne <- c('ME', 'VT', 'NH', 'MA', 'RI', 'CT')
  ma <- c('DC', 'DE', 'MD','NJ', 'NY', 'PA')
  mwest <- c('IL', 'IN', 'MI', 'OH', 'WI', 'IA',
             'KS', 'MN', 'MO', 'NE', 'ND', 'OK', 'SD')
  s <- c('AL', 'AR', 'FL', 'GA', 'KY', 'LA', 'MS', 'NC', 'SC', 'TN', 'VA', 
         'WV', 'AZ', 'NM', 'TX')
  mt <- c('CO', 'ID', 'MT', 'NV', 'UT', 'WY')
  pacific <- c('AK', 'CA', 'HI', 'OR', 'WA')
  
  Marriage2534 <- mutate(Marriage2534, code = c(ne, ma, mwest, s, mt, pacific)) %>%
    as.data.frame()
  
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
          list(title = "% Never Married", ticksuffix = '%')) %>%
    layout(title = paste0(interest_year, ' never married'), geo = g) %>%
    return()
  
}