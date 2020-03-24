# # 제어문
# [문제1]
# 1. grade 라는 변수에 1부터 6사이의 난수를 추출하여 저장한다. 
# 2. grade 의 값이 1 또는 2 또는 3이면 다음 결과를 출력한다.
# "x 학년은 저학년입니다."
# grade 의 값이 4 또는 5 또는 6이면 다음 결과를 출력한다.
# "x 학년은 고학년입니다."
grade <- sample(1:6, 1, replace = T)
level <- switch (EXPR = grade, 
        '저','저','저',
        '고','고','고'
)
paste0(grade, '학년은 ', level, '학년입니다.')

# [문제2]
# 1. choice 라는 변수에 1부터 5사이의 난수를 추출하여 저장한다.
# 2. 추출된 값이 1이면 300 과 50 의 덧셈 연산을 처리한다.
# 추출된 값이 2이면 300 과 50 의 뺄셈 연산을 처리한다.
# 추출된 값이 3이면 300 과 50 의 곱셈 연산을 처리한다.
# 추출된 값이 4이면 300 과 50 의 나눗셈 연산을 처리한다.
# 추출된 값이 5이면 300 과 50 의 나머지 연산을 처리한다.
# 
# 3. 출력 형식(단, 출력문장은 한 번만 구현한다.)
# 결과값 : XX
choice <- sample(1:5, 1, replace = T)
cat("결과값 :", 
    switch (EXPR= choice, 
        300+50,
        300-50,
        300*50,
        300/50,
        300%%50
))

 
# [문제3]
# 1. count 라는 변수에 3부터 10사이의 난수를 추출하여 저장한다. 
# 2. 1부터 3사이의 난수를 추출한다.(deco)
# 3. deco가 1이면 "*"을  count 값만큼 출력한다.
# deco가  2이면 "$"을  count 값만큼 출력한다.
# deco가  3이면 "#"을  count 값만큼 출력한다.
count <- sample(3:10, 1, replace=T)
deco <- sample(1:3, 1, replace=T)
switch(EXPR = deco,
       for(i in 1:count) cat("*"),
       for(i in 1:count) cat("$"),
       for(i in 1:count) cat("#")
       )

 
# [문제4] – switch() 함수로 문제를 해결한다.
# 1. score 라는 변수에 0~100 사이의 난수를 저장한다.
# 2. score 의 값이 90~100 이면 level 변수에 “A 등급”을 저장한다.
# score 의 값이 80~89 이면 level 변수에 “B 등급”을 저장한다.
# score 의 값이 70~79 이면 level 변수에 “C 등급”을 저장한다.
# score 의 값이 60~69 이면 level 변수에 “D 등급”을 저장한다.
# score 의 값이 59 이하면 level 변수에 “F 등급”을 저장한다.
# 3. 결과를 다음 형식으로 출력한다.
# “xx 점은 x 등급입니다.”
score <- sample(0:100, 1, replace=T)
temp <- as.character(score %/% 10)
level <- switch (EXPR=temp,
                 "10"=, "9"="A등급",
                 "8"="B등급",
                 "7"="C등급",
                 "6"="D등급",
                 "F등급")
cat(score, "점은", level, "입니다.")


# [문제5] 제어문 사용이 필수는 아님 (^^)
# 다음과 같이 영문자 대문자와 소문자로 구성되는 원소들을 갖는 벡터 alpha 를 생성하여 벡터의 내용을 화면에 출력한다.
# “Aa” “Bb” …………………….. “Zz”

#방법1
(alpha <- paste0(LETTERS, letters))

#방법2
alpha <- NULL
for(i in 1:length(LETTERS))
  alpha <- append(alpha,paste(LETTERS[i], letters[i], sep=""))
print(alpha)

#방법3
for(i in 1:length(LETTERS))
  alpha[i] <- paste(LETTERS[i], letters[i], sep="")
print(alpha)
