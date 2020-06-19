# [ 문제1 ]
# 다음 사양의 함수 countEvenOdd() 을 생성한다.
# 매개변수 : 1 개
# 리턴값 : 리스트
# 기능 : 숫자벡터를 아규먼트로 받아 짝수의 갯수와 홀수의 갯수를 카운팅하여 
# 리스트(각 변수명 : even, odd)로 리턴한다.
# 전달된 데이터가 숫자 백터가 아니면 NULL 을 리턴한다.
countEvenOdd <- function(x){
  if(is.vector(x) & all(is.numeric(x))){
    odd <- sum(x %% 2)
    even <- length(x)-odd
    return(list(even=even, odd=odd) )
  } 
  else 
    return()
}
countEvenOdd(c(1,2,3,4))
countEvenOdd(c(1, "test"))


# [ 문제2 ]
# 다음 사양의 함수 vmSum() 을 생성한다.
# 매개변수 : 1 개
# 리턴 값 : 숫자벡터
# 기능 : 전달받은 아규먼트가 벡터인 경우에만 기능을 수행한다.
# 벡터가 아니면 “벡터만 전달하숑!”라는 메시지를 리턴한다.
# 벡터라 하더라도 숫자 벡터가 아니면 “숫자 벡터를 전달하숑!” 라는
# 메시지를 출력하고 0 을 리턴한다.
# 전달된 숫자 벡터의 모든 값을 더하여 리턴한다.
vmSum <- function(x){
  if(!is.vector(x))
    return("벡터만 전달하숑!")
  else{
    if(!is.numeric(x)){
      print("숫자 벡터를 전달하숑!")
      return(0)
    } else
      return(sum(x))
  } 
}
vmSum(c(1,2,3))
vmSum(c(T,F))
vmSum()
vmSum(matrix(1:10, nrow=5))
vmSum(c()); vmSum(NULL); 
vmSum(NA); vmSum("test")


# [ 문제3 ]
# 다음 사양의 함수 vmSum2() 을 생성한다.
# 
# 매개변수 : 1 개
# 리턴 값 : 숫자벡터
# 기능 : 전달받은 아규먼트가 벡터인 경우에만 기능을 수행한다.
# 벡터가 아니면 “벡터만 전달하숑!”라는 메시지를 가지고 error 를 발생시킨다.
# 벡터라 하더라도 숫자 벡터가 아니면 “숫자 벡터를 전달하숑!” 라는 
# 메시지를 가지고 warning 을 발생시키고 0 을 리턴한다.
# 전달된 숫자 벡터의 모든 값을 더하여 리턴한다.
vmSum2 <- function(x){
  if(!is.vector(x))
    stop("벡터만 전달하숑!")
  else {
    if(!is.numeric(x)){
      warning("숫자 벡터를 전달하숑!")
      return(0)
    } else
      return(sum(x))
  }
}
vmSum2(1:3)
vmSum2(NULL)
vmSum2(c("test", 1, 2))
vmSum2(NA)
vmSum2(c(1,2))



# [ 문제4 ]
# 다음의 기능을 지원하는 함수 mySum()을 생성한다.
# 
# 아규먼트 : 벡터 한 개
# 리턴값 : 리스트 한 개 또는 NULL
# 
# (1) 전달된 벡터에서 짝수번째 데이터들의 합과 홀수번째 데이터들의 합을 구하여 
# list 객체로 리턴하는데 각각 oddSum과 evenSum 이라고 변수명을 설정한다.
# 
# (2) 벡터가 온 경우에만 기능을 수행하며 벡터가 오지 않은 경우에는 "벡터만 처리 가능!!"이라는
# 메시지로 에러를 발생시킨다.
# 
# (3) 전달된 벡터에 NA 값이 하나라도 존재하는 경우에는 "NA를 최저값으로 변경하여 처리함!!" 이라는 
# 메시지를 경고를 발생시킨다. 그리고 NA 는 최저값으로 설정하여 기능을 수행한 후에 결과를 리턴한다.
# 
# (4) NULL이 온 경우에는 NULL을 리턴한다.

mySum <- function(x=NULL){
  if(is.null(x))
    return()
  if(!is.vector(x) | is.list(x))
    stop("벡터만 처리가능!")
  
  if(any(is.na(x))){
    warning("NA를 최저값으로 변경하여 처리함!")
    for(i in 1:length(x)){
      x[i] <- ifelse(is.na(x[i]), min(x, na.rm=T), x[i])
      print(x[i])
    }
  }
  oddSum <- sum(x[c(T,F)])
  evenSum <-  sum(x[c(F,T)])
  return(list(oddSum=oddSum, evenSum=evenSum))
}
mySum(c(1,2,3))
mySum(c(1,NA,3))  
mySum(c(1,2,3))
mySum(list(1,2))
mySum(c());mySum();mySum(NULL)

# [ 문제5 ]
# 다음의 기능을 지원하는 함수 myExpr()을 생성한다.
# 
# 아규먼트 : 함수 한 개
# 리턴값 : 한 개의 숫자값
# 
# (1) 아규먼트로 함수를 전달받는다. 
# (2) 아규먼트가 함수가 아니면 "수행 안할꺼임!!" 
# 이라는 메시지로 에러를 발생시킨다.
# (3) 1부터 45 사이의 난수 6개를 추출하여 
# 아규먼트로 전달된 함수를 호출하고 그 결과를
# 리턴한다.

myExpr <- function(x){
  if(!is.function(x))  
    stop("수행 안할꺼임!")
  data <- sample(1:45, 6, replace = T)
  return(x(data))
}
myExpr(mean)
myExpr(sum);myExpr(sum);myExpr(sum)
myExpr(summary)
myExpr(plot)

# [ 문제6 ]
# 다음 사양의 함수 createVector1() 을 생성한다.
# 
# 아규먼트 : 가변(숫자, 문자열, 논리형(데이터 타입의 제한이 없다.))
# 리턴 값 : 벡터
# 
# (1) 전달된 아규먼트가 없으면 NULL을 리턴한다.
# (2) 전달된 아규먼트에 하나라도 NA 가 있으면 NA를 리턴한다.
# (3) 전달된 데이터들을 가지고 벡터를 생성하여 리턴한다.
createVector1 <- function(...){
  p <- c(...)
  if(length(p)<1)
    return()
  if(any(is.na(p)))
    return(NA)
  return(p)
}
createVector1();createVector1(NULL);
createVector1(1,2,3);createVector1(T,1,2);createVector1(F,1);
createVector1("test", 1, 2);createVector1("test", T, 1);

[ 문제7 ]
다음 사양의 함수 createVector2() 을 생성한다.
매개변수 : 가변(숫자, 문자열, 논리형(데이터 타입의 제한이 없다.))
리턴 값 : 리스트객체
기능 : 전달된 아규먼트가 없으면 NULL을 리턴한다.
전달된 데이터들을 각 타입에 알맞게 각각의 벡터들을 만들고 
리스트에 담아서 리턴한다.
createVector2 <- function(...){
  p <- list(...)
  if(length(p)==0)
    return()
  num.vec <- c()
  cha.vec <- c()
  log.vec <- c()
  for(data in p) 
    switch(EXPR = class(data), 
           "numeric"= {num.vec <- append(num.vec, data)},
           "character"= {cha.vec <- append(cha.vec, data)},
           "logical"= {log.vec <- append(log.vec, data)})
  return(list(
    num = num.vec,
    cha = cha.vec,
    log = log.vec
  ))
}
createVector2(1, "test", T, T)
createVector2()

