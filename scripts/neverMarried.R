library(dplyr)
library(plotly)

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


lats <- c("44.21", "37.43", "42.00", "33.00", "39.50", "37.00")
lngs <- c("-70.31", "-78.66", "-93.00", "90.00", "-111.50", "-120.00")

# Marriage2534 <-  cbind(Marriage2534, lat = lats, lng = lngs)
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

data <- Marriage2534 %>% select(Region, `1960`, code)

# create sets of hovering texts on map                    
data$hover <- with(data, paste(Region, '<br>', 
                               'Never married:', `1960`, '%'))
                          



# marker styling, set its size, opacity and shape
l <- list(color = toRGB("white"), width = 1)

# geo styling, get usa map and set colors of lands and its borderlines
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white'),
  # subunitcolor = toRGB("gray50"),
  countrycolor = toRGB("gray90"),
  countrywidth = 0.5
  # subunitwidth = 0.8
)

plot_ly(data, z = `1960`, locations = code, color = `1960`, 
        colors = 'Purples', type = 'choropleth', locationmode = 'USA-states', 
        marker = list(line = l), text = hover) %>%
  layout(title = '1960 never married', geo = g)

