library(rgdal)
library(spdplyr)
library(geojsonio)

# Load shapefile
roads <- readOGR('./Data/road_status.shp', 'road_status')
summary(roads)

roads.latlng <- spTransform(roads, CRS("+proj=longlat"))
summary(roads.latlng)

# Create a layer with active on Florida State 
# Highway System roads (ROAD_STATU == "02")
roads.latlng_02 <- roads.latlng %>%
  filter(ROAD_STATU == "02")
road_status_02 <- geojson_json(roads.latlng_02)
geojson_write(road_status_02, file = "./Data/road_status_02.geojson")

# Create a layer with active on SHS ("02"), active 
# exclusive ("07"), and active off SHS ("09") roads
roads.latlng_02_07_09 <- roads.latlng %>%
  filter(ROAD_STATU == "02" | 
           ROAD_STATU == "07" | 
           ROAD_STATU == "09")
road_status_02_07_09 <- geojson_json(roads.latlng_02_07_09)
geojson_write(road_status_02_07_09, file = "./Data/road_status_02_07_09.geojson")