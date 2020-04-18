# [ 지도 출력 실습(1) ]
# 우리 집의 지도를 출력하는데 
# 현재의 초시간이 0~14초 사이이면 terrain 타입으로
# 현재의 초시간이 15~29초 사이이면 satellite 타입으로
# 현재의 초시간이 30~44초 사이이면 roadmap 타입으로
# 현재의 초시간이 45~59초 사이이면 hybrid 타입으로
# 지도를 출력하는 R 코드를 작성한다.
# 지도 제목으로 "XXX 동네"를 설정하고 "위도"와 "경도"도 출력한다.
# 파일명은 myhome_map.R 이고 지도는 이미지로 
# mymap.png 저장하여 함께 제출한다. 

library(ggmap)
library(dplyr)
library(ggplot2)

# 초시간 찾기
Sys.time() %>% 
  format(format="%S") %>% 
  as.numeric() -> t

# 조건에 따라 맵타입 정하기
type <- ifelse(t < 15, "terrain", 
          ifelse(t < 30, "satellite",
              ifelse(t < 45, "roadmap", "hybrid")))

# 집 위치 찾기
home <-  geocode(enc2utf8("송파대로 567"))
lonlat_home <- unlist(home)

# 지도 그리고 옵션 주기
map <-  get_map(location = lonlat_home, zoom = 15, maptype = type)
ggmap(map) +
  geom_point(data = home, aes(x =lon, y =lat), col = "red") +
  geom_text(data = home, 
            aes(x = lon, y=lat, label= "달팽이 집", vjust=1, hjust=1), col = "magenta") +
  labs(title = "달팽이 동네", x="경도", y="위도") +
  guides(color=F)

# 지도 저장
ggsave("myhome_map.png")
