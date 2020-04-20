## leaflet 단계 구분도 사용
## http://web-r.org/webrboard/6477

rm(list=ls())
# leaflet과 우리나라 행정구역 지도 활용
install.packages("Rtools")
install.packages("devtools") 
install.packages("Rcpp") 
install.packages("tmap") 
devtools::install_github("cardiomoon/Kormaps") # 현재 작동 안함

library(Kormaps)
library(dplyr)
library(leaflet)

str(korpopmap1) # korpopmap1: 2010년 행정구역지도 level1(시/도별) + 인구총조사(2010)
str(korpopmap2) # korpopmap2: 2010년 행정구역지도 level2(시/군/구) + 인구총조사(2010)
str(korpopmap3) # korpopmap3: 2010년 행정구역지도 level3(읍/면/동) + 인구총조사(2010)

View(korpopmap1)
View(korpopmap2)
View(korpopmap3)

# 한글깨짐 현상 해결 방법

## 변수명 한글깨짐
names(korpopmap1)
names(korpopmap2)
names(korpopmap3)

# 1단계: 인코딩 정보를 확인한다.
Encoding(names(korpopmap1))
Encoding(names(korpopmap2))
Encoding(names(korpopmap3))

# 2단계 : 적절하게 인코딩 값을 부여한다.
Encoding(names(korpopmap1)) <- 'UTF-8'
Encoding(names(korpopmap2)) <- 'UTF-8'
Encoding(names(korpopmap3)) <- 'UTF-8'


# 데이터의 한글깨짐 발견!!
korpopmap2@data$name

# 1단계: 인코딩 정보를 확인한다.
Encoding(korpopmap2@data$name)

# 2단계 : 적절하게 인코딩 값을 부여한다.
Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8'

## 서울지역 분석을 위한 신규객체 생성
seoulpopmap <- korpopmap2
seoulpopmap@data <- seoulpopmap@data[1:25,] # 서울 지역의 구만
seoulpopmap@polygons<-seoulpopmap@polygons[1:25] # 서울 지역의 구만
seoulpopmap

crime <- read.csv('data/2017crime.csv')
head(crime)

palette1<-colorNumeric(palette = 'Oranges', domain = crime$살인_발생)
popup1 <- paste0(seoulpopmap$name,'<br> 살인 : ',crime$살인_발생, '건')
map4<-leaflet(seoulpopmap) %>%  
  setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>% 
  addTiles() %>%
  addPolygons(stroke=FALSE,
              smoothFactor=0.2,
              fillOpacity=.5, 
              popup=popup1, 
              color=~palette1(crime$살인_발생), 
              group='살인')
map4


palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(seoulpopmap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map5<-leaflet(seoulpopmap) %>% 
  addTiles() %>% 
  setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE, # 다각형의 경계선 그릴지
              smoothFactor=0.2, # ??
              fillOpacity=.5, # 투명도
              popup=popup2, 
              color=~palette2(crime$폭력_발생), 
              group='폭력') # 나중에 그룹단위로 작업가능
map5


palette3<-colorNumeric(palette = 'Reds', domain = crime$범죄_발생_총합)
popup3 <- paste0(seoulpopmap$name,'<br> 범죄_발생_총합 : ',crime$범죄_발생_총합, '건')
map6<-leaflet(seoulpopmap) %>% 
  addTiles() %>% 
  setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,
              smoothFactor=0.2,
              fillOpacity=.5, 
              popup=popup3, 
              color=~palette3(crime$범죄_발생_총합),
              group='총 범죄')

map6

palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(seoulpopmap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map8<-leaflet(seoulpopmap) %>% 
  addTiles() %>% 
  setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  # addPloygons 겹쳐 그리기 가능
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력') %>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')
map8

clearGroup(map8, '폭력') # 특정 그룹 지우기

rm(list=ls())
#library(Kormaps)
DONG<-read.csv('data/one.csv')
Encoding(names(korpopmap2))<-'UTF-8'
Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8'

Encoding(names(korpopmap3))<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'
head(korpopmap3@data)

View(korpopmap2)
View(korpopmap3)

k2 <- korpopmap2
k3 <- korpopmap3
k2@data[c("C행정구역별_읍면동", "행정구역별_읍면동")]
k3@data[c("C행정구역별_읍면동", "행정구역별_읍면동")]

# 양천구의 구코드 출력
k2@data[k2@data$C행정구역별_읍면동 == '11150', 
        c("C행정구역별_읍면동", "행정구역별_읍면동")]
# 양천구에 속한 동의 코드 출력 --> 추출되지 않음
k3@data[k3@data$C행정구역별_읍면동 == '11150',      # 등가연산에서 패턴 사용불가 -_-
        c("C행정구역별_읍면동", "행정구역별_읍면동")]
# 양천구에 속한 동의 코드 출력 --> 추출됨
k3@data[grep('^11150', k3@data$C행정구역별_읍면동), # grep 함수로 패턴상응 인덱스 추출
        c("C행정구역별_읍면동", "행정구역별_읍면동")]


# 강남구의 동 뽑기 
guname <- '강남구'
gucode <- k2@data[k2@data$name == guname, "code.data"]
pattern <- paste0('^', gucode)
k3@data[grep(pattern, k3@data$code.data), 
        c("code.data", "name")]

# 강남구 1인 가구 뽑기
k3@data$name<-gsub('·','',k3@data$name) 
colnames(DONG)<-c('구별','name','일인가구')
dong <- DONG %>%filter(구별=='강남구')


# 광진구 데이터만 뽑음
k3@data<-k3@data[c(67:81),] 
k3@polygons<-k3@polygons[c(67:81)] 


k3@data$name<-gsub('·','',k3@data$name) 
colnames(DONG)<-c('구별','name','일인가구')
dong <- DONG %>%filter(구별=='광진구')

k3@data<-merge(k3@data,dong,by.x='name',sort=FALSE)
mymap <- k3@data
#mypalette <- colorNumeric(palette ='RdYlBu' , domain = k3@data$'일인가구')
#mypalette <- colorNumeric(palette ='PuRd' , domain = k3@data$'일인가구')
mypalette <- colorNumeric(palette ='Set3' , domain = k3@data$'일인가구')
mypopup <- paste0(mymap$name,'<br> 1인가구: ',k3@data$'일인가구')

map7 <- NULL
map7<-leaflet(k3) %>% 
  addTiles() %>% 
  setView(lat=37.52711, lng=126.987517, zoom=12) %>%
  addPolygons(stroke =FALSE,
              fillOpacity = .7,
              popup = mypopup,
              color = ~mypalette(k3@data$일인가구)) %>% 
  addLegend( values = ~k3@data$일인가구,
             pal = mypalette ,
             title = '인구수',
             opacity = 1)
map7		




#install.packages("RColorBrewer")
library(RColorBrewer)

for(col_i in c('YlGn','RdPu', 'PuRd', 'BrBG', 'RdBu', 'RdYlBu', 'Set3', 'Set1')){
  print(col_i)
  print(brewer.pal(n = 5, name = col_i))
}

install.packages("htmlwidgets")
library(htmlwidgets)


saveWidget(map7, file="m.html")



library(leaflet)
View(quakes)
str(quakes)
data <- quakes
leaflet() %>% addTiles() %>%
  addMarkers(data$long, data$lat, 
             popup = paste("지진 강도 : ", as.character(data$mag)), 
             label = as.character(data$mag))


data <- quakes[1:20,]
leaflet() %>% addTiles() %>%
  addMarkers(data$long, data$lat, 
             popup = paste("지진 강도 : ", as.character(data$mag)), 
             label = as.character(data$mag))


getColor <- function(quakes) {
  result <- sapply(quakes$mag, function(mag) {
    if(mag <= 4) {
      "green"
    } else if(mag <= 5) {
      "orange"
    } else {
      "red"
    } })
  return(result)
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(data)
)

leaflet() %>% addTiles() %>%
  addAwesomeMarkers(data$long, data$lat, icon=icons, 
                    label = as.character(data$mag))

?addAwesomeMarkers

