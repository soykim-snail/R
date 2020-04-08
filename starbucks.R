# [ 동적 크롤링 수행평가 ]
# https://www.istarbucks.co.kr/store/store_map.do?disp=locale
# 로 요청한 후에 서울지역을 클릭하고, 
# 모든 매장들의 매장명(shopname), 위도(lat), 경도(lng), 주소(addr) 그리고 전화번호(telephone)를 추출하여 starbucks.csv 로 저장한다. 속성 정보를 추출하는 API는 강사컴 학습관련소스와문서/4월7일 폴더의 RSelenium.pdf를 참고한다.
# starbucks.R 과 starbucks.csv 을 메일로(unicodaum@hanmail.net – 메일 제목 : 동적 크롤링 수행평가 - XXX)제출한다.
# https://www.w3schools.com/jsref/met_element_scrollintoview.asp
# 힌트… 사이트의 도움을 받아야 할 수도 있다.

library(RSelenium)
### remoteDriver 객체 생성
#### 방법1 : 셀레늄 서버 기동할 때 포트번호 지정 (cmd창: java -jar selenium-server-standalone.jar -port 4445 )
# remDr <- remoteDriver(remoteServerAddr="localhost", port=4445, browserName="chrome")
#### 방법2 : 셀레늄 서버 기동할 때 포트번호 미지정. default 포트번호  "4444" (cmd창:  java -jar selenium-server-standalone.jar  )
remDr <- remoteDriver(browserName="chrome")  # default 리모트서버주소 "localhost", 브라우저명은 명시필요.

remDr$open()
url <- 'https://www.istarbucks.co.kr/store/store_map.do?disp=locale'
remDr$navigate(url)
Sys.sleep(2)

sel_seoul <- remDr$findElement(using = 'css', '#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a')
Sys.sleep(1)
sel_seoul$clickElement()
Sys.sleep(5) 
sel_full <- remDr$findElement(using = 'css', '#mCSB_2_container > ul > li:nth-child(1) > a')
sel_full$clickElement()
Sys.sleep(5) # 전체 매장수 렌더링될 때까지 기다린다.
# 전체 매장 갯수 추출
limit <- remDr$findElement(using = 'css', '#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span')$getElementText()
limit <- as.numeric(limit)

#지점 정보 읽어 오기
shopname <- c()
lat <- c()
lng <- c()
addr <- c()
telephone <- c()

for(index in 1:limit){
  index
  css <- paste0('#mCSB_3_container > ul > li:nth-child(', index,')')
  dom <- remDr$findElement(using = 'css', css)
  shopname <- c(shopname, unlist(dom$getElementAttribute('data-name')))
  lat <- c(lat, unlist(dom$getElementAttribute('data-lat')))
  lng <- c(lng, unlist(dom$getElementAttribute('data-long')))
  css_sub <- paste0('#mCSB_3_container > ul > li:nth-child(', index,') > p')
  dom_sub <- remDr$findElement(using = 'css', css_sub)
  info <- dom_sub$getElementText()
  addr <- c(addr, unlist(strsplit(unlist(info), split = '\n'))[1])
  telephone <- c(telephone, unlist(strsplit(unlist(info), split = '\n'))[2])
  
  # 스크롤 발생
  ### 방법1 : 3개 지점마다 스크롤 발생 (강사 제시 방법)
  # if(index %% 3 == 0 && index != limit)
    # remDr$executeScript(
    #   "var dom = document.querySelectorAll('#mCSB_3_container > ul > li')[arguments[0]];
    #   dom.scrollIntoView();", list(index)
    # )
  ### 방법2 : 2개 지점마다 스크롤 발생 (3으로 하면 중간중간 NA 문제 발생함)
  if(index %% 2 == 0 && index != limit)
    remDr$executeScript('arguments[0].scrollIntoView()', list(dom))
    
}

write.csv(data.frame(shopname, lat, lng, addr, telephone), file = "starbucks.csv")



