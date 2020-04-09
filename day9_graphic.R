# 데이터 시각화
rainbow(10)

국어<- c(4,7,6,8,5,5,9,10,4,10)  
plot(국어)

plot(국어, type="o", col="blue")       # type: 산포도 타입    # col: 색깔지정
title(main="성적그래프", col.main="red", font.main=4)  #저수준 함수 추가 가능

국어 <- c(4,7,6,8,5,5,9,10,4,10)
수학 <- c(7,4,7,3,8,10,4,10,5,7)


plot(국어, type="o", col="blue")
lines(수학, type="o", pch=16, lty=2, col="red")     # 저수준 함수 추가 가능
title(main="성적그래프", col.main="red", font.main=4)

국어 <- c(4,7,6,8,5,5,9,10,4,10)
# par : 그래픽 파라메터 설정
par(mar=c(1,1,1,1), mfrow=c(4,2)) # mar : 상하좌우 마진, # mfrow : 레이아웃 나누기 (행개수, 열개수)

plot(국어, type="p", col="blue", main="type = p", xaxt="n", yaxt="n")
plot(국어, type="l", col="blue", main="type = l", xaxt="n", yaxt="n")
plot(국어, type="b", col="blue", main="type = b", xaxt="n", yaxt="n")
plot(국어, type="c", col="blue", main="type = c", xaxt="n", yaxt="n")
plot(국어, type="o", col="blue", main="type = o", xaxt="n", yaxt="n")
plot(국어, type="h", col="blue", main="type = h", xaxt="n", yaxt="n")
plot(국어, type="s", col="blue", main="type = s", xaxt="n", yaxt="n")
plot(국어, type="S", col="blue", main="type = S", xaxt="n", yaxt="n")

국어 <- c(4,7,6,8,5,5,9,10,4,10); 
수학 <- c(7,4,7,3,8,10,4,10,5,7)
par(mar=c(5,5,5,5), mfrow=c(1,1)) 
plot(국어, type="o", col="blue", ylim=c(0,10), axes=FALSE, ann=FALSE) # y limit 설정, axes 없이, 축라벨 없이

# x, y 축 추가하기
axis(1, at=1:10, lab=c("01","02","03","04", "05","06","07","08","09","10")) # 1: x축 추가
axis(2, at=c(0,2,4,6,8,10))  # 2: y축 추가

# 그래프 추가하고, 그래프에 박스 그리기
lines(수학, type="o", pch=16, lty=2, col="red")    
box()   # 박스 그리기

# 그래프 제목, 축의 제목, 범례 나타내기
title(main="성적그래프", col.main="red", font.main=4) 
title(xlab="학번", col.lab=rgb(0,1,0)) 
title(ylab="점수", col.lab=rgb(1,0,0)) 
legend(8, 3, c("국어","수학"), cex=0.8, col=c("blue","red"), pch=c(21,16), lty=c(1,2))  
# legend(출력위치 좌표값, ....)
# cex: 텍스트사이즈축소비율


(성적 <- read.table("data/성적.txt", header=TRUE))
# 첫째행은 헤더

plot(성적$학번, 성적$국어, main="성적그래프", xlab="학번", ylab="점수",  xlim=c(0, 11), ylim=c(0, 11)) 
# plot(x값, y값, ....)

ymax <- max(성적[3:5]) #성적 데이터 중에서 최대값을 찾는다(y 축의 크기 제한)
ymax
pcols<- c("red","blue","green")
png(filename="성적.png", height=400, width=700, bg="white") # 출력을 png파일로 설정. 출력디바이스 설정
plot(성적$국어, type="o", col=pcols[1], ylim=c(0, ymax), axes=FALSE, ann=FALSE)
axis(1, at=1:10, lab=c("01","02","03","04","05","06","07","08","09","10"))
axis(2, at=c(0,2,4,6,8,10), lab=c(0,2,4,6,8,10))
box()
lines(성적$수학, type="o", pch=16, lty=2, col=pcols[2])
lines(성적$영어, type="o", pch=23, lty=3, col=pcols[3] )
title(main="성적그래프", col.main="red", font.main=4)
title(xlab="학번", col.lab=rgb(1,0,0))
title(ylab="점수", col.lab=rgb(0,0,1))
legend(1, ymax, names(성적)[c(3,4,5)], cex=0.8, col=pcols, pch=c(21,16,23), lty=c(1,2,3))
dev.off() # 출력 디바이스 종료. 반드시!!!

plot(국어, 수학)
plot(수학~국어)

?plot

# 막대그래프 그리기

barplot(국어)

coldens <- seq(from=10, to=100, by=10)   # 막대그래프의 색밀도 설정을 위한 벡터
xname <- 성적$학번                                         # X 축 값 설정위한  벡터
barplot(성적$국어, main="성적그래프", xlab="학번", ylab="점수", 
          border="red", col="green", density=coldens, names.arg=xname)

# 학생의 각 과목에 대한 각각의 점수에 대한 그래프
성적1<- 성적[3:5] 
str(성적1)
par(mar=c(5,5,5,5), mfrow=c(1,1))
barplot(as.matrix(성적1), main="성적그래프", beside=T, ylab="점수", col=rainbow(10))
# beside=T 옆으로 그려라
# beside=F 디폴트 (세로로 쌓기)

par(mar=c(5,5,5,5), mfrow=c(1,2))
barplot(as.matrix(성적1), main="성적그래프", ylab="점수", col=rainbow(10))
barplot(t(성적1), main="성적그래프", ylab="점수", col=rainbow(10))

par(mar=c(5,5,5,5), mfrow=c(1,1))
# 학생의 각 과목에 대한 합계 점수에 대한 그래프
xname <- 성적$학번;    #  x축 레이블용 벡터
par(xpd=T, mar=par()$mar+c(0,0,0,4));   # 우측에 범례가 들어갈 여백을 확보
barplot(t(성적1), main="성적그래프", ylab="점수", col=rainbow(3), space=0.1, cex.axis=0.8, names.arg=xname, cex=0.8)
legend(11,30, names(성적1), cex=0.8, fill=rainbow(3));

par(xpd=T, mar=c(5,5,5,5));   # 우측에 범례가 들어갈 여백을 확보
barplot(t(성적1), main="성적그래프", ylab="점수", col=rainbow(3), space=0.1, cex.axis=0.8, names.arg=xname, cex=0.8)
legend(11,30, names(성적1), cex=0.8, fill=rainbow(3));


# 학생의 각 과목에 대한 합계 점수에 대한 그래프(가로막대 그래프)
xname <- 성적$학번;    #  x축 레이블용 벡터
barplot(t(성적1), main="성적그래프", ylab="학번", col=rainbow(3), space=0.1, cex.axis=2.0, names.arg=xname,cex.lab=3.0, horiz=T);
# t(): 전치행렬, # horiz=T 가로막대
legend(30,11, names(성적1), cex=0.8, fill=rainbow(3))

?barplot


# 파이그래프
(성적 <- read.table("data/성적.txt", header=TRUE));
pie(성적$국어, labels=paste(성적$성명, "-", 성적$국어), col=rainbow(10)) # 디폴트: 3시에서 반시계 방향으로 그려짐
pie(성적$국어, clockwise=T, labels=paste(성적$성명, "-", 성적$국어), col=rainbow(10))
pie(성적$국어, density=10, clockwise=T, labels=paste(성적$성명, "-", 성적$국어), col=rainbow(10)) 
# clockwise=T: 12시부터 시계 방향으로
pie(성적$국어, labels=paste(성적$성명, "-", 성적$국어), col=rainbow(10), main="국어성적", edges=10)
pie(성적$국어, labels=paste(성적$성명,"\n","(",성적$국어,")"), col=rainbow(10))
pie(rep(1, 24), col = rainbow(24), radius = 0.5)


# 히스토그램
hist(성적$국어, main="성적분포-국어", 
       xlab="점수", breaks=5,    # breaks=5 지정했으나 부적합해서 감안해서 최적화
       col = "lightblue", border = "pink")
hist(성적$수학, main="성적분포-수학", 
       xlab="점수", col = "lightblue", 
       breaks=2, border = "pink")  # breaks=2 설정 (구간을 2개로 나눔)
hist(성적$국어, main="성적분포-국어",   # breaks 설정을 하지 않을 때 (자동 최적화)
       xlab="점수", ylab="도수", 
       col=rainbow(12), border = "pink")

nums <- sample(1:100, 30)
hist(nums)
hist(nums, breaks=c(0,10,20,30,40,50,60,70,80,90,100)) # 구간설정을 구체적 설정 가능
hist(nums, breaks=c(0,50,100), probability = T) # probability=T 확률분포(density)로 표현
hist(nums, breaks=c(0,33,66,100))


# 박스플롯
summary(성적$국어)
boxplot(성적$국어, col="yellow",  ylim=c(0,10), xlab="국어", ylab="성적")


성적2 <- 성적[,3:5]
boxplot(성적2, col=rainbow(3), ylim=c(0,10), ylab="성적")

data <- read.table("data/온도.txt", header=TRUE, sep=",")
head(data, n=5); 
boxplot(data)
boxplot(data, las = 2) # las=2: 라벨을 세로로
boxplot(data, las = 2, at = c(1,2,3,4, 6,7,8,9, 11,12,13,14)) # 막대들을 그루핑
chtcols = rep(c("red","sienna","palevioletred1","royalblue2"), times=3)
chtcols
boxplot(data, las = 2, at = c(1,2,3,4, 6,7,8,9, 11,12,13,14), col=chtcols)
grid(col="gray", lty=2, lwd=1) # 그리드 추가

rainbow()
heat.colors()
terrain.colors()
topo.colors()
cm.colors()
gray.colors()

# 그래프 저장하기
dev.copy(png, "mytest.png")
dev.off()
