### R

## day 11.

### 1. 날짜와  시간

* `Sys.Date()` :  Date obj
* `Sys.time()` : POSIXct obj
* `as.Date(x)` : 연-월-일, 연/월/일
  * `as.Date(x, format="xxxx")` : 
  * `%Y`, `%y`, `%m`, `%B`, `%b`, `%d`, `%A`, `%a`
* `strptime(x, format="xxxx")` : 문자열을 시간으로 변환, **format 문자열 지정 필수**
  * `%H`, `%M`, `%S`
  * `%Y`, `%y`, `%m`, `%B`, `%b`, `%d`, `%A`, `%a`
* `as.POSIXct("xxxxx")` : 연-월-일 시:분:초, 연/월/일 시:분:초
  * `as.POSIXct(x, format="xxxx")` 
* `as.POSIXlt("xxxxx")`
  * `as.POSIXlt(x, format="xxxx")`
* POSIX (Portable Operating System Interfaces)
  * 뜻 : UNIX 간 소통 가능한 프로그램 인터페이스의 규약
  * POSIXlt (list time) : list 형태
  * POSIXct (continuous time)
  * `as.integer(p)
* 문자열로 출력
  * `format(x, format="xxxx" )` : format 옵션에 맞게 출력
  * `weekdays(x)` :  요일 이름
  * `months(x)` : 월이름
  * `quarters(x)` : 분기
* format
  * `%H`, `%M`, `%S`
  * `%Y`, `%y`, `%m`, `%B`, `%b`, `%d`, `%A`, `%a`
* 타임존 세팅
  * `Sys.timezone()` : time zone 확인
  * `Sys.setlocale()` : 시스템 기본설정으로
    * `Sys.setlocale("LC_TIME", "English")` : 영문으로 설정
    * `Sys.getlocale()` : 설정 확인
* 시간으로 sequence 만들기
  * `seq(start, end, by=m)`
  * `seq(start, end, ["day"|"week"|"month"|"year"|"3 month"])`
  * `seq(start, end, length.out=n)` : 산출물의 길이 지정