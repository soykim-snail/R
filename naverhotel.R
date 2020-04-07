# 다음 사이트의 댓글들을 추출하는 기능을 동적 크롤링으로 구현해 본다.
# R 파일명 : naverhotel.R
# 댓글을 모아서 저장하는 텍스트 파일명 : naverhotel.txt
# 
# https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2

remDr <- remoteDriver(remoteServerAddr="localhost", port=4445, browserName="chrome")
remDr$open()

repl_v = NULL;
url<-'https://hotel.naver.com/hotels/item?hotelId=hotel:Shilla_Stay_Yeoksam&destination_kor=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC&rooms=2'
remDr$navigate(url)
Sys.sleep(3)

pageLink <- NULL
reple <- NULL
check_next <- NULL

repeat{
  doms <- remDr$findElements(using = "css selector", "body > div > div.ng-scope > div.container.ng-scope > div.content > div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > ul > li > div.review_desc > p")
  Sys.sleep(1)
  reple_v <- sapply(doms, function (x) {x$getElementText()})
  print(reple_v)
  reple <- append(reple, unlist(reple_v))
  cat(length(reple), "\n")
  
  #### 방법1 : 페이지 링크가 strong으로 활성화 되었는지 체크한다.
  # check_PageElem <- remDr$findElement(using='css','body > div > div.ng-scope > div.container.ng-scope > div.content > div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > div.paginate > span:nth-child(6)> strong')
  # check_PageNewNum <- as.numeric(check_PageElem$getElementText())
  # if(!is.na(check_PageNewNum))  { 
  #   cat("종료\n")
  #   break; 
  # }
  
  #### 방법2 : "다음" 링크의 class가 마지막 페이지에서는 disabled로 바뀐다는 점을 이용한다.
  try(check_next <- remDr$findElement(using = 'css', 'body > div > div.ng-scope > div.container.ng-scope > div.content > div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > div.paginate > a.direction.next.disabled'), silent = T)
  # try 옵션에 silent=T 하면, R프로그램의 Error Message는 출력되지 않는다. (단, 셀레늄의 메세지는 출력)
  if(length(check_next)>0){
    cat('종료\n')
    break;
  }


  #### 다음페이지로 계속
  pageLink <- remDr$findElement(using='css',"body > div > div.ng-scope > div.container.ng-scope > div.content > div.hotel_used_review.ng-isolate-scope > div.review_ta.ng-scope > div.paginate > a.direction.next ")
  pageLink$clickElement()
  Sys.sleep(2)
  
}
cat(length(reple), "개의 댓글 추출\n")
write(reple,"naverhotel.txt")
