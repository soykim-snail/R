# 날짜와 시간 관련 기능을 지원하는 함수들

Sys.Date() # 문자열로 출력됨
Sys.time()

class(Sys.Date()) # Date 객체
class(Sys.time()) # POSIXct 객체 : 1970.1.1.0시부터 타임스탬프

as.Date("2020-04-15") # 반드시 연-월-일
as.Date("2020/04/15") # / 허용 
as.Date("2020,04,15") # ,나 . 인식 안됨
as.Date("15-04-2020") # 순서는 반드시 연-월-일

as.Date("2020,04,15", format="%Y,%m,%d") # 포맷문자열 지정하여 자유롭게
as.Date("15-04-2020", format="%d-%m-%Y")


(today <- Sys.Date())
format(today, "%Y년 %m월 %d일")
format(today, "%d일 %B %Y년")
format(today, "%y") # 년 2자리
format(today, "%Y") # 년 4자리
format(today, "%B") # 월 이름 
format(today, "%a") # 요일 짧게
format(today, "%A") # 요일 길게
weekdays(today) #요일
months(today) #월
quarters(today) #분기
unclass(today)  # 1970-01-01을 기준으로 얼마나 날짜가 지났지는 지의 값을 가지고 있다.
# unclass : 객체상태 해제
Sys.Date()
Sys.time()
Sys.timezone()

as.Date('1/15/2018',format='%m/%d/%Y') # format 은 생략 가능
as.Date('4월 26, 2018',format='%B %d, %Y')
as.Date('110228',format='%d%m%y')
as.Date('112월28', format='%d%b%y')

Sys.setlocale("LC_TIME", "English") # 날짜명 영어로
Sys.setlocale() # 다시 시스템 기본설정으로 원상복귀

x1 <- "2019-01-10 13:30:41"
# 문자열을 날짜형으로
as.Date(x1, "%Y-%m-%d %H:%M:%S") 
# 문자열을 날짜+시간형으로
strptime(x1, "%Y-%m-%d %H:%M:%S") # format 문자열 지정은 필수
strptime('2019-08-21 14:10:30', "%Y-%m-%d %H:%M:%S")

start <- as.Date("2020-01-01")
end <- as.Date("2021-01-01")
seq(start, end, 1) #sequence 만들기 by=1
seq(start, end, "day")
seq(start, end, "week")
seq(start, end, "month")
seq(start, end, "year")
seq(start, end, "3 month")
seq(start, end, length.out=7) # 구간을 만들다. 산출물의 길이 지정


x2 <- "20200601"
as.Date(x2, "%Y%m%d")
datetime<-strptime(x2, "%Y%m%d")
str(datetime) #POSIXlt 객체

# Date 객체는 날짜만 나타낼 수 있으며 시간처리 불가
# 날짜와 시간을 함께 처리하려면 POSIXct 또는 POSIXlt 타입의 객체 사용

pct <- as.POSIXct("2020/04/15 11:30:20")
plt <- as.POSIXlt("2020/04/15 11:30:20")
pct # 출력결과는 동일
plt # 출력결과는 동일
class(pct)
class(plt)
as.integer(pct) # 1970.1.1 0시 기준 초시간
as.integer(plt) # list 객체로 보관됨
unclass(plt) # 항목별 내용을 list로 보관함. unclass 해서 내용볼 수 있음
plt$sec
plt$min
plt$hour
plt$mday
plt$mon # 0 - 1월
plt$year # 1900을 빼고 표시
plt$wday # 0-일요일


t<-Sys.time()
ct<-as.POSIXct(t)
lt<-as.POSIXlt(t)
str(ct) 
str(lt) 
unclass(ct) 
unclass(lt) 
lt$mon+1
lt$hour
lt$year+1900
as.POSIXct(1449994438,origin="1970-01-01")
as.POSIXlt(1449994438,origin="1970-01-01")


#올해의 크리스마스 요일 2가지방법(요일명,숫자)
christmas2<-as.POSIXlt("2020-12-25")
weekdays(christmas2)
christmas2$wday
#2020년 1월 1일 어떤 요일
tmp<-as.POSIXct("2020-01-01")
weekdays(tmp)
#오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
tmp<-Sys.Date()
format(tmp,'오늘은 %Y년 %B %d일 %A입니다')
year<-format(tmp,'%Y')
month<-format(tmp,'%m')
day<-format(tmp,'%d')
weekday<-format(tmp,'%A')
paste("오늘은 ",year,"년 ",month,"월 ",day,"일 ",weekday," 입니다.",sep="")

as.Date("2020/01/01 08:00:00") - as.Date("2020/01/01 05:00:00")
as.POSIXct("2020/01/01 08:00:00") - as.POSIXct("2020/01/01 05:00:00")
as.POSIXlt("2020/01/01 08:00:00") - as.POSIXlt("2020/01/01 05:00:00")


# 문자열 처리 관련 주요 함수들

x <- "We have a dream"
nchar(x) # 문자의갯수. 공백도 카운트
length(x) # 벡터의 길이

y <- c("We", "have", "a", "dream")
length(y)
nchar(y)

letters
sort(letters, decreasing=TRUE)

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

substr("Data Analytics", start=1, stop=4)
substr("Data Analytics", 6, 14)
substring("Data Analytics", 6) # 특정 위치부터 끝까지

# 앞 네글자 뽑아내기
classname <- c("Data Analytics", "Data Mining", "Data Visualization")
substr(classname, 1, 4)

# 뒤 두글자 뽑아내기
countries <- c("Korea, KR", "United States, US", "China, CN")
substr(countries, nchar(countries)-1, nchar(countries))

# 정규표현식
data()
head(islands)
landmesses <- names(islands)
landmesses
grep(pattern="New", x=landmesses) # 패턴에 맞는 인덱스 찾음 (unix grep 명령어와 유사)

index <- grep("New", landmesses)
landmesses[index]
# 동일
grep("New", landmesses, value=T) # vlaue=T 값을 반환


txt <- "Data Analytics is useful. Data Analytics is also interesting."
sub(pattern="Data", replacement="Business", x=txt) # sub 첫번째만
gsub(pattern="Data", replacement="Business", x=txt) # gsub 전체 다

x <- c("test1.csv", "test2.csv", "test3.csv", "test4.csv")
gsub(".csv", "", x)

words <- c("ct", "at", "bat", "chick", "chae", "cat", 
           "cheanomeles", "chase", "chasse", "mychasse", 
           "cheap", "check", "cheese", "hat", "mycat")

grep("che", words, value=T)
grep("at", words, value=T)
grep("[ch]", words, value=T) # c 또는 h
grep("[at]", words, value=T) # a 또는 t
grep("ch|at", words, value=T) # ch 또는 at
grep("ch(e|i)ck", words, value=T) # check 또는 chick
grep("chase", words, value=T)
grep("chas?e", words, value=T) # ? : 0번 내지 1번
grep("chas*e", words, value=T) # * : 0번 이상
grep("chas+e", words, value=T) # + : 1번 이상
grep("ch(a*|e*)se", words, value=T)
grep("^c", words, value=T) # ^ : 시작하는
grep("t$", words, value=T) # $ : 끝나는
grep("^c.*t$", words, value=T) # c.....t

words2 <- c("12 Dec", "OK", "http//", 
            "<TITLE>Time?</TITLE>", 
            "12345", "Hi there")

grep("[[:alnum:]]", words2, value=TRUE)
grep("[[:alpha:]]", words2, value=TRUE)
grep("[[:digit:]]", words2, value=TRUE)
grep("[[:punct:]]", words2, value=TRUE)
grep("[[:space:]]", words2, value=TRUE)
grep("\\w", words2, value=TRUE)
grep("\\d", words2, value=TRUE)
grep("\\s", words2, value=TRUE)



fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x= fox.said, split= " ") # list로 리턴
strsplit(x= fox.said, split="") # list로 리턴

# list를 벡터로 변환하기
# 방법1 : unlist
fox.said.words <- unlist(strsplit(fox.said, " "))
fox.said.words
# 방법2 : 인덱스로 추출
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words

fox.said.words[3]

p1 <- "You come at four in the afternoon, than at there I shall begin to the  happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
littleprince <- c(p1, p2, p3)
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]] 
strsplit(littleprince, " ")[[3]][5]
