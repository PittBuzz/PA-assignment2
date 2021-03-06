---
title: "Vietnam Airstrikes"
author: "J. Voltz"
date: "September 11, 2018"
output: html_document
---
This is a map of air campaigns during the Vietnam War
```{r}
library(raster) 
library(ggmap) 
library(leaflet)

setwd("C:/Users/Jack's PC/Desktop")
nam65 <- read.csv("thor_vietnam_65_clean.csv", stringsAsFactors = FALSE)
```
## creating the map

```{r}
strike <- dplyr::filter(nam65, MFUNC_DESC == "STRIKE")

b57 <- dplyr::filter(strike, VALID_AIRCRAFT_ROOT == "B-57")
```

## Leaflet Product


```{r}
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
addLayersControl(overlayGroups = c("USAF","USMC","USN","VNAF")) 

```

