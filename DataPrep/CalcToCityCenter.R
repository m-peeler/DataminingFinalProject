library(tidyverse)

distance <- function(lat1, lon1, lat2, lon2) {
  sqrd <- ((lat2 - lat1) * 69)^2 + ((lon2 - lon1) * 54.6)^2
  return (sqrd^0.5)
}

addCityCenter <- function(listings_file, centerLoc) {
  listings <- read_csv(listings_file)
  listings <- listings %>% mutate(dist_from_city_center = 1000)
  for (i in 1:nrow(listings)) {
    cur <- listings[i,]
    cur$dist_from_city_center <- distance(cur$latitude, cur$longitude, centerLoc[1], centerLoc[2])
    listings[i,] <- cur
  }
  write.csv(listings, listings_file)
}

nyc_center = c(40.7580, -73.9855)
addCityCenter("~/GitHub/DataminingFinalProject/AirBnb_Listings/nyc_listings - cleaned.csv", nyc_center)

dc_center = c(38.9072, -77.0369)
addCityCenter("~/GitHub/DataminingFinalProject/AirBnb_Listings/dc_listings - cleaned.csv", dc_center)

chic_center = c(41.8781, -87.6298)
addCityCenter("~/GitHub/DataminingFinalProject/AirBnb_Listings/chicago_listings - cleaned.csv", chic_center)