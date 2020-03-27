# 다음 실습은 정적 크롤링(스크래핑)의 수행평가입니다. 구현한 다음 saramin.R과 saramin.csv 를
# 이름.zip 파일로 압축해서 메일로 제출하세요.(unicodaum@hanmail.net)
# 그리고 이 파일들은 잘 보관하세요… NCS 시스템에도 올려야 하니깐요.
# 다음은 “Java”로 검색한 사람인 페이지의 화면이다.
# http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=Java
# 
# 빨간 박스의 내용을 추출하여 CSV 파일(파일명:saramin.csv)로 저장하는데
# 첫 번째 열은 기술이름(tech_name), 두 번째 열을 채용 정보 건수(info_count)로 구성한다.
# 구현된 R 소스는 saramin.R 로 제출한다.
library(rvest)
url <- "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=Java"
data <- read_html(url)

name_tag <- html_nodes(data, xpath = '//*[@class="swiper-wrapper list_sfilter"]//label/span[@class="txt"]')
count_tag <- html_nodes(data, xpath = '//*[@class="swiper-wrapper list_sfilter"]//label/span[@class="count"]')

tech_name <- gsub("#", "", html_text(name_tag))
info_count <- gsub("[^[:digit:]]", "", html_text(count_tag))

if(length(tech_name) > length(info_count))
  length(tech_name) <- length(info_count)

write.csv(data.frame(tech_name, info_count), "data/saramin.csv")
