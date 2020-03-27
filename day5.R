# 교재 81페이지
library() #이미 설치된 패키지를 보여준다.
installed.packages() #이미 설치된 패키지를 보여준다.
search()  #로드된 패키지를 보여준다.
read_excel()
install.packages("readxl") #패키지 인스톨하고,
library(readxl) # require(readxl) #로드해서 사용
excel_data_ex <- read_excel("book/data_ex.xls")
getwd()
View(excel_data_ex)
str(excel_data_ex)
search()

# 웹 크롤링과 스크래핑

install.packages("rvest") 
library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
text <- read_html(url)
text
str(text)

nodes <- html_nodes(text, "div")  #찾아서 노드를 리스트로 리턴
nodes
title <- html_text(nodes) # 노드의 텍스트를 벡터로 리턴
title

node1 <- html_nodes(text, "div:nth-of-type(1)")
node1
html_text(node1) #노드의 텍스트 꺼내기
html_attr(node1, "style") #노드의 속성 꺼내기

node2 <- html_nodes(text, "div:nth-of-type(2)")
node2
html_text(node2)
html_attr(node2, "style")

node3 <- html_nodes(text, "div:nth-of-type(3)")
node3
html_text(node3)

html_nodes(text, "*") # universal
html_nodes(text, "h1") # type
html_nodes(text, "body, h1") # grouping
# class
html_nodes(text, "body *") # decendant
html_nodes(text, "body h1") # decendant
html_nodes(text, "body > *") # child
html_nodes(text, "body > h1") # child
html_nodes(text, "h1 + *") # adjacent sibling
html_nodes(text, "h1 + span") # adjacent sibling
html_nodes(text, "h1 ~ *") # general sibling
html_nodes(text, "h1 ~ span") # general sibling
html_nodes(text, "body:nth-child(2)") #### ??
html_nodes(text, "body:first-child") #### ??
html_nodes(text, "body") #### ??

# 단일 페이지(rvest 패키지 사용)
install.packages("rvest"); 
library(rvest)
text<- NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn?page=1"
text <- read_html(url,  encoding="CP949")
text
# 영화제목
nodes <- html_nodes(text, ".movie")
title <- html_text(nodes)
title
# 영화평점
nodes <- html_nodes(text, ".title em")
point <- html_text(nodes)
point
# 영화리뷰 
nodes <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
imsi <- html_text(nodes, trim=TRUE) #앞뒤 공백 잘라내기
review <- imsi[nchar(imsi) > 0] 
review
if(length(review) == 10) {
  page <- cbind(title, point)
  page <- cbind(page, review)
  write.csv(page, "movie_reviews.csv")
} else {
  cat("리뷰글이 생략된 데이터가 있네요ㅜㅜ\n")
}

# 여러 페이지
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
text <- NULL
movie.review <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  text <- read_html(url,  encoding="CP949")
  nodes <- html_nodes(text, ".movie")
  title <- html_text(nodes)
  nodes <- html_nodes(text, ".title em")
  point <- html_text(nodes)
  nodes <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
  imsi <- html_text(nodes, trim=TRUE)
  review <- imsi[nchar(imsi) > 0] 
  if(length(review) == 10) {
    page <- cbind(title, point)
    page <- cbind(page, review)
    movie.review <- rbind(movie.review, page)
  } else {
    cat(paste(i," 페이지에는 리뷰글이 생략된 데이터가 있어서 수집하지 않습니다.ㅜㅜ\n"))
  }
}
write.csv(movie.review, "movie_reviews2.csv")


# 한국일보 페이지(XML 패키지 사용)
install.packages("XML")
library(XML)
imsi <- read_html("http://hankookilbo.com")
t <- htmlParse(imsi)
content<- xpathSApply(t,"//p[@class='title']", xmlValue); 
content
content <- gsub("[[:punct:][:cntrl:]]", "", content)
content
content <- trimws(content)
content

# httr 패키지 사용 - GET 방식 요청
install.packages("httr")
library(httr)
http.standard <- GET('http://www.w3.org/Protocols/rfc2616/rfc2616.html') # GET 방식 통신을 위한 기본정보를 담고 있는 객체 생성
library(rvest)
title2 = html_nodes(read_html(http.standard), 'div.toc h2') # url을 그대로 넣어도 동일
# title2 = html_nodes('http://www.w3.org/Protocols/rfc2616/rfc2616.html', 'div.toc h2')
title2 = html_text(title2)
title2

# httr 패키지 사용 - POST 방식 요청
library(httr)
# POST 함수를 이용해 모바일 게임 랭킹 3월 15일 주  모바일 게임 랭킹을 찾는다
#(http://www.gevolution.co.kr/score/gamescore.asp?t=3&m=0&d=week) 
game = POST('http://www.gevolution.co.kr/score/gamescore.asp?t=3&m=0&d=week',
            encode = 'form', body=list(txtPeriodW = '2020-03-15'))
title2 = html_nodes(read_html(game), 'a.tracktitle')
title2 = html_text(title2)
title2[1:10]


# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
res = GET('https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001')
htxt = read_html(res)
link = html_nodes(htxt, 'div.list_body a'); length(link)
article.href = unique(html_attr(link, 'href')) # 중복제거
article.href

# 이미지, 첨부파일 다운 받기 
# pdf
library(httr)
res = GET('http://cran.r-project.org/web/packages/httr/httr.pdf')
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf') 
# content()
# 서버에서 받아온 header와 body에서 body 읽어옴
# 옵션 'raw'는 바이너리
# writeBin() : 바이너리로 저장


# jpg
library(rvest)
h = read_html('http://unico2013.dothome.co.kr/productlog.html')
imgs = html_nodes(h, 'img')
img.src = html_attr(imgs, 'src')
for(i in 1:length(img.src)){
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep=""))
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
} 
