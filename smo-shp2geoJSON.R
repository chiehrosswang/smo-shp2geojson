library(rgdal)
library(spdplyr)
library(geojsonio)

# Load shapefile
roads <- readOGR('./Shapefiles/road_status.shp', 'road_status')
summary(roads) #proj4string:[+proj=utm +zone=17 +datum=NAD83 +units=m ...

# Project layer to EPSG:4269 (proj4string:[+proj=longlat +init=epsg:4269 ...
#                             +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0])
roads.latlng <- spTransform(roads, CRS("+proj=longlat +init=epsg:4269"))
summary(roads.latlng)


# Create a layer with active on Florida State 
# Highway System roads (ROAD_STATU == "02")
roads.latlng_02 <- roads.latlng %>%
  filter(ROAD_STATU == "02")
road_status_02 <- geojson_json(roads.latlng_02, digits = 15) # convert shp to GeoJSON
geojson_write(road_status_02, file = "./GeoJSON/road_status_02.geojson", digits = 15) # write file

# Create a layer with active on SHS ("02"), active 
# exclusive ("07"), and active off SHS ("09") roads
roads.latlng_02_07_09 <- roads.latlng %>%
  filter(ROAD_STATU == "02" | 
           ROAD_STATU == "07" | 
           ROAD_STATU == "09")
road_status_02_07_09 <- geojson_json(roads.latlng_02_07_09, digits = 15) # convert shp to GeoJSON
geojson_write(road_status_02_07_09, file = "./GeoJSON/road_status_02_07_09.geojson", digits = 15) # write file
