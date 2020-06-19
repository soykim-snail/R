# 7-1
mpg <- ggplot2::mpg
mpg %>% mutate(total=cty+hwy) -> mpg1
# 7-2
mpg1 %>% mutate(mean=total/2) -> mpg2
# 7-3
mpg2 %>% arrange(desc(mean)) %>% head(3)
# 7-4
ggplot2::mpg %>% 
  mutate(total=cty+hwy) %>% 
  mutate(mean=total/2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

# 8-1
mpg %>% group_by(class) %>% summarise(m=mean(cty)) %>% 
# 8-2
  arrange(desc(m))
# 8-3
mpg %>% group_by(manufacturer) %>% summarise(m=mean(hwy)) %>% 
  arrange(desc(m)) %>% head(3)
# 8-4
mpg %>% group_by(manufacturer) %>% filter(class=='compact') %>% 
  summarise(n=n()) %>% 
  arrange(n)

# 9-1
fuel <- data.frame(fl=c('c', 'd', 'e', 'p', 'r'), 
                   price_fl=c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
left_join(mpg, fuel, by="fl") %>% 
  # 9-2
  select(model, fl, price_fl) %>% 
  head(5)

# 10-1
ggplot2::midwest %>% 
  mutate(ratio_nonault=1-popadults/poptotal) -> midwest2
  # 10-2
midwest2 %>% 
  arrange(desc(ratio_nonault))%>% 
  select(county, ratio_nonault) %>% 
  head(5)

# 10-3
midwest2 %>% 
  mutate(rank = ifelse(midwest2$ratio_nonault >= 0.4, "large", 
                                  ifelse(midwest2$ratio_nonault >= 0.3, "middle", "small"))) %>% 
  select(rank) %>% table

# 10-4
midwest2 %>% 
  mutate(ratio_asia = popasian/poptotal) %>% 
  arrange(ratio_asia) %>% 
  select(state, county, ratio_asia)

# 11-1
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), "hwy"] <- NA
table(is.na(mpg$drv))
table(is.na(mpg$hwy))
# 11-2
mpg %>% filter(!is.na(hwy)) %>% 
  group_by(drv) %>% summarise(m=mean(hwy)) %>% 
  arrange(desc(m))

# 12
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] <- "k"
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)
table(mpg$drv)


# 12-1
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% c('4', 'f', 'r'), mpg$drv, NA)
table(mpg$drv)
# 12-2
boxplot(mpg$cty)
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)
# 12-3
mpg %>% group_by(drv) %>% summarise(m=mean(cty, na.rm=T))
