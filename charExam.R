# [ 기본 그래프 그려보기 ]
# 
# 문제1. 
# 제품당 클릭 갯수에 대한 데이터를 가지고 다음 조건으로 그래프를 그린다.
# 세로 바 그래프를 그리는데... 				
# 칼라는 terrain.colors 칼라로 설정한다.
# 그래프 메인 제목 : "세로바 그래프 실습"
# clicklog1.png 에 저장한다.

par(mar=c(5,5,5,5), mfrow=c(1,1))

data <- read.table('data/product_click.log')
fq_data <- summary(data$V2)
barplot(fq_data, las=1, col = terrain.colors(length(fq_data)), 
        main = '세로바 그래프 실습', cex.main = 1,
        xlab='상품ID', ylab='클릭수', cex.lab = 0.8,
        cex.axis = 0.6, cex = 0.5)
dev.copy(png, 'clicklog1.png')
dev.off()

# 문제 2. 
# 상품이 클릭된 시간 정보를 가지고 다음 조건의 그래프를 그린다.  
# 파이그래프를 그리는데...				
# 칼라는 자율이다. 
# 그래프 메인 제목 : "파이그래프 실습"
# clicklog2.png 에 저장한다.

png('clicklog2.png', 400, 400 )
p_data <- sapply(data$V1, function(x) as.numeric(substr(x, 9, 10)))
pie_data <- summary(factor(p_data, levels=0:23))
p_lab <- paste0(0:23, ' ~ ', 1:24)
pie(pie_data, main = '파이그래프 실습', 
    labels = p_lab, col = rainbow(length(pie_data)))
dev.off()

  
