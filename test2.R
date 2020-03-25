# iotest2.txt 파일에 저장된 데이터들을 읽고 다음과 같은 형식으로 결과를 출력하는
# R 코드를 구현하고 test2.R 로 저장하여 제출한다.
# 
# “가장 많이 등장한 단어는 XX 입니다.”

data <-scan("data/iotest2.txt", what="")
data <-factor(data)
word <- names(which.max(summary(data)))
paste("가장 많이 등장한 단어는", word , "입니다.")

#참고
# data <-scan("data/iotest2.txt", what="")
# table(data) #factor 아니어도 table은 빈도수 세준다.

