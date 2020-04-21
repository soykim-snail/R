library(KoNLP)
library(dplyr)
readLines('c:/soykim/R-study/hotel.txt') %>%  
  gsub('[^가-힣]',' ', .) %>% 
  extractNoun() %>% 
  unlist() %>% 
  table() %>% 
  sort(decreasing = T) %>% 
  head(10)  %>% 
  data.frame() -> df
df <- data.frame(V1=df[[1]], V2=df[[2]])

