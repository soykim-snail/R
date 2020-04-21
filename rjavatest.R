library(dplyr)
pdf <- read.table("c:/soykim/R-study/data/product_click.log")
names(pdf) <- c("logdate", "product")
pdf <- pdf %>% select(product) %>% group_by(product) %>% summarise(clickcount = n()) %>% arrange(desc(clickcount)) %>% head(1)
pdf <- as.data.frame(pdf)

