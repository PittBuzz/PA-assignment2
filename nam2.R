

library(raster) 
library(ggmap) 
library(leaflet)

nam65 <- read.csv("thor_vietnam_65_clean.csv", stringsAsFactors = FALSE)
#vnmap <- qmap(location = "Vietnam", zoom = 6)

strike <- dplyr::filter(nam65, MFUNC_DESC == "STRIKE")

#vnmap + 
  #geom_point(data = strike, aes(x = TGTLONDDD_DDD_WGS84, y = TGTLATDD_DDD_WGS84, 
                                color = MILSERVICE))

b57 <- dplyr::filter(strike, VALID_AIRCRAFT_ROOT == "B-57")

leaflet() %>% 
  setView(lng = 107, lat = 17, zoom = 6) %>% 
  addProviderTiles("Esri.WorldStreetMap") %>% 
  addCircleMarkers(data = b57, lng = ~TGTLONDDD_DDD_WGS84, lat = ~TGTLATDD_DDD_WGS84, 
                   radius = 2, popup = paste(b57$TGTTYPE,", ", b57$OPERATIONSUPPORTED))

strike_af <- dplyr::filter(strike, MILSERVICE == "USAF") 
strike_mc <- dplyr::filter(strike, MILSERVICE == "USMC") 
strike_nvy <- dplyr::filter(strike, MILSERVICE == "USN") 
strike_vn <- dplyr::filter(strike, MILSERVICE == "VNAF")

leaflet() %>% 
  setView(lng = 107, lat = 17, zoom = 6) %>% 
  addProviderTiles("Esri.WorldTopoMap") %>% 
  addCircleMarkers(data = strike_af, lng = ~TGTLONDDD_DDD_WGS84, lat = ~TGTLATDD_DDD_WGS84, 
                   radius = 2, group = "USAF", color = "blue") %>% 
  addCircleMarkers(data = strike_mc, lng = ~TGTLONDDD_DDD_WGS84, lat = ~TGTLATDD_DDD_WGS84, 
                   radius = 2, group = "USMC", color = "red") %>% 
  addCircleMarkers(data = strike_nvy, lng = ~TGTLONDDD_DDD_WGS84, lat = ~TGTLATDD_DDD_WGS84, 
                   radius = 2, group = "USN", color = "orange") %>% 
  addCircleMarkers(data = strike_vn, lng = ~TGTLONDDD_DDD_WGS84, lat = ~TGTLATDD_DDD_WGS84, 
                   radius = 2, group = "VNAF", color = "green") %>% 
addLayersControl(overlayGroups = c("USAF","USMC","USN","VNAF")) %>% 
  addLegend( values = strike$MILSERVICE)
