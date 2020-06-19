# [ 텍스트마이닝 실습(1) ]
# 
# hotel.txt를 읽고 제일 많이 나온 명사 10개를 명칭과 횟수(내림차순)로 구성되는 데이터프레임을 생성해서 
# hotel_top_word.csv 로 저장한다. 작성된 R 소스는 tm1.R 저장한 후에 tm1.R 과 hotel_top_word.csv 을
# 제출한다.

library(dplyr)
word_data <- readLines("hotel.txt")
word_data %>% 
  gsub("[^가-힣]", " ", .) %>% 
  extractNoun %>% 
  unlist %>% 
  table %>% sort(decreasing = T) %>% 
  head(10) %>% 
  data.frame %>% 
  write.csv("hotel_top_word.csv")
