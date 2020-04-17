# Selenium 설치 
# (https://www.selenium.dev/  --> Selenium Server (Grid) --> jar 파일)
# 파일압축 해제 후에,,,
# bin 디렉토리에 크롬 실행파일 (즉, chromedriver.exe) 넣어둔다.

# Selenium 서버 기동
# cmd 창에서 Selenium 서버 기동 (cmd 창을 끄지 않도록 주의)
# C:\soykim\R-study\selenium-server-standalone-master\bin>
# java -jar selenium-server-standalone.jar -port 4445

install.packages("RSelenium")
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr="localhost", post= 4445, browserName="chrome")
remDr$open()

remDr$navigate("http://www.google.com")
webElem <- remDr$findElement(using = "css", "[name='q']") # css selector를 사용해서 element 찾기
webElem$sendKeysToElement(list("JAVA", key="enter"))
# findElements (복수)

remDr$navigate("http://www.naver.com")
webElem <- remDr$findElement(using = "css", "[name='query']")
webElem$sendKeysToElement(list("JAVA", key="enter"))


# [ 네이버 웹툰 댓글 읽기 ]
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)

#단수형으로 노드 추출
more<-remDr$findElement(using='css','#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
more$getElementTagName()
more$getElementText()
more$clickElement()


# 2페이지부터 10페이지까지 링크 클릭하여 페이지 이동하기 
for (i in 4:12) {
  nextCss <- paste0("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span")
  nextPage<-remDr$findElement(using='css',nextCss)
  nextPage$clickElement()
  Sys.sleep(2)
}

#복수형으로 노드 추출 
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)
#베스트 댓글 내용 읽어오기
bestReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
sapply(bestReviewNodes,function(x){x$getElementText()})

#전체 댓글 링크 클릭후에 첫 페이지 내용 읽어오기
totalReview <- remDr$findElement(using='css','#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
totalReview$clickElement()
totalReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
sapply(totalReviewNodes,function(x){x$getElementText()})
