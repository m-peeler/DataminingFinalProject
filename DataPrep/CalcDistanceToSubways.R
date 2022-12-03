distance <- function(lat1, lon1, lat2, lon2) {
  sqrd <- ((lat2 - lat1) * 69)^2 + ((lon2 - lon1) * 53)^2
  return (sqrd^0.5)
}

library(tidyverse)

calcSubwayDist <- function(listing_link, subways_link) {
  listings <- read_csv(listing_link)
  subways <- read_csv(subways_link)
  
  listings <- listings %>% mutate(dist_from_subway_in_miles = 10000)
  
  for (i in 1:nrow(listings)){
    cur <-  listings[i,]
    lat1 <- cur$latitude
    lon1 <- cur$longitude
    for (j in 1:nrow(subways)){
      lat2 <- subways[j,]$Latitude
      lon2 <- subways[j,]$Longitude
      d <- distance(lat1, lon1, lat2, lon2)
      if (d < cur$dist_from_subway_in_miles) {
        cur$dist_from_subway_in_miles <- d
      }
    }
    listings[i,] <- cur
    if (i %% 1000 == 0) {
      print(i)
    }
  }
  
  write.csv(listings, listing_link)
}

calcAirportDist <- function(listing_link) {
  airports <- read_csv("~/GitHub/DataminingFinalProject/Airport_Data/us-airports.csv")
  airports <- airports %>% filter(type=="large_airport" | type=="medium_airport")
  
  listings <- read_csv(listing_link) %>% mutate(dist_from_airport_in_miles = 10000)
  airports <- airports %>% filter(distance(latitude_deg, longitude_deg, listings[1,]$latitude, listings[1,]$longitude) < 200)
  for (i in 1:nrow(listings)){
    cur <-  listings[i,]
    lat1 <- cur$latitude
    lon1 <- cur$longitude
    for (j in 1:nrow(airports)){
      lat2 <- airports[j,]$latitude_deg
      lon2 <- airports[j,]$longitude_deg
      d <- distance(lat1, lon1, lat2, lon2)
      if (d < cur$dist_from_airport_in_miles) {
        cur$dist_from_airport_in_miles <- d
      }
    }
    listings[i,] <- cur
    if (i %% 1000 == 0) {
      print(i)
    }
  }
  write.csv(listings, listing_link)
}


addCityCenter <- function(listings_file, centerLoc) {
  listings <- read_csv(listings_file)
  listings <- listings %>% mutate(dist_from_city_center = 1000)
  for (i in 1:nrow(listings)) {
    cur <- listings[i,]
    cur$dist_from_city_center <- distance(cur$latitude, cur$longitude, centerLoc[1], centerLoc[2])
    listings[i,] <- cur
    if (i %% 1000 == 0) {
      print(i)
    }
  }
  write.csv(listings, listings_file)
}

calcAllDists <- function(listing_link, subway_link, city_center) {
  calcSubwayDist(listing_link, subway_link)
  calcAirportDist(listing_link)
  addCityCenter(listing_link, city_center)
}

chic_center = c(41.8781, -87.6298)
calcAllDists("~/GitHub/DataminingFinalProject/AirBnb_listings/chicago_listings - full.csv",
             "~/GitHub/DataminingFinalProject/Subway_Locations/chicago_metro_station_coordinates.csv",
             chic_center)

dc_center = c(38.9072, -77.0369)
calcAllDists("~/GitHub/DataminingFinalProject/AirBnb_listings/dc_listings - full.csv",
             "~/GitHub/DataminingFinalProject/Subway_Locations/Metro_Stations_Regional.csv",
             dc_center)

nyc_center = c(40.7580, -73.9855)
calcAirportDist("~/GitHub/DataminingFinalProject/AirBnb_listings/nyc_listings - full.csv")
addCityCenter("~/GitHub/DataminingFinalProject/AirBnb_listings/nyc_listings - full.csv",
              nyc_center)




