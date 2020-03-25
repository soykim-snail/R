# iotest1.txt 파일에 저장된 데이터들을 읽고 다음과 같은 형식으로 결과를 출력하는
# R 코드를 구현하고 test1.R 로 저장하여 제출한다.
# 
# 오름차순 : ….
# 내림차순 : ….
# 합 : ...
# 평균 : ...      

num <- scan("data/iotest1.txt")
num
cat("오름차순 :", sort(num))
cat("내림차순 :", sort(num, decreasing = T))
cat("합 :", sum(num))
cat("평균 :", mean(num))
