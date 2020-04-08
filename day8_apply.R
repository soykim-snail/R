# apply 계열의 함수를 알아보자
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F","M","M","F","F")

df <- data.frame(w=weight, h=height)
df

apply(df, 1, sum, na.rm=TRUE) # 함수 뒤에 오는 아규먼트는 (여기서는 na.rm=T 조건) 함수에 적용함
apply(df, 2, sum, na.rm=TRUE)
lapply(df, sum, na.rm=TRUE) # dataframe에 대해서는 항상 열단위로 적용, LIST로 리턴
sapply(df, sum, na.rm=TRUE) # 가능한 간단포맷으로 리턴
tapply(1:6, gender, sum, na.rm=TRUE) # 데이터셋, 그루핑조건, 함수, 옵션션
tapply(df$w, gender, mean, na.rm=TRUE)
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5]) # 함수, 데이터셋 여러개개
v<-c("abc", "DEF", "TwT")
sapply(v, function(d) paste("-",d,"-", sep=""))  # named vector 반환되었음.
# 수행문장이 하나면 {} 생략가능. 
# 함수 내에서 return() 호출이 없으면 마지막에 리턴된 결과를 반환한다.

l<-list("abc", "DEF", "TwT")
sapply(l, function(d) paste("-",d,"-", sep="")) # un-named vector 반환되었음.
lapply(l, function(d) paste("-",d,"-", sep="")) # list 반환되었음.

flower <- c("rose", "iris", "sunflower", "anemone", "tulip")
length(flower) # 원소 개수
nchar(flower) # 각각 문자 갯수
sapply(flower, function(d) if(nchar(d) > 5) return(d)) # list 반환되었음.
sapply(flower, function(d) if(nchar(d) > 5) d) # 위와 동일한 결과임.
sapply(flower, function(d) if(nchar(d) > 5) return(d) else return(NA)) # named vector 반환되었음.
sapply(flower, function(d) paste("-",d,"-", sep="")) # named vector 반환되었음.
sapply(flower, function(d, n) if(nchar(d) > n) return(d), 4) # 함수 뒤에 오는 아규먼트는 함수에 적용됨.
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), 4)
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d))

count <- 1
myf <- function(x, wt=T){
  print(paste(x,"(",count,")"))
  Sys.sleep(3)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}
result <- sapply(df$w, myf)
length(result)
result
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)

count <- 1
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"] 