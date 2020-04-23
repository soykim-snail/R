# 다음에 제시된 웹 페이지는 다음뉴스의 랭킹페이지이다.
# (http://media.daum.net/ranking/popular/)
# 이 페이지에서 각 뉴스의 제목과 이 뉴스를 올린 신문사명칭을 스크래핑(5개)하여
# newstitle, newspapername 형식의 데이터프레임을 만들고 CSV 파일로 저장하려고 한다. 
# 
# 데이터프레임으로 생성하여 리턴하는 것은 R 로 구현하고 
# R이 생성한 데이터 프레임을 받아와서 파일(daumnews_schedule.csv)에 
# 저장하는 것은 Java API를 이용하여 Java 로 구현하라

library(xml2)
library(rvest)
url = "http://media.daum.net/ranking/popular/"
data <- read_html(url)
newstitle <- html_text(html_nodes(data, "ul.list_news2 .tit_thumb > a"), trim=T)
newstitle <- gsub(",", "", newstitle)
newspapername <-  html_text(html_nodes(data, ".tit_thumb > span"), trim=T)
df <- data.frame(newstitle = newstitle[1:5], 
                 newspaername = newspapername[1:5],
                 stringsAsFactors = F)

