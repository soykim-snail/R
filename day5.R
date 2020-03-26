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
imsi <- html_text(nodes, trim=TRUE)
review <- imsi[nchar(imsi) > 0] 
review
if(length(review) == 10) {
  page <- cbind(title, point)
  page <- cbind(page, review)
  write.csv(page, "movie_reviews.csv")
} else {
  cat("리뷰글이 생략된 데이터가 있네요ㅜㅜ\n")
}