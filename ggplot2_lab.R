# mpg 데이터와 midwest 데이터를 이용해서 분석 문제를 해결해 보세요.
# Q1. mpg 데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도
# 를 만들어 본다.
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(color = "blue")
ggsave("result1.png")

# Q2. 자동차 중에서 어떤 class(자동차 종류)가 가장 많은지 알아보려고 한다. 
# 자동차 종류별 빈도를 표현한 막대 그래프를 만들어 본다.

ggplot(data = mpg, aes(x = class)) +
  geom_bar(aes(fill = drv))
ggsave("result2.png")


# Q3. 미국 지역별 인구통계 정보를 담은 ggplot2 패키지의 midwest 데이터를 
# 이용해서 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 한다. 
# x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 
# 만들어 보세요. 전체 인구는 50만 명 이하, 아시아인 인구는 1만 명 이하인 지역만 
# 산점도에 표시되게 설정한다.
# 
# [ 참고 ]
# 10만 단위가 넘는 숫자는 지수 표기법(Exponential Notation)에 따라 표현됨
# 1e+05 = 10만(1 × 10의 5승)
# 정수로 표현하기 : options(scipen = 99) 실행 후 그래프 생성
# 지수로 표현하기 : options(scipen = 0) 실행 후 그래프 생성
# R 스튜디오 재실행시 옵션 원상 복구됨

midwest <- as.data.frame(ggplot2::midwest)
options(scipen = 99)
ggplot(data = midwest, aes(x = poptotal, y = popasian)) +
  geom_point() + coord_cartesian(xlim = c(0, 5*1e+05), ylim = c(0, 1e+04))
ggsave("result3.png")

# Q4. class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 
# cty(도시 연비)가 어떻게 다른지 비교해보려고 합니다. 
# 세개 차종의 cty를 나타낸 상자 그림을 만들어본다.

library(dplyr)
mpg %>% filter(class %in% c("compact", "subcompact", "suv")) %>% 
ggplot(aes(x = class, y = cty)) +
  geom_boxplot()
ggsave("result4.png")

# Q5. product_click.log 파일을 가지고 클릭된 상품의 갯수를 가지고 
# 바 그래프로 출력한다.

data <- read.table("data/product_click.log")
ggplot(data, aes(x = V2)) + geom_bar(aes(fill=V2))
ggsave("result5.png")


# Q6. product_click.log 파일을 가지고 요일별 상품 클릭 횟수를 계산하여  
# 바 그래프로 출력한다.(x축은 요일명)

data$V1 %>% 
  as.character() %>% 
  as.Date(format = "%Y%m%d%H%M") %>% 
  weekdays() %>% 
  bind_cols("day"=., data) -> data_week 
  
ggplot(data_week, aes(x = day)) +
    geom_bar(aes(fill = day)) +
    labs(x = "요일", y ="클릭수") 
ggsave("result6.png")


