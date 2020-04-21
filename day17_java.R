# Rserve 패키지  (바이너리 R 서버 프로그램) : 
#   Java, C, C++, PHP 등 다른 언어에서 TCP/IP로 R에 원격 접속, 인증, 파일전송을 가능하게 해 준다.
install.packages("RServe")

# rJava 패키지 :
#   Java 언어로 R 사용할 때 필요한 기본 API를 담고 있음
install.packages("rJava")

# Rserve 기동 :
## 방법 1 : R 스튜디오에서 함수호출 ---> 에러확인 곤란
Rserve(args="--RS-encoding utf8")
## 방법 2 : cmd 창에서 단독으로 기동 ---> 오류 메세지 확인 가능
# C:\Program Files\R\R-3.6.3\bin\x64>Rserve --RS-encoding utf8

###################################################
# 자바프로젝트 Maven 설정
# pom.xml 파일에 디펜던시 설정추가
# ################################################
# <dependency>
#   <groupId>com.github.lucarosellini.rJava</groupId>
#   <artifactId>JRIEngine</artifactId>
#   <version>0.9-7</version>
# </dependency>
# <dependency>
#   <groupId>net.rforge</groupId>
#   <artifactId>Rserve</artifactId>
#   <version>0.6 8.1</version>
# </dependency>
###################################################

## 실습용 참고
### 우선 Java에서 RConnection 객체 (ex: rc) 생성하고....
R.version.string
s <- "가나다"
x <- s    # rc.assign("x", s)
y <- "가나다"  # rc.eval("y <-'" + s + "'")
if(x == '가나다') print('XXX') # rc.eval("if(x == '가나다') print('XXX')")
if(y == '가나다') print('YYY') # rc.eval("if(y == '가나다') print('YYY')")
Encoding(x) <- 'UTF-8'   # assign 함수 사용시는 인코딩설정 변경으로~~
y <- iconv(y, from = 'CP949', to = 'UTF-8') # eval 함수 사용시는 컨버팅 방법으로~~
paste(R.version.string, x, y)
