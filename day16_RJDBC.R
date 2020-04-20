# 오라클과 sqldeveloper 설치
# jdbc 계정 만들기
# SQL> create user jdbctest identified by jdbctest;
# SQL> grant connect, resource to jdbctest;

# R과 Oacle 연동
install.packages("DBI");
install.packages("RJDBC");
library(RJDBC)
library(DBI)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/soykim/ojdbc6.jar") #jdbc driver 객체
conn <- dbConnect(drv,"jdbc:oracle:thin:@localhost:1521:xe","jdbctest","jdbctest") #jdbc connection 객체
conn

## dbListTables : 테이블 리스트 추출 (select * from tab;)
dbListTables(conn)

## dbReadTable: 테이블 내용 통째로 읽어오기
result1<-dbReadTable(conn,"VISITOR") # DB에서 table정보 dataframe으로 가져오기
result1
class(result1)
mode(result1)

## dbGetQuery : 골라서 읽어오기 ==> data frame 으로 반환
result2 <- dbGetQuery(conn, "SELECT * FROM VISITOR")
result2
class(result2)

## dbSendQuery : 골라서 읽어오기 ==> JDBCResult 객체로 반환. (패치 작업 필요함)
result3 <- dbSendQuery(conn, "SELECT * FROM VISITOR")                                       
result3
class(result3)
ret1 <- dbFetch(result3, 1) 	# 페치해올 분량 지정하기.
ret1
ret2 <- dbFetch(result3, 2)
ret2
dbFetch(result3) # 전체 페치

dbGetQuery(conn, "SELECT * FROM TAB")


# 테이블에 데이터 저장하기
# 방법 1
# dbWriteTable : 테이블 생성과 인서트 
dbWriteTable(conn,"book1",
             data.frame(bookname=c("자바의 정석","하둡 완벽 입문","이것이 리눅스다"),
                                     price=c(30000,25000,32000)))
dbGetQuery(conn, "SELECT * FROM book1")
dbWriteTable(conn,"cars",head(cars,3))
dbGetQuery(conn, "SELECT * FROM cars")

# 방법 2
dbSendUpdate(conn,"INSERT INTO VISITOR VALUES('R언어',sysdate,'R 언어로 데이터를 입력해요')")
dbSendUpdate(conn,"INSERT INTO VISITOR VALUES('하둡',sysdate,'대용량 데이터 분산저장& 처리기술')")
dbSendUpdate(conn,"INSERT INTO NEWS VALUES(news_seq.nextval, '유니코','테스트', 'R로 데이터를 입력하는거 테스트입니당..', sysdate, 0)")

# 데이터 수정
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(1,1)")
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(2,2)")
dbReadTable(conn,"CARS")
dbSendUpdate(conn,"UPDATE CARS SET DIST =DIST*100 WHERE SPEED =1")
dbReadTable(conn,"CARS")
dbSendUpdate(conn,"UPDATE CARS SET DIST =DIST*3 WHERE SPEED =1")
dbReadTable(conn,"CARS")

# 테이블 삭제
dbRemoveTable(conn,"CARS")

#######################다양한 DB 연동 예제들##################################
# 예제 1
df <- read.table("data/product_click.log",stringsAsFactors = F)
head(df)
str(df)
names(df) <- c("click_time","pid")
df$click_time <- as.character(df$click_time)
dbWriteTable(conn,"productlog1",df)
result4 <-dbReadTable(conn,"PRODUCTLOG1")
result4
# 예제 2
dbWriteTable(conn,"mtcars",mtcars)
rs <- dbSendQuery(conn,"SELECT*FROM mtcars WHERE cyl=4")
rs
dbFetch(rs)
dbClearResult(rs)

rs <- dbSendQuery(conn,"SELECT*FROM mtcars")
ret1<- dbFetch(rs,10)
ret2<- dbFetch(rs)
dbClearResult(rs)

nrow(ret1)
nrow(ret2)
