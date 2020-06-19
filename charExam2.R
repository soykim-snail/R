# 다음 그래프들을 만들어 보고 chartExam2.R 로 제출한다.
# [ 문제 1 ]
# mpg 데이터 셋의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 한다.
# x축은 cty, y축은 hwy로 된 산점도를 만들어 본다. 

mpg <- data.frame(ggplot2::mpg) 
plot(mpg$cty, mpg$hwy, pch=3, xlab = "도시연비", ylab ="고속도로연비")

# [ 문제 2 ]
# mpg 데이터 셋에서 구동방식(drv)별 차량의 수를 다음과 같이 보여지도록 바 그래프로 출력한다.
drv <- table(mpg$drv)
barplot(drv, col = rainbow(3))
 
# [ 문제 3 ]
# boxplot는 X~Y 형식의 포뮬러식을 지원한다. 이 식의 의미는 ‘Y별 X데이터를 모아서’ 라는 것이다.
# 다음과 같이 data 변수에 그래프를 그리는데 사용하는 데이터 프레임을 설정하고 첫 번째 아규먼트로 
# hwy~manufacturer을 설정하면 자조사별 고속도로 연비를 추출하라는 의미가 된다.
# boxplot(hwy~manufacturer,data=mpg)
boxplot(hwy~manufacturer, data = mpg, ylab = "고속도로연비", xlab= "", las =2, col = heat.colors(15) )
title("*제조사별 고속도로 연비*", col.main = "magenta" ) # 색깔이 안 바뀌는 문제


