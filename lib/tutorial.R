##### tutorial stuff #####

library(readr) # increase reading speed
devtools::session_info('readr')
read_csv(readr_example("challenge.csv"))

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

?state_choropleth
state_choropleth(df_pop_state)

if(!require(data.table)) install.packages("data.table")
library(data.table)

?fread
