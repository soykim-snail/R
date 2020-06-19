# 다음 문제들을 R로 작성하여 dplyr_lab2.R로 저장하여 제출한다.
# 1. ggplot2 패키지에서 제공되는 mpg 라는 데이터 셋의 구조를 확인한다.
# 이 mpg 를 데이터프레임으로 변환하여 mpg 에 저장한다.(as.data.frame())
# install.packages("ggplot2")
# str(ggplot2::mpg)
# mpg <- as.data.frame(ggplot2::mpg)
# 1-1 mpg의 구조를 확인한다.
# 1-2 mpg 의 행의 개수와 열의 개수를 출력한다.
# 1-3 mpg의 데이터를 앞에서 10개 출력한다.
# 1-4 mpg의 데이터를 뒤에서 10개 출력한다.
# 1-5. mpg의 데이터를 GUI 환경으로 출력한다.
# 1-6 mpg를 열 단위로 요약한다.
# 1-7 mpg 데이터셋에서 제조사별 차량의 수를 출력한다.
# 1-8 mpg 데이터셋에서 제조사별 그리고 모델별 차량의 수를 출력한다.

library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
str(mpg)
dim(mpg)
head(10)
tail(10)
View(mpg)
summary(mpg)
mpg %>% group_by(manufacturer) %>% tally
mpg %>% group_by(manufacturer, model) %>% tally

# 2
# 2-1
mpg %>% rename(city = cty, highway = hwy) %>% 
  # 2-2
  head()

# 3. 
# 문제1. ggplot2의 midwest 데이터를 데이터 프레임 형태로 불러와서 데이터의 특성을 파악하세요.
# 문제2. poptotal(전체 인구)을 total로, popasian(아시아 인구)을 asian으로 변수명을 수정하세요.
# 문제3. total, asian 변수를 이용해 '전체 인구 대비 아시아 인구 백분율' 파생변수를 만들어 보세요
# 문제4. 아시아 인구 백분율 전체 평균을 구하고, 평균을 초과하면 "large", 그 외에는 "small"을 부여하는 파생변수를 만들어 보세요.

#3-1
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)
#3-2
midwest %>% rename(total=poptotal, asian=popasian) %>% 
  #3-3
  mutate(ratio_asian=asian/total) %>% 
  #3-4
  mutate(asess= ifelse(ratio_asian > mean(ratio_asian), "large","small")) -> midwest_after
head(midwest_after)

# 4. 
# 4-1
mpg %>% group_by(displ <= 4) %>% summarise(mean(hwy))
plot(mpg$displ, mpg$hwy)
# 4-2
mpg %>% group_by(manufacturer) %>% summarise(mean(cty)) %>% 
  filter(manufacturer %in% c('audi', 'toyota'))
# 4-3
mpg %>% group_by(manufacturer) %>% summarise(m=mean(hwy)) %>% 
  filter(manufacturer %in% c('chevrolet', 'ford', 'honda')) %>% 
  summarise(mean(m))

# 5.
# 5-1
mpg2 <- mpg %>% select(class, cty)
head(mpg2); str(mpg2)
# 5-2
plot(factor(mpg2$class), mpg2$cty, las=2)
mpg2 %>% filter(class %in% c('suv', 'compact')) %>% 
  group_by(class) %>% summarise(m=mean(cty))

# 6.
mpg3 <- mpg %>% filter(manufacturer == 'audi')
plot(factor(mpg3$model), mpg3$hwy, las=2)
mpg3 %>% arrange(desc(hwy)) %>% head(5)
