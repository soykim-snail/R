# [ leaflet 지도 실습(1) ] 
# 
# 다음과 같이 나의 집을 leafelt 으로 그려 본다.소스는 myhome_leaflet.R 로 그려진 결과는 mymap.html 로 제출한다.

install.packages("htmlwidgets")

library(dplyr)
library(ggmap)
library(ggplot2)
library(leaflet)
register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

home <-  geocode("송파대로 567")

msg <- '<strong>달팽이의 집</strong><hr>달팽이 가족이 사는 곳'
home_map <- leaflet() %>% 
  setView(lng = home$lon, lat = home$lat, zoom = 16) %>% 
  addTiles() %>% 
  addCircles(lng = home$lon, lat = home$lat, color = "red", popup = msg)


# [ 그려진 leaflet 지도를 저장하기 ]

library(htmlwidgets)
saveWidget(home_map, file="mymap.html")

