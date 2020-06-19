# [ 실습1 ]
# 다음영화 사이트에 올려진 (http://movie.daum.net/) 댓글에 대하여 
# 고객 평점과 리뷰글을 1페이지(10개)만 스크래핑하여 
# 데이터프레임 형식으로 만들어 "daummovie1.csv" 로 저장한다.
# 
# https://movie.daum.net/moviedb/grade?movieId=127122 
# 또는
# https://movie.daum.net/moviedb/grade?movieId=131576
# R 코드는 movie1.R 로 생성하여 csv 파일과 함께 제출하세요.

# 이번에는 평점과 리뷰글을 20페이지까지 스크래핑하여 데이터프레임으로 만들어 "daummovie2.csv" 로 저장한다.
# R 코드는 movie2.R 로 생성하여 csv 파일과 함께 제출하세요.


#작은 아씨들
url <- "https://movie.daum.net/moviedb/grade?movieId=127122&type=netizen&page="
movie <- NULL

for(i in 1:100){
  url_page <- paste0(url, i)
  data_page <- read_html(url_page)
  score_page <- html_text(html_nodes(data_page, ".emph_grade"))
  if(length(score_page)<1) break
  review_page <- html_text(html_nodes(data_page, ".desc_review"), trim = T)
  movie_page <- data.frame(score_page, review_page)
  movie <- rbind(movie, movie_page)
}

write.csv(movie, "data/daummovie2.csv")


