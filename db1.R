# [ R과 Oracle 연동 실습 ] 
# (1) iris 데이터셋을 Oracle 서버에 다음 사양으로 테이블이 생성되고 데이터들이 저장되도록 R 코드를 구현한다.
# 테이블명 : IRIS
# 컬럼명 : SLENGTH, SWIDTH, PLENGTH, PWIDTH, SPECIES

drv <-  JDBC("oracle.jdbc.driver.OracleDriver", "c:/soykim/ojadb6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "jdbctest","jdbctest")
iris_o <- data.frame(iris)
head(iris_o)
names(iris_o) <- c("SLENGTH", "SWIDTH", "PLENGTH", "PWIDTH", "SPECIES")
dbWriteTable(conn, "IRIS", iris_o)


# (2) IRIS 테이블의 내용을 모두 읽어 온다.
iris_j <- dbReadTable(conn, "IRIS")


# (3) 다음과 같은 결과가 출력되도록 ggplot() 으로 시각화 R 코드를 구현한다.(2가지)
# 작성된 R 소스는 db1.R 로 생성된 시각화 결과는 db1.jpg, db2.jpg 로 저장하여 강사컴퓨터에 제출한다.

library(ggplot2)
str(iris_j)
ggplot(iris_j, aes(x = SLENGTH, y = SWIDTH)) +
  geom_point(aes(color = SPECIES))
ggsave("db1.jpg")

ggplot(iris_j, aes(x = PLENGTH, y = PWIDTH)) +
  geom_point(aes(color = SPECIES))
ggsave("db2.jpg")

ggplot(iris_j)+
  geom_point(aes(x = PLENGTH, y = PWIDTH, color = SPECIES))
