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

# create sets of hovering texts on map                    
Marriage2534$hover <- with(Marriage2534,
                          paste(Region, '<br>'))

data <- Marriage2534 %>% select(Region, `1960`, lat, lng)

# marker styling, set its size, opacity and shape
m <- list(size = 50, opacity = 1, symbol = 'circle')

# geo styling, get usa map and set colors of lands and its borderlines
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB("gray95"),
  subunitcolor = toRGB("gray50"),
  countrycolor = toRGB("gray49"),
  countrywidth = 0.5,
  subunitwidth = 0.8
)

plot_ly(Marriage2534, lat = lat, lon = lng, color = `1960`, 
        colors = 'Reds', type = 'choropleth', locationmode = 'USA-states', 
        mode = 'markers', marker = m) %>%
  layout(title = '1960 never married', geo = g)
