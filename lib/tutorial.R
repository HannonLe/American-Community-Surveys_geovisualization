##### tutorial stuff #####

library(readr) # increase reading speed
devtools::session_info('readr')
read_csv(readr_example("challenge.csv"))

if(!require(DT)) install.packages("DT")
library(DT)
datatable(iris) # interactive data charts

library(leaflet)
m = leaflet() %>% addTiles()
m  # a map with the default OSM tile layer
# set bounds
m %>% fitBounds(0, 40, 10, 60)
# move the center to Snedecor Hall
m = m %>% setView(-93.65, 42.0285, zoom = 17)
m

library(choroplethr)
library(choroplethrMaps)

?df_pop_state
data(df_pop_state)

?state_choropleth # static maps
state_choropleth(df_pop_state) # uses lower case state name as index

data(df_pop_county)
county_choropleth(df_pop_county,
                  title       = "Population",
                  legend      = "Population",
                  num_colors  = 1,
                  state_zoom  = "new york") # uses 5 digit fips code as index


if(!require(data.table)) install.packages("data.table")
library(data.table)

?fread # omg fread is so freaking fast

if(!require(plotly)) install.packages("plotly")
library(plotly)

# plotly state maps https://plot.ly/r/choropleth-maps/ interactive maps

df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2011_us_ag_exports.csv")
df$hover <- with(df, paste(state, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                           "Fruits", total.fruits, "Veggies", total.veggies,
                           "<br>", "Wheat", wheat, "Corn", corn))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)

plot_ly(df, z = total.exports, text = hover, locations = code, type = 'choropleth',
        locationmode = 'USA-states', color = total.exports, colors = 'Purples',
        marker = list(line = l), colorbar = list(title = "Millions USD")) %>%
  layout(title = '2011 US Agriculture Exports by State<br>(Hover for breakdown)', geo = g)

# plotly county maps?
plot_ly(loacationmode = 'USA-county',type='choropleth') %>%
  layout(geo = list(scope='usa'))


