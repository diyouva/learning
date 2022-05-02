library(shiny)
library(leaflet)
library(RColorBrewer)
library(tidyverse)
library(raster)
library(sf)
library(sp)
library(scales)
library(ggsn)
library(plotly)
library(dbscan)
library(rgdal)
library(spatialreg)
library(spatial)
library(mapview)
library(dplyr)
library(tidyselect)
library(tidyr)
library(tidyselect)

indo_map <- st_read("gadm36_IDN_1.shp")
indo_map %>% select(GID_1) %>% plot()
class(indo_map)
indo_map[2]
indo_map2 <- indo_map %>% select(NAME_1)
indo_map2
mydata <- readr::read_csv("urutanpas.csv")
data <- readr::read_csv("urutanpass.csv")
gabung <- inner_join(indo_map2, data)
jumlahkomoditaspotensial = c(12,	100,	3,	31,	2,	2,	153,	11,	48,	105,	144,	46,	11,	6,	73,	136,	47,	7,	3,	12,	95,	74,	7,	51,	1,	33,	13,	6,	18,	13,	44,	113,	20)
indo_map2 <- indo_map2 %>% add_column(jumlahkomoditaspotensial)
indo_map2

pal <- colorNumeric(
  palette = "YlGnBu",
  domain = indo_map2$jumlahkomoditaspotensial
)






gambarpeta <- leaflet(indo_map2) %>%
  addTiles() %>% 
  addPolygons(
    color = ~pal(jumlahkomoditaspotensial),
    weight = 2,
    opacity = 1,
    dashArray = "3",
    fillOpacity = 0.7,
    
    
    
    
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    
    
    
    label = paste0(indo_map2$NAME_1, " ", indo_map2$jumlahkomoditaspotensial),
    
    
    
    
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")
    
    
    
    
  ) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~jumlahkomoditaspotensial,
    title = "Jumlah Komoditas Potensial"
  )


gambarpeta
