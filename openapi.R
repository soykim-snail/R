# 4개의 문자를 모두 해결한 다음에 openapi.R 이라는 파일명으로 소스를 저장하고
# openapi.R, naverblog.txt, navernews.txt, twitter.txt 파일을 제출하시오.
# 
# [ OPEN API 실습 1 ] 
# 네이버의 블로그에서 “맛집” 이라는 단어가 들어간 글들을 검색하여 100개까지 추출한 다음 naverblog.txt 파일로 저장하시오.
# 단, XML 형식의 요청을 처리한다.
# 제거해야 하는 문자들 : <b>, </b>, &quot;, &gt;

rm(list = ls())
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("맛집","euc-kr","UTF-8"))  #iconv (즉 international conversion)
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-naver-client-id" = Client_ID, 
                            "X-naver-client-secret" = Client_Secret)) # 요청 헤더에 인증키를 넣어야 함.
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text

text <- gsub("</?b>", "", text)  # </b>, <b>  ( ? : 1번 내지 0번)
text <- gsub("&.+t;", "", text)  # &xt;, &xyzt;, &qweryut;  (+ : 1번 이상)
text
write(text, file = "naverblog.txt")

# 
# [ OPEN API 실습 2 ] 
# 트위터에서  “취업” 이라는 단어가 들어간 트윗 글들을 검색하여 100개까지 추출한 다음 twitter.txt 파일로 저장하시오.
# 제거해야 하는 문자들과 데이터 값 : [단독], 특수문자, 개행문자, 영어, NA 값

library(rtweet) 
appname <- "edu_data_collection"
api_key <- "RvnZeIl8ra88reu8fm23m0bST"
api_secret <- "wTRylK94GK2KmhZUnqXonDaIszwAsS6VPvpSsIo6EX5GQLtzQo"
access_token <- "959614462004117506-dkWyZaO8Bz3ZXh73rspWfc1sQz0EnDU"
access_token_secret <- "rxDWfg7uz1yXMTDwijz0x90yWhDAnmOM15R6IgC8kmtTe"
twitter_token <- create_token(
  app = appname,
  consumer_key = api_key,
  consumer_secret = api_secret,
  access_token = access_token,
  access_secret = access_token_secret)

key <- "취업"
key <- enc2utf8(key)
result <- search_tweets(key, n=100, token = twitter_token)
str(result)
result$retweet_text
content <- result$retweet_text
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)  
content <- gsub("[단독]", "", content)
content_data <- content[!is.na(content)]

write(content_data, file = "twitter.txt")

# [ OPEN API 실습 3 ] 
# 공공DB에서 360번 차량에 대하여 정보를 추출한 다음 노선ID, 노선길이, 기점, 종점, 배차간격을 다음 형식으로 출력하시오.
# 
# [ 360번 버스정보 ]
# 노선ID : xxx
# 노선길이 : xxx
# 기점 : xxx
# 종점 : xxx
# 배차간격 : xxx
# 
# 참고 : http://api.bus.go.kr/contents/sub02/getBusRouteList.html
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste0("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", 
             API_key, "&strSrch=", bus_No)
doc <- xmlParse(url, encoding="UTF-8")  # {XML}
top <- xmlRoot(doc) # {XML}
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")) # {XML}
df_360 <- subset(df, subset = (df$busRouteNm == 360)) 
df_360 <- sapply(df_360, as.vector)
df_360_result <- df_360[c("busRouteId", "length", "stStationNm", "edStationNm", "term")]
df_label <- c("노선ID", "노선길이", "기점", "종점", "배차간격")

cat(paste(df_label, df_360_result, sep = " : ", collapse = "\n"))


 
# [ OPEN API 실습 4 ] 
# 네이버의 뉴스에서 “빅데이터” 라는 단어가 들어간 뉴스글들을 검색하여 100개까지 추출한 다음 
# 뉴스 제목을 추출하여 navernews.txt 파일로 저장하시오.
# 단, JSON 형식의 요청을 처리한다.
# 제거해야 하는 문자들 : <b>, </b>, &quot;, &gt;

library(jsonlite)
library(httr)
searchUrl<- "https://openapi.naver.com/v1/search/news.json"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("빅데이터","euc-kr","UTF-8"))  #iconv (즉 international conversion)
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",    # {httr}
                            "X-naver-client-id" = Client_ID, 
                            "X-naver-client-secret" = Client_Secret)) # 요청 헤더에 인증키를 넣어야 함.
json_data <- content(doc, type = 'text', encoding = "UTF-8") # 내용 가져오기 {httr}
json_obj <- fromJSON(json_data) #JSON을 R객체로 변환 {jsonlite}
# str(json_obj) # R객체(리스트 데이터셋) 구조를 확인하여 내용접근법 확인
news <- json_obj$items$title

news <- gsub("</?b>", "", text)  # </b>, <b>  ( ? : 1번 내지 0번)
news <- gsub("&.+t;", "", text)  # &xt;, &xyzt;, &qweryut;  (+ : 1번 이상)

write(news, file = "navernews.txt")
