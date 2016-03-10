library(dplyr)

# Create function to return data frame of certain age group of people
# of currently marries(instead of never married)
# Add list of states per each region 
married_data <- function(both_sexes) {
  
  # select column that represents certain age group(25 to 34)
  Marriage2534 <- select(both_sexes, year, ends_with("2534"))
  
  # change percentage of people never married into currently married(1-n)
  Marriage2534 <- Marriage2534 %>% mutate_each(funs(.-1), -year) %>%
    mutate_each(funs(.*-1), -year)
  
  # create function to round decimal number info more readable double number
  round_col <- function(df, digits) {
    df <- df %>% mutate_each(funs(.*100), -year) %>% 
      mutate_each(funs(round(.,digits)), -year) 
  }
  
  # round up each column into a form of more readable percentage value
  Marriage2534 <- round_col(Marriage2534, 2)
  
  # switch column and row
  Marriage2534 <- select(Marriage2534, year, NE_2534:Pacific_2534) %>% t()
  
  # set year as column names
  colnames(Marriage2534) = Marriage2534[1, ]
  Marriage2534 = Marriage2534[-1, ]
  
  # change row names into more readable names of regions
  row.names(Marriage2534) <- c("New England", "Mid-Atlantic", "Midwest", 
                               "South", "Mountain", "Pacific")
  
  # add row of regions
  Marriage2534 <- as.data.frame(Marriage2534)
  Marriage2534 <- add_rownames(Marriage2534, "Region")
  
  # add frequency column composed of number of states in each region
  Marriage2534 <- mutate(Marriage2534, numStates = c(6, 6, 13, 15, 6, 5)) %>%
    as.data.frame()
  
  # duplicate each regional data times number of states in freq column
  Marriage2534 <- Marriage2534[rep(row.names(Marriage2534), 
                                   Marriage2534$numStates), 1:19]
  
  # creates list of states per each region
  ne <- c('ME', 'VT', 'NH', 'MA', 'RI', 'CT')
  ma <- c('DC', 'DE', 'MD','NJ', 'NY', 'PA')
  mwest <- c('IL', 'IN', 'MI', 'OH', 'WI', 'IA',
             'KS', 'MN', 'MO', 'NE', 'ND', 'OK', 'SD')
  s <- c('AL', 'AR', 'FL', 'GA', 'KY', 'LA', 'MS', 'NC', 'SC', 'TN', 'VA', 
         'WV', 'AZ', 'NM', 'TX')
  mt <- c('CO', 'ID', 'MT', 'NV', 'UT', 'WY')
  pacific <- c('AK', 'CA', 'HI', 'OR', 'WA')
  
  # add area code and returns data frame 
  Marriage2534 <- mutate(Marriage2534, code = c(ne, ma, mwest, s, mt, pacific)) %>%
    as.data.frame() %>%
    return()
}