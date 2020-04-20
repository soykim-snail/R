# [ leaflet 지도 실습(2) ] 
# 
# map7를 잘 분석해 보고 구현하는 실습이다.
# map7 처럼 1인 가구에 대한 정보를 지도에 각 동별로 나눠서 칼라링하여 출력하고자 한다.
# 수업 시간에는 광진구를 출력했는데....
# 
# 구현해야 하는 것은 강남구, 종로구, 관악구(또는 원하는 구) 중에서 하나를 선택해서 출력해 본다.
# 소스는 oneMap.R로 구현하고 출력 결과는 oneMap.html 로 저장하여 제출한다.
# 
# 필요시 http://web-r.org/webrboard/6477 도 참고해 보고
# 4월18일 폴더에 있는 leaflet.pdf 도 참고한다.

rm(list = ls())
install.packages("rgeos")
library(rgeos) 
library(Kormaps)
library(htmlwidgets)

read.csv('data/one.csv') %>% 
  rename("name"="동") %>% 
  filter(구별 == '송파구') -> song_one


# 한글처리
Encoding(names(korpopmap2)) <- 'UTF-8'
Encoding(names(korpopmap3)) <- 'UTF-8'
Encoding(names(korpopmap2@data)) <- 'UTF-8'
Encoding(names(korpopmap3@data)) <- 'UTF-8'
Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'

#송파구의 구코드 출력
song_c <- korpopmap2@data[korpopmap2@data$name == '송파구', c('C행정구역별_읍면동', '행정구역별_읍면동')]
#송파구의 동코드들 출력
pattern <- paste0("^", song_c[[1]])
korpopmap3@data[grep(pattern, korpopmap3@data$C행정구역별_읍면동),
                          c('C행정구역별_읍면동', '행정구역별_읍면동')]


# korpopmap3에서 송파구만 추출
## data 에서 송파구 추출
k3 <- korpopmap3
k3@data[grep(pattern, korpopmap3@data$C행정구역별_읍면동), ]
  ## 1인가구 데이터와 머지
merge(k3@data, song_one, by.x = "name", sort = FALSE) -> k3@data

## polygons에서 송파구 추출
k3@polygons[grep(pattern, korpopmap3@data$C행정구역별_읍면동)] -> k3@polygons

# 계층별 지도 그리기
View(k3)
mypalette <- colorNumeric('PuRd', domain = k3@data$X1인가구)
mypopup <- paste0(k3@data$name,'<br> 1인가구: ',k3@data$X1인가구)
k3@polygons[k3@data$name == '가락1동'] # 가락1동의 좌표값을 찍어 보자
oneMap <- leaflet(k3) %>% 
  setView(lat=37.49222, lng=127.10785, zoom=12) %>% 
  addTiles() %>% 
  addPolygons(stroke = FALSE,
              fillOpacity = .7,
              popup = mypopup,
              color = ~mypalette(k3@data$X1인가구)) %>% 
  addLegend( values = ~k3@data$X1인가구,
             pal = mypalette ,
             title = '인구수',
             opacity = 1)
oneMap
saveWidget(oneMap, "oneMap.html")

k3@polygons[[16]]@labpt
