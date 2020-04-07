# 네이버 웹툰 댓글 페이지에서 
# (http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135)
# 베스트 댓글과 전체 댓글 50페이지를 읽어서 webtoon1.txt 파일에 저장(write())하는 
# 코드를 작성한다. 
# 제출 파일명 : webtoon1.txt, webtoon1.R

# Selenium 서버 기동
# cmd 창에서 Selenium 서버 기동 (cmd 창을 끄지 않도록 주의)
# C:\soykim\R-study\selenium-server-standalone-master\bin>
# java -jar selenium-server-standalone.jar -port 4445

install.packages("RSelenium")
library(RSelenium)
rd <- remoteDriver(port=4445, browserName="chrome")

rd$open()
rd$navigate("http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135")

# 베스트 댓글 읽어오기
best <- rd$findElements(using = "css selector", value = "#cbox_module > div > div.u_cbox_content_wrap > ul div.u_cbox_comment_box > div > div.u_cbox_text_wrap > span.u_cbox_contents")
best_rw <- sapply(best, function(x){x$getElementText()})
best_rw <- unlist(best_rw)


# 전체댓글 보기로 넘어가기
full_button <- rd$findElement(using = "css", value = "#cbox_module > div > div.u_cbox_view_comment > a")
full_button$clickElement()

# 댓글 읽어보기
review <- best_rw
for(j in 1:5){
  for(i in 4:13){
    full <- rd$findElements(using = "css selector", value ="#cbox_module > div > div.u_cbox_content_wrap > ul div.u_cbox_comment_box > div > div.u_cbox_text_wrap > span.u_cbox_contents")
    full_rw <- sapply(full, function(x){x$getElementText()})
    full_rw <- unlist(full_rw)
    review <- c(review, full_rw)
    # 다음페이지 보기
    selector <- paste0("#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(", i, ")")
    next_button <- rd$findElement(using = "css selector", value=selector)
    next_button$clickElement()
    Sys.sleep(1)
  }
}
write.csv(review, "data/webtoon1.csv")



