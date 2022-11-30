distance <- function(lat1, lon1, lat2, lon2) {
  sqrd <- ((lat2 - lat1) * 69)^2 + ((lon2 - lon1) * 54.6)^2
  return (sqrd^0.5)
}

library(tidyverse)

nyc_subway <- read_csv("~/GitHub/DataminingFinalProject/Subway_Locations/nyc-subway-stations-clean.csv")
nyc_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/nyc_listings.csv")
nyc_listings <- nyc_listings %>% mutate(dist_from_subway_in_miles = 100000)

for (i in 1:nrow(nyc_listings)){
  cur <-  nyc_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(nyc_subway)){
    lat2 <- nyc_subway[j,]$Latitude
    lon2 <- nyc_subway[j,]$Longitude
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_subway_in_miles) {
      cur$dist_from_subway_in_miles <- d
    }
  }
  nyc_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}

write.csv(nyc_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/nyc_listings.csv")

dc_subway <- read_csv("~/GitHub/DataminingFinalProject/Subway_Locations/Metro_Stations_Regional.csv")
dc_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/dc_listings.csv")
dc_listings <- dc_listings %>% mutate(dist_from_subway_in_miles = 100000)

for (i in 1:nrow(dc_listings)){
  cur <-  dc_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(dc_subway)){
    lat2 <- dc_subway[j,]$Latitude
    lon2 <- dc_subway[j,]$Longitude
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_subway_in_miles) {
      cur$dist_from_subway_in_miles <- d
    }
  }
  dc_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}

write.csv(dc_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/dc_listings.csv")


chic_subway <- read_csv("~/GitHub/DataminingFinalProject/Subway_Locations/chicago_metro_station_coordinates.csv")
chic_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/chicago_listings.csv")
chic_listings <- chic_listings %>% mutate(dist_from_subway_in_miles = 100000)

for (i in 1:nrow(chic_listings)){
  cur <-  chic_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(chic_subway)){
    lat2 <- chic_subway[j,]$Latitude
    lon2 <- chic_subway[j,]$Longitude
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_subway_in_miles) {
      cur$dist_from_subway_in_miles <- d
    }
  }
  chic_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}

write.csv(chic_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/chicago_listings.csv")







airports <- read_csv("~/GitHub/DataminingFinalProject/Airport_Data/us-airports.csv")
airports <- airports %>% filter(type=="large_airport" | type=="medium_airport")

nyc_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/nyc_listings.csv")
nyc_listings <- nyc_listings %>% mutate(dist_from_airport_in_miles = 100000)
airports_nyc <- airports %>% filter(distance(latitude_deg, longitude_deg, nyc_listings[1,]$latitude, nyc_listings[1,]$longitude) < 100)

for (i in 1:nrow(nyc_listings)){
  cur <-  nyc_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(airports_nyc)){
    lat2 <- airports_nyc[j,]$latitude_deg
    lon2 <- airports_nyc[j,]$longitude_deg
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_airport_in_miles) {
      cur$dist_from_airport_in_miles <- d
    }
  }
  nyc_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}

write.csv(nyc_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/nyc_listings.csv")

dc_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/dc_listings.csv")
dc_listings <- dc_listings %>% mutate(dist_from_airport_in_miles = 100000)
airports_dc <- airports %>% filter(distance(latitude_deg, longitude_deg, dc_listings[1,]$latitude, dc_listings[1,]$longitude) < 100)


for (i in 1:nrow(dc_listings)){
  cur <-  dc_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(airports_dc)){
    lat2 <- airports_dc[j,]$latitude_deg
    lon2 <- airports_dc[j,]$longitude_deg
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_airport_in_miles) {
      cur$dist_from_airport_in_miles <- d
    }
  }
  dc_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}

write.csv(dc_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/dc_listings.csv")


chic_listings <- read_csv("~/GitHub/DataminingFinalProject/AirBnb_Listings/chicago_listings.csv")
chic_listings <- chic_listings %>% mutate(dist_from_airport_in_miles = 100000)
airports_chic <- airports %>% filter(distance(latitude_deg, longitude_deg, chic_listings[1,]$latitude, chic_listings[1,]$longitude) < 100)


for (i in 1:nrow(chic_listings)){
  cur <-  chic_listings[i,]
  lat1 <- cur$latitude
  lon1 <- cur$longitude
  for (j in 1:nrow(airports_chic)){
    lat2 <- airports_chic[j,]$latitude_deg
    lon2 <- airports_chic[j,]$longitude_deg
    d <- distance(lat1, lon1, lat2, lon2)
    if (d < cur$dist_from_airport_in_miles) {
      cur$dist_from_airport_in_miles <- d
    }
  }
  chic_listings[i,] <- cur
  if (i %% 1000 == 0) {
    print(i)
  }
}
write.csv(chic_listings, "~/GitHub/DataminingFinalProject/AirBnb_Listings/chicago_listings.csv")


