### Exercise 3 ###
library(jsonlite)
library(dplyr)

# Read in this police shooting JSON data 
# https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json
data <- fromJSON('https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json')


# Dealing with the `Shots Fired` column
# Creating a new Numeric variable with no space in the name
# Replacing NA values with the mean (that makes sense, right?)
data$shots_fired <- as.numeric(data[,'Shots Fired'])
data <- data %>%
        mutate(shots_fired = ifelse(is.na(shots_fired), mean(shots_fired, na.rm = T), shots_fired))

# Create a bubble map of the data
g <- list(
  scope = 'usa', 
  projection = list(type = 'albers usa'),
  showland = F,
  landcolor = toRGB("gray85"), 
  subunitwidth = 1,
  countrywidth = 0,
  subunitcolor = toRGB("gray85"), 
  countrycolor = toRGB('gray85')
)

# Creates graph of data
plot_ly(data, 
        lon = lng, 
        lat = lat, 
        text = paste('<b>Name:</b>', data[,"Victim Name"], '<br><b>Shots Fired:</b>', data$shots_fired),
        hoverinfo = 'text',
        marker = list(size = 1 + shots_fired/2, opacity = .4, color = 'red'),
        type = 'scattergeo', 
        locationmode = 'USA-states'
) %>%
  layout(title = 'Crowdsourced Police Shootings', geo = g)

### Bonus: create informative hover text ###

### Bonus: Use multiple colors ###
