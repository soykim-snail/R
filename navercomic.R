# 다음의 요구 사항대로 구현하고 모든 소스와 생성된 csv 파일을 제출한다.
# 다음은 https://comic.naver.com/genre/bestChallenge.nhn 사이트의 콘텐츠 일부이다.
# 박스로 표시된 내용을 추출하고 “comicName,  comicSummary, comicGrade” 열명으로 DataFrame을 생성하여
# navercomic.csv로 저장하고 소스는 navercomic.R로 저장한다. 
# 모든 페이지를 크롤링하고 스크래핑한다.

data = read_html("https://comic.naver.com/genre/bestChallenge.nhn")
comicName <- html_text(html_nodes(data, xpath = '//*[@class="challengeInfo"]//h6/a/text()'), trim = T)
comicsSummary <- html_text(html_nodes(data, xpath = '//*[@class="challengeInfo"]/*[@class="summary"]'), trim = T)
comicGrade <- html_text(html_nodes(data, xpath = '//*[@class="challengeInfo"]/*[@class="rating_type"]/strong'), trim = T)

write.csv(data.frame(comicName, comicsSummary, comicGrade), "data/navercomic.csv")

