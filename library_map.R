# [ 지도 출력 실습(2) ]
# 서울 지도를 그리고 지역별 장애인 도서관 위치를 표시(투명한 point)한다. 
# 도서관명을 함께 출력한다.
# 
# 소스는 library_map.R로 구현하고 출력 결과는 library.png 로 저장하여 제출한다.

df <-  read.csv("data/지역별장애인도서관정보.csv")
lonlat_lib <- data.frame(lon = df$LON, lat = df$LAT)
library_map <- get_map(location="Seoul", marker = lonlat_lib,
                       maptype = "watercolor", source="stamen" )
library_ggmap <- ggmap(library_map)
library_ggmap +
  geom_point(data = lonlat_lib, alpha = 0.5, color = "pink") +
  geom_text(data = lonlat_lib, aes(x=lon, y=lat), label=df$도서관명)
            
ggsave("library.png")
