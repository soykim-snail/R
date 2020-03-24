#LIST
v<-c(1,2,3)
l<-list(1,2,3) 
v
l
(v*3) #연산 가능하다.
(l*3) #에러 발생한다.
(unlist(l)*3) #unlist 해서 연산한다.

v[1]*3 #연산 가능하다.
l[1]
l[1]*3 #에러 발생한다
l[[1]]
l[[1]]*3 #연산 가능

lds <- list(1,2,3) 
lds
lds+100 #에러; unlist(lds)*100
lds[1]
lds[1]+10 #에러; unlist(lds[1])+10
lds[[1]]+10

names(lds) <- LETTERS[1:3]
lds
lds[[2]]
lds[["B"]]
lds$B


a<-list(
  a = 1:3,
  b = "a string",
  c = pi,
  d = list(-1,-5)
)
a
a[1]
a[[1]] # a[["a"]]
a$a
a[[1]][1]
a$a[1]
a[1]+1
a[[1]]+1
a[[1]][2] <- 100
new_a <- unlist(a[1])
a[1]; new_a
names(a) <- NULL
names(new_a) <- NULL



ls()
length(ls())
save(list=ls(),file="all.rda") # varience will save in "all.rda" of rexam
rm(list=ls())
ls()
load("all.rda")

#read file data
nums <- scan("data/sample_num.txt") #scan은 숫자읽기에 특화
word_ansi <- scan("data/sample_ansi.txt",what="") #문자 읽을때는 what 매개변수 사용
words_utf8 <- scan("data/sample_utf8.txt", what="",encoding="UTF-8")
words_utf8_new <- scan("data/sample_utf8.txt", what="")
lines_ansi <- readLines("data/sample_ansi.txt") #readLines는 행단위로 읽어서 벡터로 리턴
lines_utf8 <- readLines("data/sample_utf8.txt",encoding="UTF-8") #기본인코딩은 ansi, 대문자 "UTF-8"에 주의!!

df2 <- read.table("data/product_click.log") #read.csv("xxx")
str(df2)
head(df2)
summary(df2$V2)


for(data in month.name) 
  print(data)

for(data in month.name) 
  cat(data) #자동 개행처리 안함

#print는 데이터셋을 잘 보여줌
sum <- 0
for(i in 5:15){
  if(i%%10==0){
    break
  }
  sum <- sum + i
  print(paste(i,":",sum))
}

#cat은 메세지 출력용
sum <- 0
for(i in 5:15){
  if(i%%10==0){
    break
  }
  sum <- sum + i
  cat(i,":",sum,"\n")
}

sum <-0
for(i in 5:15){
  if(i%%10==0){
    next;  #JAVA의 continue와 동일
  }
  sum <- sum + i
  print(paste(i,":",sum))
}

sumNumber <- 0
while(sumNumber <= 20) { 
  i <- sample(1:5, 1) 
  sumNumber <-sumNumber+i; 
  cat(sumNumber,"\n")
} 

repeat {      #무한루프
  cat("ㅋㅋㅋ\n")
}

sumNumber <- 0
repeat { 
  i <- sample(1:5, 1) 
  sumNumber <-sumNumber+i; 
  cat(sumNumber,"\n")
  if(sumNumber > 20)
    break;
}

#제어문
#if else
randomNum <-sample(1:10,1)
if(randomNum>5){
  cat(randomNum,":5보다 크군요","\n")
}else{
  cat(randomNum,":5보다 작거나 같군요","\n")
}

if(randomNum%%2 == 1){
  cat(randomNum,";홀수\n")
}else{
  cat(randomNum,";짝수","\n")
}


if(randomNum%%2 == 1){
  cat(randomNum,";홀수","\n")
}else{
  cat(randomNum,";짝수","\n")
}

score <- sample(0:100, 1)  # 0~100 숫자 한 개를 무작위로 뽑아서
if (score >=90){
  cat(score,"는 A등급입니다","\n")
}else if (score >=80){
  cat(score,"는 B등급입니다","\n")
}else if (score >=70){
  cat(score,"는 C등급입니다","\n")
}else if (score >=60){
  cat(score,"는 D등급입니다","\n")
}else {
  cat(score,"는 F등급입니다","\n")
}

#for문
#for 실습
for(data in month.name) 
  print(data)
for(data in month.name)print(data);print("ㅋㅋ")
for(data in month.name){print(data);print("ㅋㅋ")}

for(n in 1:5)
  cat("hello?","\n")

for(i in 1:5){
  for(j in 1:5){
    cat("i=",i,"j=",j,"\n")
  }
}
# 구구단
for(dan in 1:9){
  for(num in 1:9){
    cat(dan,"x",num,"=",dan*num,"\t") # \n : 개행문자, \t : 탭문자
  }
  cat("\n")
}


bb <- F  #JAVA의 label 기능은 없다. 변수지정 필요
for(i in 1:9){
  for(j in 1:9){
    if(i*j>30){
      bb<-T
      break
    } 
    cat(i,"*",j,"=",i*j,"\t")
  }
  cat("\n")
  if(bb) #bb가 TRUE이면
    break
}

#while문
i<-1
while(i <= 10){
  cat(i,"\n")
  i <- i+1
}
cat("종료 후 :",i,"\n")

i<-1
while (i<=10) {
  cat(i,"\n")
}

i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+2
}

i<-1
while (i<=10) {
  cat(i,"\n")
  i<-i+1
}

#switch 문을 대신하는 함수
month <- sample(1:12,1)
month <- paste(month,"월",sep="") # "3월"  "3 월"
result <- switch(EXPR=month,
                 "12월"=,"1월"=,"2월"="겨울",
                 "3월"=,"4월"=,"5월"="봄",
                 "6월"=,"7월"=,"8월"="여름",
                 "가을")
cat(month,"은 ",result,"입니다\n",sep="")

num <- sample(1:10,1)
num
switch(EXPR = num,"A","B","C","D")

for(num in 1:10){
  cat(num,":",switch(EXPR = num,"A","B","C","D"),"\n")
}

for(num in 1:10){
  num <- as.character(num) # paste0(num,"")
  cat(num,":",switch(EXPR = num,
                     "7"="A","8"="B","9"="C","10"="D","ㅋ"),"\n")
}

# 함수 정의와 활용

func1 <- function() {
  xx <- 10   # 지역변수
  yy <- 20
  return(xx*yy)
}
func1()

result <- func1()
result
xx  # 오류발생


func2 <- function(x,y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}

func2()
func2(5,6) # 식 : 연산식, 호출식, 변수, 리터럴

func3 <- function(x,y) {
  #x3 <- x+1
  #y3 <- y+1
  x4 <- func2(x+1, y+1)  # 값(식) : 변수, 리터럴, 연산식, 호출식
  return(x4)
}

func3(9, 19)  # 30

func4 <- function(x=100, y=200, z) {
  return(x+y+z)
}
func4()
func4(10,20,30)
func4(x=1,y=2,z=3)
func4(y=11,z=22,x=33)
func4(z=1000)  

# 쉬트에 있는 함수 코드
f1 <- function() print("TEST") #한줄짜리는 {} 불필요
f1()
r <- f1()
r

f2 <- function(num) {print("TEST"); print(num) }
f2(100)
f2()

f3<- function (p="R") print(p)
f3()
f3(p="PYTHON")
f3("java")

f4<- function (p1="ㅋㅋㅋ",p2) for(i in 1:p2) print(p1)
f4(p1="abc", p2=3)
f4("abc", 3) 
f4(5) 
f4(p2=5) 

f5<- function(...) { print("TEST"); data <- c(...); print(length(data))}
f5(10, 20, 30)
f5("abc", T, 10, 20)

f6 <-function(...) {
  print("수행시작")
  data<-c(...)
  for(item in data) {
    print(item)
  }
  return(length(data))
}
f6()
f6(10)
f6(10, 20, 30)
f6(10, 'abc', T, F)


f7 <-function(...){
  data <- c(...)  #벡터는 원소의 형이 강제 일치된다.
  sum <- 0
  for(item in data){
    if(is.numeric(item))
      sum <- sum+i
    else
      print(item)
  }
  return(sum)
}
f7(10,20,30)
f7(10,20,'test', 30,40)

f8<- function(...) {
  data <- list(...)  #list는 원소의 형이 자유롭다.
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}

f8(10,20,30)
f8(10,20,"test", 30,40)
