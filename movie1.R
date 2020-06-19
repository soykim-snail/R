# [ 실습1 ]
# 다음영화 사이트에 올려진 (http://movie.daum.net/) 댓글에 대하여 
# 고객 평점과 리뷰글을 1페이지(10개)만 스크래핑하여 
# 데이터프레임 형식으로 만들어 "daummovie1.csv" 로 저장한다.
# 
# https://movie.daum.net/moviedb/grade?movieId=127122 
# 또는
# https://movie.daum.net/moviedb/grade?movieId=131576
# R 코드는 movie1.R 로 생성하여 csv 파일과 함께 제출하세요.


#쥬디
url <- "https://movie.daum.net/moviedb/grade?movieId=131576"
data <- read_html(url)
score <- html_nodes(data, ".emph_grade")
score <- html_text(score)

review <- html_nodes(data, ".desc_review")
review <- html_text(review, trim = T)

write.csv(data.frame(score, review), "data/daummovie1.csv")

#작은 아씨들
url <- "https://movie.daum.net/moviedb/grade?movieId=127122"
data <- read_html(url)
score <- html_nodes(data, ".emph_grade")
score <- html_text(score)

# review <- html_nodes(data, ".desc_review")
review <- html_nodes(data, ".desc_review")
review <- html_text(review, trim = T)

write.csv(data.frame(score, review), "data/daummovie2.csv")